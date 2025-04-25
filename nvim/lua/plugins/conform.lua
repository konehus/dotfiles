local no_lsp_fallback = {
  c = true,
  cpp = true,
  java = true,
}
require("conform").setup({
  notify_on_error = true,
  format_after_save = function(bufnr)
    if vim.g.disable_autoformat then
      return
    end
    local filetype = vim.bo[bufnr].filetype
    return {
      timeout_ms = 5000,
      lsp_format = no_lsp_fallback[filetype] and "never" or "fallback",
    }
  end,
  formatters_by_ft = {
    lua = { "stylua" },
    -- Conform can also run multiple formatters sequentially
    python = { "isort", "black" }, -- ruff doesn't support sort on format ... sigh
    -- Run *until* a formatter is found.
    markdown = { "prettierd" },
    javascript = { "prettierd" },
    java = { lsp_format = "first" },
    xml = { "xmlformatter" },
    yaml = { "prettierd" },
  },
})

vim.api.nvim_create_user_command("FormatToggle", function(_)
  vim.g.disable_autoformat = not vim.g.disable_autoformat
  local state = vim.g.disable_autoformat and "disabled" or "enabled"
  vim.notify("Auto-save " .. state)
end, {
  desc = "Toggle autoformat-on-save",
  bang = true,
})

vim.keymap.set("v", "<leader>fo", function()
  require("conform").format({ async = true }, function(err)
    if not err then
      local mode = vim.api.nvim_get_mode().mode
      if vim.startswith(string.lower(mode), "v") then
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
      end
    end
  end)
end, { desc = "Format code" })
