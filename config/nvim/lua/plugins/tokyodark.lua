-- Credits to original https://github.com/tiagovla/tokyodark.nvim
-- This is modified version of it
require("tokyonight").setup({
  on_highlights = function(hl, c)
    hl.BlinkCmpMenu = { bg = c.bg_dark, fg = c.fg_dark }
    hl.BlinkCmpMenuBorder = { bg = c.bg_dark, fg = c.bg_dark }
    hl.BlinkCmpMenuSelection = { bg = c.blue0, fg = c.blue }
    hl.BlinkCmpScrollBarThumb = { fg = c.blue }
    hl.BlinkCmpScrollBarGutter = { bg = c.bg_dark }
    hl.BlinkCmpLabel = { fg = c.fg }
    hl.BlinkCmpLabelDeprecated = { fg = c.comment, strikethrough = true }
    hl.BlinkCmpLabelMatch = { fg = c.magenta, bold = true }
    hl.BlinkCmpLabelDetail = { fg = c.fg_gutter }
    hl.BlinkCmpLabelDescription = { fg = c.fg }
    hl.BlinkCmpKind = { fg = c.yellow or c.orange }

    -- overrides for specific kinds (optional)
    hl.BlinkCmpKindFunction = { fg = c.purple }
    hl.BlinkCmpKindVariable = { fg = c.red }
    hl.BlinkCmpKindClass = { fg = c.blue }
    hl.BlinkCmpKindModule = { fg = c.cyan }
    hl.BlinkCmpKindSnippet = { fg = c.green }

    hl.BlinkCmpSource = { fg = c.comment, italic = true }
    hl.BlinkCmpGhostText = { fg = c.comment, italic = true }
    hl.BlinkCmpDoc = { bg = c.bg_popup, fg = c.fg }
    hl.BlinkCmpDocBorder = { bg = c.bg_popup, fg = c.bg_popup }
    hl.BlinkCmpDocSeparator = { fg = c.comment }
    hl.BlinkCmpDocCursorLine = { bg = c.bg_highlight }
    hl.BlinkCmpSignatureHelp = { bg = c.bg_visual, fg = c.fg }
    hl.BlinkCmpSignatureHelpBorder = { bg = c.bg_visual, fg = c.bg_visual }
    hl.LspSignatureActiveParameter = { fg = c.orange, bold = true }
  end,
})
