--stylua: ignore start

-- Mapping helpers ==========================================================
local map = function(mode, lhs, rhs, desc, opts)
	opts = opts or {}
	opts.desc = desc
	vim.keymap.set(mode, lhs, rhs, opts)
end

local L = function(key)
	return "<leader>" .. key
end
local C = function(cmd)
	return "<Cmd>" .. cmd .. "<CR>"
end

-- Basic mappings ===========================================================
map({ "n", "i" }, "<A-n>", C("normal ciw "), "Just one space")
map("n", "<Esc>", C("noh"), "nohlsearch")
-- map({"n"     }, "-",          C"Oil",                                          "Open parent directory")
map({ "n" }, L"e", C("lua require('plugins.mini.files').bufdir()"), "Mini.Files Explorer")
map({ "n" }, L"w", C("write"), "Write")
map({ "n" }, L"q", C("quit"), "Quit")
map({ "n" }, "H", C("lua MiniBracketed.buffer('backward')"), "Prev buffer")
map({ "n" }, "L", C("lua MiniBracketed.buffer('forward')"), "Next buffer")
map({ "n" }, "z=", C("Pick spellsuggest"), "Spelling suggestions")
map({ "n" }, [[\c]], C("lua require('reticle').toggle_cursorline()"), "Toggle 'cursorline'")
map({ "n" }, [[\C]], C("lua require('reticle').toggle_cursorcolumn()"), "Toggle 'cursorcolumn'")
map({ "n" }, [[\f]], C("FormatToggle"), "Toggle auto-format")
-- Cannot use <Cmd> or mini.map will not refresh.
map({ "n" }, [[\h]], ":let v:hlsearch = 1 - v:hlsearch<CR>", "Toggle hlsearch")
map({ "n" }, [[\i]], C("lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())"), "Toggle inlay hints")
map({ "n" }, "<C-w>m", C("lua MiniMisc.zoom()"), "Zoom buffer")

-- Leader mappings ==========================================================
map({ "n" }, L(" "), C("Pick files"), "Find files")
map({ "n" }, L(","), C("Pick buffers"), "Switch buffer")
map({ "n" }, L("fd"), C("filetype detect"), "Filetype Detect")
map({ "n" }, L("/"), C("Pick buf_lines scope='current' preserve_order=true"), "Search buffer")
map({ "n" }, L("ba"), C("b#"), "Alternate buffer")
map({ "n" }, L("bd"), C("lua require('mini.bufremove').delete()"), "Delete buffer")
map({ "n" }, L("bD"), C("%bd|e#|bd#"), "Delete other buffers")
map({ "n" }, L("bu"), C("lua require('mini.bufremove').unshow()"), "Unshow buffer")
map({ "n" }, L("bw"), C("lua require('mini.bufremove').wipeout()"), "Wipeout buffer")
map({ "n" }, L("cd"), C("lua vim.diagnostic.open_float()"), "Show diagnostic messages")

map({ "n" }, L("fE"), C("lua require('plugins.mini.files').cwd()"), "File explorer (cwd)")
map({ "n" }, L("fL"), C("lua MiniVisits.remove_label()"), "Remove label")
map({ "n" }, L("fV"), C("Pick visit_labels"), "Find visited labels")
map({ "n" }, L("fb"), C("Pick buffers"), "Find buffers")
map({ "n" }, L("fc"), C("Pick config"), "Find config file")
map({ "n" }, L("fe"), C("lua require('plugins.mini.files').bufdir()"), "File explorer (buf)")
map({ "n" }, L("ff"), C("Pick files"), "Find files")
map({ "n" }, L("fl"), C("lua MiniVisits.add_label()"), "Add label")
map({ "n" }, L("fr"), C("Pick oldfiles"), "Find recent files")
map({ "n" }, L("fe"), C("lua require('plugins.mini.files').bufdir()"), "File explorer (buf)")
map({ "n" }, L("ff"), C("Pick files"), "Find files")
map({ "n" }, L("fl"), C("lua MiniVisits.add_label()"), "Add label")
map({ "n" }, L("fr"), C("Pick oldfiles"), "Find recent files")
map({ "n" }, L("fe"), C("lua require('plugins.mini.files').bufdir()"), "File explorer (buf)")
map({ "n" }, L("ff"), C("Pick files"), "Find files")
map({ "n" }, L("fl"), C("lua MiniVisits.add_label()"), "Add label")
map({ "n" }, L("fr"), C("Pick oldfiles"), "Find recent files")
map({ "n" }, L("fe"), C("lua require('plugins.mini.files').bufdir()"), "File explorer (buf)")
map({ "n" }, L("ff"), C("Pick files"), "Find files")
map({ "n" }, L("fl"), C("lua MiniVisits.add_label()"), "Add label")
map({ "n" }, L("fr"), C("Pick oldfiles"), "Find recent files")
map({ "n" }, L("fv"), C("Pick visit_paths"), "Find visited files")
map({ "n" }, L("gb"), C("vertical Git blame -- %"), "Git history")
map({ "n" }, L("gfd"), C("Pick git_files scope='deleted'"), "Find deleted files")
map({ "n" }, L("gfg"), C("Pick git_files"), "Find git files")
map({ "n" }, L("gfi"), C("Pick git_files scope='ignored'"), "Find ignored files")
map({ "n" }, L("gfm"), C("Pick git_files scope='modified'"), "Find modified files")
map({ "n" }, L("gfu"), C("Pick git_files scope='untracked'"), "Find untracked files")
map({ "n" }, L("gg"), C("lua require('plugins.toggleterm').lazygit_toggle()"), "Toggle Lazygit")
map({ "n" }, L("gl"), C("Git hist"), "Git history")
map({ "n" }, L("gL"), C("Git hist --all"), "Git history (all)")
map({ "n" }, L("go"), C("lua MiniDiff.toggle_overlay()"), "Toggle diff")
map({ "n" }, L("gq"), C("lua require('plugins.mini.diff').to_qf()"), "Quickfix diffs")
map({ "n", "x" }, L("gs"), C("lua MiniGit.show_at_cursor()"), "MiniGit show at cursor")
map({ "n" }, L("mf"), C("lua MiniMap.toggle_focus()"), "Focus")
map({ "n" }, L("mr"), C("lua MiniMap.refresh()"), "Refresh")
map({ "n" }, L("ms"), C("lua MiniMap.toggle_side()"), "Switch sides")
map({ "n" }, L("mt"), C("lua require('plugins.mini.map').toggle()"), "Toggle map")
map({ "n" }, L("mT"), C("lua require('plugins.mini.map').buf_toggle()"), "Toggle map (buf)")
map({ "n" }, L("Me"), C("lua require('utils').export_minihues_theme()"), "Export MiniHues theme")
map({ "n" }, L("Mm"), C("Mason"), "Mason")
map({ "n" }, L("Ms"), C("lua MiniStarter.open()"), "Open starter")
map({ "n" }, L("Mu"), C("DepsUpdate"), "Update deps")
map({ "n" }, L("MS"), C("DepsSnapSave"), "Save snapshot")
map({ "n" }, L("ML"), C("DepsSnapLoad"), "Load snapshot")
map({ "n" }, L("nN"), C("ZkNewMeeting"), "New meeting note")
map({ "n" }, L("nb"), C("ZkBacklinks"), "Backlink picker")
map({ "n" }, L("nd"), C("ZkCd"), "Change directory")
map({ "n" }, L("nl"), C("ZkLinks"), "Link picker")
map({ "n" }, L("sB"), C("Pick buf_lines scope='all'"), "Search all buffers")
map({ "n" }, L("sC"), C("Pick commands"), "Search commands")
map({ "n" }, L("sH"), C("Pick hl_groups"), "Search highlight groups")
map({ "n" }, L("sT"), C("Pick treesitter"), "Treesitter objects")
map({ "n" }, L("sb"), C("Pick buf_lines scope='current'"), "Search buffer")
map({ "n" }, L("sc"), C("Pick history"), "Search history")
map({ "n" }, L("sd"), C("Pick diagnostic"), "Search diagnostics")
map({ "n" }, L("sg"), C("Pick grep_live_align"), "Search files (align)")
map({ "n" }, L("sG"), C("Pick grep_live"), "Search files")
map({ "n" }, L("sh"), C("Pick help"), "Search help")
map({ "n" }, L("sk"), C("Pick keymaps"), "Search keymaps")
map({ "n" }, L("so"), C("Pick options"), "Search options")
map({ "n" }, L("sr"), C("Pick resume"), "Resume picker")
map({ "n" }, L("st"), C("Pick grep pattern='(TODO|FIXME|HACK|NOTE):'"), "Search Todo/Note")
map({ "n" }, L("xx"), C("lua vim.diagnostic.setloclist()"), "Open diagnostic quickfix list")
--stylua: ignore end

---noice mappings
map({ "c" }, "<S-Enter>", C("lua require('noice').redirect(vim.fn.getcmdline())"), "Redirect CmdLine")
map({ "n" }, L("snl"), C("lua require('noice').cmd('last')"), "Noice last message")
map({ "n" }, L("snh"), C("lua require('noice').cmd('history')"), "Noice last history")
map({ "n" }, L("snt"), C("Telescope noice"), "Noice Telescope history")
--LSP Mappings
map({ "n" }, L("ss"), C("Pick lsp scope='document_symbol'"), "Document symbol")
map({ "n" }, L("sS"), C("Pick lsp scope='workspace_symbol'"), "Workspace symbol")
map({ "n" }, "gD", C("Pick lsp scope='declaration'"), "Goto declaration")
map({ "n" }, "gd", C("Pick lsp scope='definition'"), "Goto definition")
map({ "n" }, "gi", C("Pick lsp scope='implementation'"), "Goto implementation")
map({ "n" }, "gR", C("Pick lsp scope='references'"), "Goto references")
map({ "n" }, "gy", C("Pick lsp scope='type_definition'"), "Goto t[y]pe definition")
map({ "n" }, L("cr"), C("Pick lsp scope='references'"), "Goto references")
map({ "n" }, L("ci"), C("Pick lsp scope='implementation'"), "Goto implementation")
map({ "i" }, "<C-k>", C("lua vim.lsp.buf.signature_help()"), "Signature help")
map({ "n" }, L("cR"), C("lua vim.lsp.buf.rename()"), "Rename symbol")
map({ "n" }, L("cd"), C("lua vim.lsp.buf.definition()"), "Get Definition")
map({ "n" }, L("cD"), C("lua vim.lsp.buf.declaration()"), "Get Declaration")
map({ "n" }, L("ca"), C("lua vim.lsp.buf.code_action()"), "Code Action")
map({ "n" }, L("ts"), C("Telescope current_buffer_fuzzy_find"), "Fuzzy find inside buffer")
--Noice mapping
map({ "n" }, L("nh"), C("Noice history"), "Noice History")
map({ "n" }, L("nt"), C("Noice last"), "Noice last")
map({ "n" }, "<ctrl>r", C("command! -nargs=0 RunJava !javac % && java %:r"), "run java")

--Dap Mappings
vim.api.nvim_set_keymap("i", "<F2>", '<cmd>lua require("renamer").rename()<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap(
  "n",
  "<leader>rn",
  '<cmd>lua require("renamer").rename()<cr>',
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  "v",
  "<leader>rn",
  '<cmd>lua require("renamer").rename()<cr>',
  { noremap = true, silent = true }
)
