require("blink.cmp").setup({
  keymap = {
    preset = "default",
    ["<C-k>"] = { "show_documentation" },
  },
  snippets = {

    preset = "luasnip",
  },
  sources = {
    providers = {
      lsp = {
        name = "󰘦 LSP",
      },
      snippets = {
        name = " Snip",
        deduplicate = { enabled = true },
      },
      path = {
        name = " Path",
      },
      buffer = {
        name = " Buffer",
        deduplicate = { enabled = true },
      },
    },
    default = { "lsp", "path", "snippets", "buffer" },
  },
  completion = {
    ghost_text = { enabled = true },
    list = { selection = { preselect = false, auto_insert = true } },
    accept = { auto_brackets = { enabled = true } },
    -- Show documentation when selecting a completion item
    documentation = { auto_show = true, auto_show_delay_ms = 500 },
    -- documentation = {
    --   auto_show = false,
    -- },
    menu = {
      auto_show = true,
      draw = {
        components = {
          kind_icon = {
            text = function(ctx)
              local kind_icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
              return kind_icon
            end,
            -- (optional) use highlights from mini.icons
            highlight = function(ctx)
              local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
              return hl
            end,
          },
          kind = {
            -- (optional) use highlights from mini.icons
            highlight = function(ctx)
              local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
              return hl
            end,
          },
        },
        treesitter = { "lsp" },
        --   columns = {
        --     { "kind_icon", "label", "label_description", gap = 2 },
        --     { "kind", align = "right", gap = 1 },
        --     { "source_name", align = "right", gap = 1 },
        --   },
      },
    },
  },
  signature = {
    enabled = true,
    window = { show_documentation = true, treesitter_highlighting = false },
    trigger = {
      show_on_keyword = true,
    },
  },
  appearance = {
    use_nvim_cmp_as_default = true,
    nerd_font_variant = "mono",
  },
  cmdline = {
    enabled = true,
  },
})
