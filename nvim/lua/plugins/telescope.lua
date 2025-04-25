require("telescope").load_extension("fzf")

require("telescope").setup({
  defaults = {
    layout_config = {
      prompt_position = "top",
      height = 0.8,
      width = 0.7,
      preview_width = 0.5,
      vertical = {
        width = 0.5,
      },
    },
  },
})

vim.api.nvim_set_keymap("n", "<leader>tt", ":Telescope<CR>", { desc = "Telescope general" })
vim.api.nvim_set_keymap("n", "<leader>td", ":Telescope diagnostics<CR>", { desc = "Telescope diagnostics" })
vim.api.nvim_set_keymap("n", "<leader>tf", ":Telescope find_files<CR>", { desc = "Telescope files" })
vim.api.nvim_set_keymap("n", "<leader>tb", ":Telescope buffers<CR>", { desc = "Telescope buffers" })
vim.api.nvim_set_keymap("n", "<leader>th", ":Telescope help_tags<CR>", { desc = "Telescope help tags" })
