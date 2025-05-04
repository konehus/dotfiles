require("lazydev").setup()
vim.diagnostic.config({
  float = { border = "single" },
  underline = true,
  update_in_insert = false,
  virtual_text = {
    spacing = 4,
    source = "if_many",
    prefix = "●",
  },
  severity_sort = true,
})

local servers = {
  marksman = {},
  basedpyright = {
    settings = {
      basedpyright = {
        typeCheckingMode = "off",
      },
    },
  },
  harper_ls = {
    filetypes = { "markdown", "html" },
    settings = {
      ["harper-ls"] = {
        linters = {
          spell_check = false,
          sentence_capitalization = false,
        },
      },
    },
  },
  lemminx = {
    filetypes = { "xml", "xsd", "xsl", "xslt", "svg" },
    root_dir = function(fname)
      return vim.fs.dirname(vim.fs.find(".git", { path = fname, upward = true })[1])
    end,
    single_file_support = true,
    xml = {
      format = {
        enabled = true,
        splitAttributes = "preserve",
        maxLineWidth = 280,
      },
    },
    xslt = {
      format = {
        enabled = true,
        splitAttributes = "preserve",
        maxLineWidth = 280,
      },
    },
  },
  yamlls = {
    yamlls = {
      textDocument = {
        foldingRange = {
          dynamicRegistration = false,
          lineFoldingOnly = true,
        },
      },
    },
    single_file_support = true,
    root_dir = require("lspconfig").util.root_pattern("application.yaml", ".stylua.json"),
    filetypes = { "yaml" },
    settings = {
      yaml = {
        keyOrdering = false,
        schemaStore = { enable = false },
        schemas = {
          ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
        },
        format = {
          enable = true,
        },
        validate = true,
        completion = true,
      },
    },
  },
  lua_ls = {
    single_file_support = true,
    filetypes = { "lua" },
    root_dir = require("lspconfig").util.root_pattern(".luarc.json", ".stylua.json"),
    -- mason = false, -- set to false if you don't want this server to be installed with mason
    settings = {
      Lua = {
        workspace = {
          checkThirdParty = false,
          library = { vim.env.VIMRUNTIME },
        },
        doc = {
          privateName = { "^_" },
        },
        hint = {
          enable = true,
          setType = false,
          paramType = true,
          paramName = "Disable",
          semicolon = "Disable",
          arrayIndex = "Disable",
        },
        telemetry = {
          enable = false,
        },
      },
    },
  },
}

local ensure_installed = vim.tbl_keys(servers or {})
vim.list_extend(ensure_installed, {
  "stylua",
  "prettierd",
  "black",
  "isort",
  "lemminx",
  "markdownlint",
  "vscode-java-decompiler",
  "checkstyle",
  "google-java-format",
  "xmlformatter",
  "yaml-language-server",
  "lua-language-server",
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend("force", capabilities, require("blink.cmp").get_lsp_capabilities({}, false))
capabilities = vim.tbl_deep_extend("force", capabilities, {
  textDocument = { foldingRange = { dynamicRegistration = false, lineFoldingOnly = true } },
  workspace = { fileOperations = { didRename = true, willRename = true } },
})

require("mason").setup()
require("mason-tool-installer").setup({ ensure_installed = ensure_installed })
require("mason-lspconfig").setup_handlers({
  function(server_name)
    if server_name == "jdtls" then
      return
    end
    local server = servers[server_name] or {}
    server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
    require("lspconfig")[server_name].setup(server)
  end,
})
