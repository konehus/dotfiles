require("nvim-treesitter.configs").setup({
  modules = {},
  ignore_install = {},
  sync_install = false,
  ensure_installed = {
    "go",
    "lua",
    "vim",
    "markdown",
    "markdown_inline",
    "python",
    "java",
    "json",
    "xml",
    "regex",
    "bash",
  },
  auto_install = true,
  highlight = {
    enable = true,
    -- Some languages depend on vim's regex highlighting system (such as
    -- Ruby) for indent rules. If you are experiencing weird indenting
    -- issues, add the language to the list of additional vim regex
    -- highlighting and disabled languages for indent.
    additional_vim_regex_highlighting = { "ruby" },
  },
  textobjects = { enable = false },
  indent = {
    enable = true,
    disable = { "ruby", "markdown" },
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<C-space>",
      node_incremental = "<C-space>",
      scope_incremental = false,
      node_decremental = "<bs>",
    },
  },
})
