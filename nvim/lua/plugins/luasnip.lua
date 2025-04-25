---@diagnostic disable: undefined-global
local ls = require("luasnip")

require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_vscode")._load_lazy_loaded_ft({ paths = { vim.fn.stdpath("config") .. "/snippets" } })

require("luasnip").filetype_extend("java", { "javadoc" })
require("luasnip").filetype_extend("lua", { "luadoc" })

vim.keymap.set({ "i" }, "<Tab>", function()
  ls.expand()
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<C-l>", function()
  ls.jump(1)
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<C-j>", function()
  ls.jump(-1)
end, { silent = true })
vim.keymap.set({ "i", "s" }, "<C-e>", function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end, { silent = true })

local util = vim.lsp.util

-- apply snippet edits explicitly
local function apply_snippet_edit(edit)
  for _, doc_change in ipairs(edit.documentChanges or {}) do
    local bufnr = vim.uri_to_bufnr(doc_change.textDocument.uri)
    vim.api.nvim_set_option_value("modifiable", true, { buf = bufnr })

    for _, text_edit in ipairs(doc_change.edits or {}) do
      local edit_range = text_edit.range
      if text_edit.snippet and text_edit.snippet.value then
        vim.api.nvim_buf_set_text(
          bufnr,
          edit_range.start.line,
          edit_range.start.character,
          edit_range["end"].line,
          edit_range["end"].character,
          {}
        )
        vim.api.nvim_win_set_cursor(0, {
          edit_range.start.line + 1,
          edit_range.start.character,
        })
        ls.lsp_expand(text_edit.snippet.value)
      else
        util.apply_text_edits({ text_edit }, bufnr, "utf-8")
      end
    end
  end
end

-- Custom snippet-aware code_action function
function SnippetCodeAction()
  local params = util.make_range_params(0, "utf-16")
  params.context = { diagnostics = vim.lsp.diagnostic.get_line_diagnostics() }

  vim.lsp.buf_request(0, "textDocument/codeAction", params, function(err, actions, ctx)
    if err or not actions or vim.tbl_isempty(actions) then
      vim.notify("No code actions available")
      return
    end
    -- use vim.ui.select for action selection
    vim.ui.select(actions, {
      prompt = "Code actions:",
      format_item = function(action)
        return action.title
      end,
    }, function(action_selected)
      if not action_selected then
        return
      end
      -- resolve if needed
      if action_selected.edit == nil and action_selected.command == nil and action_selected.data ~= nil then
        vim.lsp.buf_request(ctx.bufnr, "codeAction/resolve", action_selected, function(resolve_err, resolved_action)
          if resolve_err or not resolved_action.edit then
            vim.notify("Could not resolve code action")
            return
          end
          apply_snippet_edit(resolved_action.edit)
        end)
      elseif action_selected.edit then
        apply_snippet_edit(action_selected.edit)
      elseif action_selected.command then
        vim.lsp.buf.execute_command(action_selected.command)
      end
    end)
  end)
end

-- key mapping example:
vim.api.nvim_set_keymap("n", "<Leader>ja", ":lua SnippetCodeAction()<CR>", { noremap = true, silent = true })
