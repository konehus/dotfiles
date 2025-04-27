-- Autocommands =============================================================
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = vim.api.nvim_create_augroup("legion-wrap-spell", { clear = true }),
  pattern = { "gitcommit", "markdown" },
  desc = "Enable spell/wrap based on filetype",
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  group = vim.api.nvim_create_augroup("legion-python-settings", { clear = true }),
  pattern = { "python" },
  desc = "Local settings for Python buffers",
  callback = function()
    -- vim.b.miniindentscope_config = { options = { border = "top" } }
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  group = vim.api.nvim_create_augroup("legion-java-settings", { clear = true }),
  pattern = { "java" },
  desc = "Local settings for Java buffers",
  callback = function()
    if os.getenv("JDK21_SRC") then
      vim.g.ftplugin_java_source_path = os.getenv("JDK21_SRC")
    end
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  group = vim.api.nvim_create_augroup("legion-log-settings", { clear = true }),
  pattern = { "log" },
  desc = "Activate wrap for logs and activate JSON RPC viewer(LSP RPC)",
  callback = function()
    vim.opt_local.wrap = true
    require("log-hover")
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("legion-format-onsave", { clear = true }),
  pattern = "*",
  desc = "Format on Save with Cnform",
  callback = function(args)
    require("conform").format({ bufnr = args.buf })
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.yaml,*.yml",
  callback = function()
    require("conform").format({ async = false, lsp_fallback = true })
  end,
})
