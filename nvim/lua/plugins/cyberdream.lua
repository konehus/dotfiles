require("cyberdream").setup({
  transparent = false,
  borderless_pickers = false,
  cache = true,
  variant = "auto",
  saturation = 0.85,
  colors = {
    -- Backgrounds
    bg = "#16181a", -- deep dark background
    bg_alt = "#1e2124", -- slightly lifted for panels
    bg_highlight = "#3c4048", -- hover/select highlight zones

    -- Foreground & neutrals
    fg = "#CDD6F4", -- from Catppuccin Macchiato's `text`
    grey = "#7b8496", -- good for subtle hints and comments

    -- Primary accents
    blue = "#5ea1ff", -- vibrant but readable
    green = "#A6D785", -- soft coding green (great pick)
    cyan = "#94E2D5", -- better match from Macchiato `teal`

    -- Warm tones
    red = "#F38BA8", -- Catppuccin’s elegant red
    orange = "#FAB387", -- professional, warm tone
    yellow = "#F9E2AF", -- more natural than neon `#f1ff5e`

    -- Romantic tones
    magenta = "#C47082", -- rich maroon (warm version of magenta)
    pink = "#F5C2E7", -- Macchiato pink
    purple = "#CBA6F7", -- refined lavender-mauve
  },

  highlights = {
    CursorLine = { bg = "#16181a" },
    StatusLine = { bg = "#16181a" },
    BlinkCmpMenu = { fg = "#C0CAF5", bg = "#1E1E2E" }, -- soft text, deep background
    BlinkCmpMenuBorder = { fg = "#1E1E2E", bg = "#1E1E2E" }, -- hidden border effect
    BlinkCmpMenuSelection = { fg = "#FFFFFF", bg = "#313244", bold = true },
    BlinkCmpScrollBarThumb = { bg = "#3B3F51" },
    BlinkCmpScrollBarGutter = { bg = "#1E1E2E" },

    BlinkCmpLabel = { fg = "#CDD6F4" },
    BlinkCmpLabelDeprecated = { fg = "#5C5F77", strikethrough = true },
    BlinkCmpLabelMatch = { fg = "#89B4FA", bold = true },
    BlinkCmpLabelDetail = { fg = "#A6ADC8" },
    BlinkCmpLabelDescription = { fg = "#7F849C" },

    BlinkCmpKind = { fg = "#9399B2" },
    BlinkCmpKindFunction = { fg = "#A6E3A1" },
    BlinkCmpKindVariable = { fg = "#F9E2AF" },
    BlinkCmpKindClass = { fg = "#F38BA8" },
    BlinkCmpKindMethod = { fg = "#94E2D5" },
    BlinkCmpKindKeyword = { fg = "#CBA6F7" },

    BlinkCmpSource = { fg = "#BAC2DE", italic = true },
    BlinkCmpGhostText = { fg = "#45475A", italic = true },

    BlinkCmpDoc = { fg = "#CDD6F4", bg = "#1A1B26" },
    BlinkCmpDocBorder = { fg = "#1E1E2E", bg = "#1A1B26" },
    BlinkCmpDocSeparator = { fg = "#3B3F51" },
    BlinkCmpDocCursorLine = { fg = "#FFFFFF", bg = "#313244" },

    BlinkCmpSignatureHelp = { fg = "#C0CAF5", bg = "#1E1E2E" },
    BlinkCmpSignatureHelpBorder = { fg = "#1E1E2E", bg = "#1E1E2E" },
    BlinkCmpSignatureHelpActiveParameter = { fg = "#89B4FA", bold = true },
  },
})
