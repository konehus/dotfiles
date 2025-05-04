--stylua: ignore start

-- Initialization =============================================================
_G.Config = {}

-- Bootstrap mini.nvim ========================================================
local path_package = vim.fn.stdpath("data") .. "/site/"
local mini_path = path_package .. "pack/deps/start/mini.nvim"
if not vim.uv.fs_stat(mini_path) then
  vim.cmd('echo "Installing `mini.nvim`" | redraw')
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/echasnovski/mini.nvim", mini_path })
  vim.cmd("packadd mini.nvim | helptags ALL")
  vim.cmd('echo "Installed `mini.nvim`" | redraw')
end

-- Setup mini.deps ============================================================
require("mini.deps").setup({ path = { package = path_package } })
local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

-- Helpers ====================================================================
local cmd = function(cmd) return function() vim.cmd(cmd) end end
local load = function(spec, opts)
  return function()
    opts = opts or {}
    local slash = string.find(spec, "/[^/]*$") or 0
    local name = opts.init or string.sub(spec, slash + 1)
    if slash ~= 0 then
      add(vim.tbl_deep_extend("force", { source = spec }, opts.add or {}))
    end
    local plugin = require(name)
    if opts.setup then plugin.setup(opts.setup) end
  end
end

-- Core Configs ===============================================================
now(load("settings"))
now(load("utils"))
now(load("mappings"))
now(load("autocmds"))

-- UI: Colorschemes and Core UI Plugins =======================================
now(load("folke/tokyonight.nvim", {init="plugins.tokyodark"}))
now(cmd("colorscheme tokyonight-night"))

now(load("plugins.mini.basics"))
now(load("plugins.mini.icons"))
now(load("plugins.mini.sessions"))
now(load("plugins.mini.starter"))
now(load("plugins.mini.files"))

later(load("plugins.mini.statusline"))
later(load("mini.tabline", { setup = {} }))

-- Mini Plugins ===============================================================
local mini_plugins = {
  "mini.align", "mini.bracketed", "mini.bufremove", "mini.colors", "mini.comment",
  "mini.cursorword", "mini.extra", "mini.jump", "mini.move", "mini.operators",
  "mini.splitjoin", "mini.trailspace", "mini.visits",
}
for _, p in ipairs(mini_plugins) do
  later(load(p, { setup = {} }))
end

local custom_mini_plugins = {
  "plugins.mini.ai", "plugins.mini.clue", "plugins.mini.diff", "plugins.mini.git",
  "plugins.mini.hipatterns", "plugins.mini.indentscope", "plugins.mini.jump2d",
  "plugins.mini.map", "plugins.mini.misc", "plugins.mini.pick", "plugins.mini.surround"
}
for _, p in ipairs(custom_mini_plugins) do
  later(load(p))
end

-- Build Hooks ================================================================
local build_fzf_native = function(args)
  vim.notify('Building fzf-native', vim.log.levels.INFO)
  vim.system({"make", "-C", args.path}, {text = true}, function(r)
    if r.stdout ~= "" then vim.notify(r.stdout, vim.log.levels.INFO) end
    if r.stderr ~= "" then vim.notify(r.stderr, vim.log.levels.ERROR) end
  end)
end

local build_jsregexp = function(args)
  vim.notify('Building jsregexp', vim.log.levels.INFO)
  vim.system({"make", "-C", args.path}, {text = true}, function(r)
    if r.stdout ~= "" then vim.notify(r.stdout, vim.log.levels.INFO) end
    if r.stderr ~= "" then vim.notify(r.stderr, vim.log.levels.ERROR) end
  end)
end

local build_codesnap = function(args)
  vim.notify('Building codesnap', vim.log.levels.INFO)
  vim.system({"make", "-C", args.path}, {text = true}, function(r)
    if r.stdout ~= "" then vim.notify(r.stdout, vim.log.levels.INFO) end
    if r.stderr ~= "" then vim.notify(r.stderr, vim.log.levels.ERROR) end
  end)
end

-- Core UI plugins ------------------------------------------------------------
now(load('fei6409/log-highlight.nvim', { init = 'log-highlight', setup = {} }))
now(load("folke/noice.nvim", { init = "plugins.noice", add = { depends = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" } } }))
now(load("folke/snacks.nvim", { init = "snacks", setup = {} }))
now(load("folke/trouble.nvim", { init = "trouble", setup = {} }))

-- LSP, DAP, Treesitter -------------------------------------------------------
later(load("saghen/blink.cmp", { init = "plugins.blink", add = { depends = { "L3MON4D3/LuaSnip" }, checkout = "v1.1.1" } }))
later(load("neovim/nvim-lspconfig", { init = "plugins.lspconfig", add = { depends = { "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim", "WhoIsSethDaniel/mason-tool-installer.nvim", "folke/lazydev.nvim" } } }))
later(load("mfussenegger/nvim-dap", { init = "plugins.dap", add = { depends = { "rcarriga/nvim-dap-ui", "nvim-neotest/nvim-nio" } } }))
later(load("rcarriga/nvim-dap-ui", { init = "plugins.dapui", add = { depends = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio", "folke/lazydev.nvim" } } }))
later(load("mfussenegger/nvim-jdtls", { init = "jdtls", add = { depends = { "mfussenegger/nvim-dap" } } }))
later(load("jay-babu/mason-nvim-dap.nvim", { init = "mason-nvim-dap", add = { name = "mason-nvim-dap", depends = { "williamboman/mason.nvim" } }, setup = { ensure_installed = { "java-debug-adapter", "java-test" } } }))

later(load("nvim-treesitter/nvim-treesitter", { init = "plugins.treesitter", add = { hooks = { post_checkout = cmd("TSUpdate") } }, }))
later(function() add("nvim-treesitter/nvim-treesitter-textobjects") end)
later(load("nvim-treesitter/nvim-treesitter-context", { init = "treesitter-context", setup = {} }))

-- Tools and Utilities --------------------------------------------------------
later(load("ggandor/leap.nvim", { add = { name = "leap" }, init = "plugins.leap" }))
later(load("OXY2DEV/markview.nvim", { init = "plugins.markview" }))
later(load("mfussenegger/nvim-lint", { init = "plugins.nvim-lint" }))
later(load("stevearc/conform.nvim", { init = "plugins.conform" }))
later(load("tummetott/reticle.nvim", { init = "plugins.reticle" }))
later(load("windwp/nvim-autopairs", { setup = {} }))
later(load("akinsho/toggleterm.nvim", { init = "plugins.toggleterm" }))
later(load("folke/twilight.nvim", { init = "twilight", setup = {} }))
later(load("gbprod/yanky.nvim", { init = "plugins.yanky" }))
later(load("jackMort/ChatGPT.nvim", { init = "plugins.chatgpt", add = { depends = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim", "folke/trouble.nvim", "nvim-telescope/telescope.nvim" } } }))
later(load("nvim-telescope/telescope.nvim", { init = "plugins.telescope", add = { depends = { { source = "nvim-telescope/telescope-fzf-native.nvim", hooks = { post_install = build_fzf_native, post_checkout = build_fzf_native } }, "nvim-lua/plenary.nvim" } } }))
later(load("L3MON4D3/LuaSnip", { init = "plugins.luasnip", add = { checkout = "v2.3.0", depends = { "rafamadriz/friendly-snippets" }, hooks = { post_install = build_jsregexp, post_checkout = build_jsregexp } } }))
later(load("mistricky/codesnap.nvim", { init = "plugins.codesnap", add = { hooks = { post_install = build_codesnap, post_checkout = build_codesnap } } }))

--stylua: ignore end
-- vim: ts=2 sts=2 sw=2 et
