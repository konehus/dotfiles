--stylua: ignore start
require("noice").setup({
  health = {
    checker = true, -- Disable if you don't want health checks to run
  },
  presets = {
    bottom_search = false,
    command_palette = true,
    long_message_to_split = true,
    inc_rename = true,
    lsp_doc_border = false,
  },
  lsp = {
    signature = {
      enabled = false,
    },
    -- progress = { enabled = false }, -- Disables lsp progress, uncomment if too much noise
    hover = { enabled = false, },
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      -- ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
    },
  },
  routes = {
    {
      filter = {
        event = "msg_show",
        any = {
          { find = "%d+L, %d+B" },
          { find = "; after #%d+" },
          { find = "; before #%d+" },
        },
      },
      view = "mini",
    },
    {
      view = "mini",
      filter = { find = "recording", event = "msg_showmode" },
    },
    {
      -- view = "mini",
      filter = { event = "msg_show", find = "deprecated", },
      opts = { skip = true },
    },
  },

})

-- --stylua: ignore end
-- -- vim: ts=2 sts=2 sw=2 et
