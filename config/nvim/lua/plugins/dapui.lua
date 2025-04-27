require("lazydev").setup({
  library = { "nvim-dap-ui" },
  runtime = vim.env.VIMRUNTIME,
  integrations = {
    lspconfig = true,
    coq = false,
  },
  enabled = true,
  debug = false,
})

require("dapui").setup()
