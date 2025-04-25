local jdk = os.getenv("JDK21")
local cache = os.getenv("XDG_CACHE_HOME") .. "/eclipse/"
local repo = os.getenv("XDG_DATA_HOME") .. "/repo"

local dap_ok, dap = pcall(require, "dap")
local jdtls_ok, jdtls = pcall(require, "jdtls")
local jdtls_launcher_path = vim.fn.glob(repo .. "/jdtls/plugins/org.eclipse.equinox.launcher_*.jar")

if not dap_ok or not jdtls_ok then
  return
end

if not vim.fn.isdirectory(cache) then
  vim.fn.mkdir(cache, "p")
end
if not vim.fn.isdirectory(repo) then
  vim.fn.mkdir(repo, "p")
end

-- Set up rood directory(If not found never cancel)
local root_dir = vim.fs.root(0, { "gradlew", "mvnw", ".git", "pom.xml" }) or vim.fs.root(0, {})
if not root_dir then
  return
end

local config = {

  root_dir = root_dir,

  settings = {
    java = {
      home = jdk,
      format = {
        comments = { enabled = true },
        enabled = true,
        insertSpaces = true,
        tabSize = 3,
        settings = {
          url = vim.fn.stdpath("config") .. "/language-style/eclipse-java-google-style.xml",
          profile = "GoogleStyle",
        },
      },
      eclipse = { downloadSource = true },
      errors = { incompleteClasspath = { severity = "warning" } },
      maxConcurrentBuilds = 5,
      executeCommand = { enabled = true },
      foldingRange = { enabled = true },
      maven = { downloadSources = true, updateSnapshots = true },
      -- project = { referencedLibraries = {}, sourcePaths = {}, resourceFilters = {}, },
      implementationsCodeLens = { downloadSources = true },
      import = {
        gradle = {
          annotationProcessing = { enabled = true },
          enabled = true,
        },
        maven = {
          enabled = true,
        },
        exclusions = {
          "**/node_modules/**",
          "**/.metadata/**",
          "**/archetype-resources/**",
          "**/META-INF/maven/**",
          "/**/test/**",
        },
      },
      jdt = {
        ls = {
          androidSupport = { enabled = false },
          lombokSupport = { enabled = true },
          protofBufSupport = { enabled = true },
        },
      },
      signatureHelp = {
        enabled = true,
        description = { enabled = true },
      },
      contentProvider = { preferred = "fernflower" },
      saveActions = { organizeImports = true },
      completion = {
        enabled = true,
        favoriteStaticMembers = {
          "io.crate.testing.Asserts.assertThat",
          "org.assertj.core.api.Assertions.assertThat",
          "org.assertj.core.api.Assertions.assertThatThrownBy",
          "org.assertj.core.api.Assertions.catchThrowable",
          "org.hamcrest.MatcherAssert.assertThat",
          "org.hamcrest.Matchers.*",
          "org.hamcrest.CoreMatchers.*",
          "org.junit.jupiter.api.Assertions.*",
          "java.util.Objects.requireNonNull",
          "java.util.Objects.requireNonNullElse",
          "org.mockito.Mockito.*",
        },
        filteredTypes = {
          "com.sun.*",
          "io.micrometer.shaded.*",
          "java.awt.*",
          "jdk.*",
          "sun.*",
        },
        guessMethodArguments = true,
        importOrder = { "java", "jakarta", "javax", "org", "com" },
      },
      sources = { organizeImports = { starThreshold = 9999, staticThreshold = 9999 } },
      symbols = { includeSourceMethodDeclarations = true },
      codeGeneration = {
        generateComments = true,
        toString = { template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}" },
        hashCodeEquals = { useJava7Objects = false, useInstanceOf = true },
        useBlocks = true,
      },
      configuration = {
        maven = {
          userSettings = "/home/aries/.m2/settings.xml",
          globalSettings = "/usr/share/java/maven/conf/settings.xml",
        },
        updateBuildConfiguration = "interactive",
        runtimes = {
          -- { name = "JavaSE-24", path = os.getenv("JDK24") },
          { name = "JavaSE-17", path = os.getenv("JDK17") },
          { name = "JavaSE-1.8", path = os.getenv("JDK8") },
          {
            name = "JavaSE-21",
            path = os.getenv("JDK21"),
            sources = os.getenv("JDK21_SRC"),
            javadoc = "/usr/share/doc/java21-openjdk/api",
            default = true,
          },
        },
      },
      referencesCodeLens = { enabled = true },
      references = { includeAccessors = true, includeDecompiledSources = true },
      rename = { enabled = true },
      edit = {
        validateAllOpenBuffersOnChanges = true,
      },
      selectionRange = { enabled = true },
      template = {
        fileHeader = {},
        typeComment = {},
      },
      inlayHints = { parameterNames = { enabled = "all" } },
    },
  },
  cmd = {
    jdk .. "/bin/java",
    -- "-Dlogging.config=/dev/null",
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-Xmx1g",
    "--add-modules=ALL-SYSTEM",
    "--add-opens",
    "java.base/java.util=ALL-UNNAMED",
    "--add-opens",
    "java.base/java.lang=ALL-UNNAMED",
    "--enable-native-access=ALL-UNNAMED",
    "-javaagent:" .. repo .. "/lombok/lombok.jar",
    "-jar",
    jdtls_launcher_path,
    "-configuration",
    repo .. "/jdtls/config_linux",
    "-data",
    cache .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t"),
  },
}

local capabilities = {
  workspace = {
    workspaceEdit = { snippetEditSupport = true, changeAnnotationSupport = { groupsOnLabel = false } },
    fileOperations = { didRename = true, willRename = true },
    didChangeWorkspaceFolders = { dynamicRegistration = true },
  },
  textDocument = {
    completion = { completionItem = { snippetSupport = true } },
    rename = { prepareSupport = true, dynamicRegistration = false },
  },
}
capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)
config.capabilities = capabilities

config.on_attach = function(client, bufnr)
  vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
  jdtls.jol_path = repo .. "/openjdk/jol/jol-cli-latest.jar"
  jdtls.setup_dap()

  vim.lsp.codelens.refresh()
  vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = { "*.java" },
    callback = function()
      pcall(vim.lsp.codelens.refresh)
    end,
  })

  local map = function(mode, lhs, rhs, desc, opts)
    opts = opts or {}
    opts.desc = desc
    vim.keymap.set(mode, lhs, rhs, opts)
  end
  local opts = { silent = true, buffer = bufnr }

  map("n", "<leader>jo", "<Cmd>lua require'jdtls'.organize_imports()<CR>", "Organize imports", opts)
  map("v", "<leader>jv", "<Esc><Cmd>lua require'jdtls'.extract_variable(true)<CR>", "Extract variable", opts)
  map("n", "<leader>jv", "<Cmd>lua require'jdtls'.extract_variable(true)<CR>", "Extract variable", opts)
  map("n", "<leader>jc", "<Cmd>lua require'jdtls'.extract_constant()<CR>", "Extract constant", opts)
  map("v", "<leader>jc", "<Esc><Cmd>lua require'jdtls'.extract_constant(true)<CR>", "Extract Constant", opts)
  map("v", "<leader>jm", "<Esc><Cmd>lua require'jdtls'.extract_method(true)<CR>", "Extract Method", opts)
  map("n", "<leader>ji", "<Cmd>lua require('jdtls').super_implementation()<CR>", "Method super implementation", opts)
  map("n", "<leader>jt", "<Cmd> lua require('jdtls').test_nearest_method()<CR>", "Test nearest method", opts)
  map("v", "<leader>jt", "<Esc><Cmd>lua require('jdtls').test_nearest_method(true)<CR>", "Test nearest method")
  map("n", "<leader>jT", "<Cmd> lua require('jdtls').test_class()<CR>", "Test class", opts)
  map("n", "<leader>ju", "<Cmd>JdtUpdateConfig<CR>", "Update config")
  map("n", "<leader>jU", "<Cmd>JdtUpdateDebugConfig<CR>", "Update debug config")

  map("n", "<leader>jgo", "<Cmd>lua require('jdtls.tests').goto_subjects()<CR>", "Goto tests")
  map("n", "<leader>jge", "<Cmd>lua require('jdtls.tests').generate()<CR>", "Generate tests")
  vim.cmd("command! JdtBuild lua require('jdtls').build_projects()")
end

local jar_patterns = {
  "/microsoft/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar",
  "/dgileadi/vscode-java-decompiler/server/*.jar",
  "/microsoft/vscode-java-test/java-extension/com.microsoft.java.test.plugin/target/*.jar",
  "/microsoft/vscode-java-test/java-extension/com.microsoft.java.test.runner/target/*.jar",
  "/microsoft/vscode-java-test/java-extension/com.microsoft.java.test.plugin.site/target/repository/plugins/junit-jupiter-*.jar",
  "/microsoft/vscode-java-test/java-extension/com.microsoft.java.test.plugin.site/target/repository/plugins/junit-platform-*.jar",
  "/microsoft/vscode-java-test/java-extension/com.microsoft.java.test.plugin.site/target/repository/plugins/junit-vintage-engine_*.jar",
  "/microsoft/vscode-java-test/java-extension/com.microsoft.java.test.plugin.site/target/repository/plugins/org.opentest4j*.jar",
  "/microsoft/vscode-java-test/java-extension/com.microsoft.java.test.plugin.site/target/repository/plugins/org.apiguardian.api_*.jar",
  "/microsoft/vscode-java-test/java-extension/com.microsoft.java.test.plugin.site/target/repository/plugins/org.eclipse.jdt.junit4.runtime_*.jar",
  "/microsoft/vscode-java-test/java-extension/com.microsoft.java.test.plugin.site/target/repository/plugins/org.eclipse.jdt.junit5.runtime_*.jar",
  "/microsoft/vscode-java-test/java-extension/com.microsoft.java.test.plugin.site/target/repository/plugins/org.opentest4j_*.jar",
  "/microsoft/vscode-java-test/java-extension/com.microsoft.java.test.plugin.site/target/repository/plugins/org.jacoco.*.jar",
}

local bundles = {}
for _, jar_pattern in ipairs(jar_patterns) do
  for _, bundle in ipairs(vim.split(vim.fn.glob(repo .. jar_pattern), "\n")) do
    if
      not vim.endswith(bundle, "com.microsoft.java.test.runner-jar-with-dependencies.jar")
      and not vim.endswith(bundle, "com.microsoft.java.test.runner.jar")
    then
      table.insert(bundles, bundle)
    end
  end
end

local extendedClientCapabilities = jdtls.extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true
-- extendedClientCapabilities.advancedOrganizeImportsSupport = true
-- extendedClientCapabilities.actionableRuntimeNotificationSupport = true
-- extendedClientCapabilities.hashCodeEqualsPromptSupport = true
extendedClientCapabilities.onCompletionItemSelectedCommand = "editor.action.triggerParameterHints"
extendedClientCapabilities.snippetEditSupport = true
-- extendedClientCapabilities.advancedExtractRefactoringSupport = true
-- extendedClientCapabilities.advancedGenerateAccessorsSupport = true
-- extendedClientCapabilities.extractInterfaceSupport = true
-- extendedClientCapabilities.advancedIntroduceParameterRefactoringSupport = true
-- extendedClientCapabilities.clientHoverProvider = true
-- extendedClientCapabilities.clientDocumentSymbolProvider = true
-- extendedClientCapabilities.actionableNotificationSupported = true
config.init_options = {
  bundles = bundles,
  extendedClientCapabilities = extendedClientCapabilities,
}

jdtls.start_or_attach(config)
