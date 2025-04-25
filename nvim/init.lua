--stylua: ignore start
-- Initialization ===========================================================
_G.Config = {}

-- Clone 'mini.nvim' manually in a way that it gets managed by 'mini.deps'
local path_package = vim.fn.stdpath("data") .. "/site/"
local mini_path = path_package .. "pack/deps/start/mini.nvim"
if not vim.uv.fs_stat(mini_path) then
  vim.cmd('echo "Installing `mini.nvim`" | redraw')
  local clone_cmd = { "git", "clone", "--filter=blob:none", "https://github.com/echasnovski/mini.nvim", mini_path }
  vim.fn.system(clone_cmd)
  vim.cmd("packadd mini.nvim | helptags ALL")
  vim.cmd('echo "Installed `mini.nvim`" | redraw')
end

-- Set up 'mini.deps'
require("mini.deps").setup({ path = { package = path_package } })

-- Define helpers
local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later
local cmd = function(cmd) return function() vim.cmd(cmd) end end
local load = function(spec, opts)
  return function()
    opts = opts or {}
    local slash = string.find(spec, "/[^/]*$") or 0
     local name = opts.init or string.sub(spec, slash + 1)
    if slash ~= 0 then
      add(vim.tbl_deep_extend("force", { source = spec }, opts.add or {}))
    end
    require(name)
    if opts.setup then require(name).setup(opts.setup) end
  end
end

-- Settings and mappings ====================================================
now(load("settings"))
now(load("utils"))
now(load("mappings"))
now(load("autocmds"))

-- Colorscheme ================================================================
now(load("catppuccin/nvim", { add = { name = "catppuccin" }, init = "plugins.catppuccin" }))
now(load("scottmckendry/cyberdream.nvim", {init="plugins.cyberdream"}))
now(load("rebelot/kanagawa.nvim", {init = "plugins.kanagawa"}))
now(load("folke/tokyonight.nvim", {init="plugins.tokyodark"}))
now(cmd("colorscheme tokyonight-night"))

now(load("plugins.mini.basics"))
now(load("plugins.mini.icons"))
now(load("plugins.mini.sessions"))
now(load("plugins.mini.starter"))
now(load("plugins.mini.files"))

-- Testing if these three can be loaded later
later(load("nvimdev/lspsaga.nvim", {init = "lspsaga", setup={}, add = { depends = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons', }}}))
later(load("plugins.mini.statusline"))
later(load("mini.tabline", { setup = {} }))

later(load("mini.align", { setup = {} }))
later(load("mini.bracketed", { setup = {} }))
later(load("mini.bufremove", { setup = {} }))
later(load("mini.colors", { setup = {} }))
later(load("mini.comment", { setup = {} }))
later(load("mini.cursorword", { setup = {} }))
later(load("mini.extra", { setup = {} }))
later(load("mini.jump", { setup = {} }))
later(load("mini.move", { setup = {} }))
later(load("mini.operators", { setup = {} }))
later(load("mini.splitjoin", { setup = {} }))
later(load("mini.trailspace", { setup = {} }))
later(load("mini.visits", { setup = {} }))

later(load("plugins.mini.ai"))
later(load("plugins.mini.clue"))
later(load("plugins.mini.diff"))
later(load("plugins.mini.git"))
later(load("plugins.mini.hipatterns"))
later(load("plugins.mini.indentscope"))
later(load("plugins.mini.jump2d"))
later(load("plugins.mini.map"))
later(load("plugins.mini.misc"))
later(load("plugins.mini.pick"))
later(load("plugins.mini.surround"))
later(load("mini.bracketed"))
-- Other plugins ============================================================

now (load('fei6409/log-highlight.nvim', {init ='log-highlight', setup = {} }))
now(load("folke/noice.nvim", { init = "plugins.noice", add = { depends={ "MunifTanjim/nui.nvim", "rcarriga/nvim-notify"} } }))
now(load("folke/snacks.nvim", {init = "snacks", setup = {}, }))
later(load("OXY2DEV/markview.nvim", { init = "plugins.markview" }))
later(load("ggandor/leap.nvim", { add = { name = "leap" }, init = "plugins.leap" }))
later(load("mfussenegger/nvim-lint", { init = "plugins.nvim-lint" }))
later(load("sainnhe/edge", { init = "plugins.edge" }))
later(load("sainnhe/everforest", { init = "plugins.everforest" }))
later(load("sainnhe/gruvbox-material", { init = "plugins.gruvbox-material" }))
later(load("sainnhe/sonokai", { init = "plugins.sonokai" }))
later(load("stevearc/conform.nvim", { init = "plugins.conform" }))
later(load("tummetott/reticle.nvim", { init = "plugins.reticle" }))
later(load("windwp/nvim-autopairs", { setup = {} }))
later(load("zk-org/zk-nvim", { init = "plugins.zk" }))
later(load('akinsho/toggleterm.nvim', { init = "plugins.toggleterm" }))
later(load("nvim-treesitter/nvim-treesitter", { init = "plugins.treesitter", add = { hooks = { post_checkout = cmd("TSUpdate") } }, }))
later(function() add("nvim-treesitter/nvim-treesitter-textobjects") end)
later(load("nvim-treesitter/nvim-treesitter-context", { init = "treesitter-context", setup = {}, }))
later(load("folke/twilight.nvim", {init = "twilight", setup = {} }))
later(load("gbprod/yanky.nvim", {init = "plugins.yanky"}))
now(load("folke/trouble.nvim", {init = "trouble", setup = {} }))
later(load("jackMort/ChatGPT.nvim", {
  init = "plugins.chatgpt",
  add = {
    depends = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "folke/trouble.nvim",
      "nvim-telescope/telescope.nvim"
    }
  }
}))

local build_fzf_native = function(args)
  vim.notify('Building fzf-native', vim.log.levels.INFO)
  vim.system({"make", "-C", args.path}, {text = true },
  function(r)
    if r.stdout ~= "" then vim.notify(r.stdout, vim.log.levels.INFO) end
    if r.stderr ~= "" then vim.notify(r.stderr, vim.log.levels.ERROR) end
  end)
end

later(load('nvim-telescope/telescope.nvim', {
  init = 'plugins.telescope',
  add = {
    depends = {
      { source = 'nvim-telescope/telescope-fzf-native.nvim',
        hooks = {post_install = build_fzf_native, post_checkout = build_fzf_native},
      },'nvim-lua/plenary.nvim'
    },} }))

local build_jsregexp = function(largs)
  vim.notify('Building jsrexgexp', vim.log.levels.INFO)
  vim.system({"make", "-C", largs.path}, {text = true },
  function(r)
    if r.stdout ~= "" then vim.notify(r.stdout, vim.log.levels.INFO) end
    if r.stderr ~= "" then vim.notify(r.stderr, vim.log.levels.ERROR) end
  end)
end

now(load("L3MON4D3/LuaSnip", {
  init = "plugins.luasnip",
  add = {
    checkout = "v2.3.0",
    depends = {"rafamadriz/friendly-snippets"},
    hooks = {
      post_install = build_jsregexp,
      post_checkout = build_jsregexp,
    },
  },
}))

later(load("saghen/blink.cmp", { init = 'plugins.blink', add = { depends = { "L3MON4D3/LuaSnip" }, checkout = "v1.1.1", } }))

local build_codesnap = function(args)
  vim.notify('Building codesnap', vim.log.levels.INFO)
  vim.system({ "make", "-C", args.path }, { text = true }, function(r)
    if r.stdout ~= "" then vim.notify(r.stdout, vim.log.levels.INFO) end
    if r.stderr ~= "" then vim.notify(r.stderr, vim.log.levels.ERROR) end
  end)
end
later(load("mistricky/codesnap.nvim", {
  init = "plugins.codesnap",
  add = {
    hooks = {
      post_install = build_codesnap,
      post_checkout = build_codesnap,
    },
  },
}))

-- later(load("hrsh7th/nvim-cmp", { init = "plugins.cmp", add = { depends = { "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-path", "hrsh7th/cmp-buffer", "hrsh7th/cmp-cmdline", 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip' }, }, }))

later(load('mfussenegger/nvim-jdtls', {
  init = "jdtls" ,
  add = {
    depends = { "mfussenegger/nvim-dap" }
  }
}))

later(load("mfussenegger/nvim-dap", {
  init = "plugins.dap",
  add = {
    depends = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio"
    }
  }
}))

later(load("jay-babu/mason-nvim-dap.nvim",{
  init = "mason-nvim-dap",
  add = {
    name="mason-nvim-dap",
    depends = {
      "williamboman/mason.nvim"
    }
  },
  setup = {
    ensure_installed = {
      "java-debug-adapter",
      "java-test"
    }
  }
}))

later(load("rcarriga/nvim-dap-ui", {
  init = "plugins.dapui",
  add = {
    depends = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
      "folke/lazydev.nvim"
    }
  }
}))

later(load("neovim/nvim-lspconfig", {
  init = "plugins.lspconfig",
  add = {
    depends = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      "folke/lazydev.nvim"
    },
  },
}))

--stylua: ignore end
-- vim: ts=2 sts=2 sw=2 et
