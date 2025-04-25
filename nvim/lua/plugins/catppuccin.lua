-- stylua: ignore start
require("catppuccin").setup({
  default_integrations = false,
  integrations = {
    -- cmp = true,
    blink_cmp = true,
    markdown = true,
    mason = true,
    mini = { enabled = true },
    native_lsp = {
      enabled = true,
      virtual_text = {
        errors      = { "italic" },
        hints       = { "italic" },
        warnings    = { "italic" },
        information = { "italic" },
        ok          = { "italic" },
      },
      underlines = {
        errors      = { "underline" },
        hints       = { "underline" },
        warnings    = { "underline" },
        information = { "underline" },
        ok          = { "underline" },
      },
      inlay_hints = {
        background = true,
      },
    },
    semantic_tokens = true,
    treesitter = true,
    treesitter_context = true,
  },
  highlight_overrides = {
    all = function(colors)
      local overrides = {
        Comment           = { fg = colors.overlay0, style = { "italic" } },
        ["@markup.quote"] = { fg = colors.maroon, style = { "italic" } }, -- block quotes
      }
      return overrides
    end,
    mocha = function(colors)
      local overrides = {
        Headline                       = { style = { "bold" } },
        FloatTitle                     = { fg = colors.green },
        WinSeparator                   = { fg = colors.surface1, style = { "bold" } },
        CursorLineNr                   = { fg = colors.lavender, style = { "bold" } },
        KazCodeBlock                   = { bg = colors.mantle },
        LeapBackdrop                   = { link = "MiniJump2dDim" },
        LeapLabel                      = { fg = colors.green, style = { "bold" } },
        MsgArea                        = { fg = colors.overlay2 },
	CmpGhostText                   = { fg = colors.overlay1},
        CmpItemAbbrMatch               = { fg = colors.green, style = { "bold" } },
        CmpItemAbbrMatchFuzzy          = { fg = colors.green, style = { "bold" } },

        -- Mini customizations
        MiniClueDescGroup              = { fg = colors.mauve },
        MiniClueDescSingle             = { fg = colors.sapphire },
        MiniClueNextKey                = { fg = colors.yellow },
        MiniClueNextKeyWithPostkeys    = { fg = colors.red, style = { "bold" } },

        MiniFilesCursorLine            = { fg = nil, bg = colors.nightfall, style = { "bold" } },
        MiniFilesFile                  = { fg = colors.overlay2 },
        MiniFilesTitleFocused          = { fg = colors.sky, style = { "bold" } },

        MiniHipatternsFixmeBody        = { fg = colors.red, bg = colors.base },
        MiniHipatternsFixmeColon       = { bg = colors.red, fg = colors.red, style = { "bold" } },
        MiniHipatternsHackBody         = { fg = colors.yellow, bg = colors.base },
        MiniHipatternsHackColon        = { bg = colors.yellow, fg = colors.yellow, style = { "bold" } },
        MiniHipatternsNoteBody         = { fg = colors.sky, bg = colors.base },
        MiniHipatternsNoteColon        = { bg = colors.sky, fg = colors.sky, style = { "bold" } },
        MiniHipatternsTodoBody         = { fg = colors.teal, bg = colors.base },
        MiniHipatternsTodoColon        = { bg = colors.teal, fg = colors.teal, style = { "bold" } },

        MiniIndentscopeSymbol          = { fg = colors.sapphire },

        MiniJump                       = { bg = colors.green, fg = colors.base, style = { "bold" } },
        MiniJump2dSpot                 = { fg = colors.peach },
        MiniJump2dSpotAhead            = { fg = colors.mauve },
        MiniJump2dSpotUnique           = { fg = colors.peach },

        MiniMapNormal                  = { fg = colors.overlay2, bg = colors.mantle },

        MiniPickMatchCurrent           = { fg = nil, bg = colors.surface0, style = { "bold" } },
        MiniPickMatchRanges            = { fg = colors.green, style = { "bold" } },
        MiniPickNormal                 = { fg = colors.overlay2, bg = colors.mantle },
        MiniPickPrompt                 = { fg = colors.sky, style = { "bold" } },

        MiniStarterHeader              = { fg = colors.sapphire },
        MiniStarterInactive            = { fg = colors.surface2, style = {} },
        MiniStarterItem                = { fg = colors.overlay2, bg = nil },
        MiniStarterItemBullet          = { fg = colors.surface2 },
        MiniStarterItemPrefix          = { fg = colors.pink },
        MiniStarterQuery               = { fg = colors.red, style = { "bold" } },
        MiniStarterSection             = { fg = colors.peach, style = { "bold" } },

        MiniStatuslineDirectory        = { fg = colors.overlay1, bg = colors.surface0 },
        MiniStatuslineFilename         = { fg = colors.text, bg = colors.surface0, style = { "bold" } },
        MiniStatuslineFilenameModified = { fg = colors.blue, bg = colors.surface0, style = { "bold" } },
        MiniStatuslineInactive         = { fg = colors.overlay1, bg = colors.surface0 },

        MiniSurround                   = { fg = nil, bg = colors.yellow },

        MiniTablineCurrent             = { fg = colors.yellow, bg = colors.base, style = { "bold" } },
        MiniTablineFill                = { bg = colors.mantle },
        MiniTablineHidden              = { fg = colors.overlay1, bg = colors.surface0 },
        MiniTablineModifiedCurrent     = { fg = colors.base, bg = colors.yellow, style = { "bold" } },
        MiniTablineModifiedHidden      = { fg = colors.base, bg = colors.subtext0 },
        MiniTablineModifiedVisible     = { fg = colors.base, bg = colors.subtext0, style = { "bold" } },
        MiniTablineTabpagesection      = { fg = colors.base, bg = colors.mauve, style = { "bold" } },
        MiniTablineVisible             = { fg = colors.overlay1, bg = colors.surface0, style = { "bold" } },
      }
      for _, hl in ipairs({ "Headline", "rainbow" }) do
        for i, c in ipairs({ "green", "sapphire", "mauve", "peach", "red", "yellow" }) do
          overrides[hl .. i] = { fg = colors[c], style = { "bold" } }
        end
      end
      return overrides
    end,
    -- This is a comment and for the love of ...
    macchiato = function(colors)
      local overrides = {
	CursorLine                   = { bg = "#0F1118"},
        CurSearch                      = { bg = colors.peach },
        CursorLineNr                   = { fg = colors.blue, style = { "bold" } },
        IncSearch                      = { bg = colors.peach },
        MsgArea                        = { fg = colors.overlay1 },
	CmpGhostText                   = { fg = colors.overlay1},
        Search                         = { bg = colors.mauve, fg = colors.base },
        TreesitterContextBottom        = { sp = colors.overlay1, style = { "underline" } },
        WinSeparator                   = { fg = colors.surface1, style = { "bold" } },
        ["@string.special.symbol"]     = { link = "Special" },
        ["@constructor.lua"]           = { fg = colors.pink },

        -- Better markdown code block compat w/ mini.hues
        KazCodeBlock                   = { bg = colors.crust },

        -- Links to Comment by default, but that has italics
        LeapBackdrop                   = { link = "MiniJump2dDim" },
        LeapLabel                      = { fg = colors.peach, style = { "bold" } },

        -- Mini customizations
        MiniClueDescGroup              = { fg = colors.pink },
        MiniClueDescSingle             = { fg = colors.sapphire },
        MiniClueNextKey                = { fg = colors.text, style = { "bold" } },
        MiniClueNextKeyWithPostkeys    = { fg = colors.red, style = { "bold" } },

        MiniFilesCursorLine            = { fg = nil, bg = colors.surface1, style = { "bold" } },
        MiniFilesFile                  = { fg = colors.overlay2 },
        MiniFilesTitleFocused          = { fg = colors.peach, style = { "bold" } },

        -- Highlight patterns for highlighting the whole line and hiding colon.
        -- See https://github.com/echasnovski/mini.nvim/discussions/783
        MiniHipatternsFixmeBody        = { fg = colors.red, bg = colors.base },
        MiniHipatternsFixmeColon       = { bg = colors.red, fg = colors.red, style = { "bold" } },
        MiniHipatternsHackBody         = { fg = colors.yellow, bg = colors.base },
        MiniHipatternsHackColon        = { bg = colors.yellow, fg = colors.yellow, style = { "bold" } },
        MiniHipatternsNoteBody         = { fg = colors.sky, bg = colors.base },
        MiniHipatternsNoteColon        = { bg = colors.sky, fg = colors.sky, style = { "bold" } },
        MiniHipatternsTodoBody         = { fg = colors.teal, bg = colors.base },
        MiniHipatternsTodoColon        = { bg = colors.teal, fg = colors.teal, style = { "bold" } },

        MiniIndentscopeSymbol          = { fg = colors.sapphire },

        MiniJump                       = { fg = colors.mantle, bg = colors.pink },
        MiniJump2dSpot                 = { fg = colors.peach },
        MiniJump2dSpotAhead            = { fg = colors.mauve },
        MiniJump2dSpotUnique           = { fg = colors.peach },

        MiniMapNormal                  = { fg = colors.overlay2, bg = colors.mantle },

        MiniPickBorderText             = { fg = colors.blue },
        MiniPickMatchCurrent           = { fg = nil, bg = colors.surface1, style = { "bold" } },
        MiniPickMatchRanges            = { fg = colors.text, style = { "bold" } },
        MiniPickNormal                 = { fg = colors.overlay2, bg = colors.mantle },
        MiniPickPrompt                 = { fg = colors.sky },

        MiniStarterInactive            = { fg = colors.overlay0, style = {} },
        MiniStarterItem                = { fg = colors.overlay2, bg = nil },
        MiniStarterItemBullet          = { fg = colors.surface2 },
        MiniStarterItemPrefix          = { fg = colors.text },
        MiniStarterQuery               = { fg = colors.text, style = { "bold" } },
        MiniStarterSection             = { fg = colors.mauve, style = { "bold" } },

        MiniStatuslineDirectory        = { fg = colors.overlay1, bg = colors.surface0 },
        MiniStatuslineFilename         = { fg = colors.text, bg = colors.surface0, style = { "bold" } },
        MiniStatuslineFilenameModified = { fg = colors.blue, bg = colors.surface0, style = { "bold" } },
        MiniStatuslineInactive         = { fg = colors.overlay1, bg = colors.surface0 },

        MiniSurround                   = { fg = nil, bg = colors.yellow },

        MiniTablineCurrent             = { fg = colors.blue, bg = colors.base, style = { "bold" } },
        MiniTablineFill                = { bg = colors.mantle },
        MiniTablineHidden              = { fg = colors.overlay1, bg = colors.surface0 },
        MiniTablineModifiedCurrent     = { fg = colors.base, bg = colors.blue, style = { "bold" } },
        MiniTablineModifiedHidden      = { fg = colors.base, bg = colors.subtext0 },
        MiniTablineModifiedVisible     = { fg = colors.base, bg = colors.subtext0, style = { "bold" } },
        MiniTablineTabpagesection      = { fg = colors.base, bg = colors.mauve, style = { "bold" } },
        MiniTablineVisible             = { fg = colors.overlay1, bg = colors.surface0, style = { "bold" } },
      }
      for _, hl in ipairs({ "Headline", "rainbow" }) do
        for i, c in ipairs({ "blue", "pink", "lavender", "green", "peach", "flamingo" }) do
          overrides[hl .. i] = { fg = colors[c], style = { "bold" } }
        end
      end
      return overrides
    end,
  },
  color_overrides = {
   macchiato = {
    -- Accents (slightly brighter)
    rosewater = "#F3C0CD",
    flamingo  = "#E89A9A",
    pink      = "#DD8BAA",
    mauve     = "#C29ACC",
    red       = "#EA6A6A",
    maroon    = "#C47082",
    peach     = "#E3B082",
    yellow    = "#E1C07E",
    green     = "#A6D785",
    teal      = "#6FD9D9",
    sky       = "#8EC3FF",
    sapphire  = "#7ABEFF",
    blue      = "#88B2F9",
    lavender  = "#A5D2ED",

    -- Text (slightly clearer contrast)
    text      = "#DEE2EF",
    subtext1  = "#BAC1D1",
    subtext0  = "#A3AAB8",
    overlay2  = "#8A90A2",
    overlay1  = "#707687",
    overlay0  = "#595F6D",

    -- Surfaces (lightened)
    surface2  = "#363B48",
    surface1  = "#2D3240",
    surface0  = "#252A36",

    -- Backgrounds (slightly brighter!)
    base      = "#202430",   -- ⬅ brighter than before
    mantle    = "#272B37",
    crust     = "#2F333F",

    -- Dark cursor line options
    deepNavy  = "#1A1D27",
    nightfall = "#161921",
  },
  },
})
--stylua: ignore end
