vim.api.nvim_create_autocmd("FileType", {
  pattern = "yaml",
  callback = function()
    vim.opt_local.expandtab = true -- Use spaces, not tabs
    vim.opt_local.shiftwidth = 2 -- Auto-indent 2 spaces
    vim.opt_local.tabstop = 2 -- 1 tab = 2 spaces
    vim.opt_local.softtabstop = 2
  end,
})
