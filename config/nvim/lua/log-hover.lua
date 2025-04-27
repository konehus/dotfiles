local M = {}

local ts_utils = require("nvim-treesitter.ts_utils")
local api = vim.api
local fn = vim.fn
local ns = api.nvim_create_namespace("log_hover")

local float_win = nil
local float_buf = nil
local active = false

-- Decode JSON or fallback to Lua table syntax
local function safe_decode_any(input)
  local json_ok, json_val = pcall(fn.json_decode, input)
  if json_ok then
    return json_val
  end

  local lua_code = "return " .. input
  local lua_ok, lua_val = pcall(loadstring(lua_code))
  if lua_ok and type(lua_val) == "table" then
    return lua_val
  end

  return nil
end

local function get_json_node()
  local node = ts_utils.get_node_at_cursor()
  while node do
    if node:type() == "object" or node:type() == "array" then
      return node
    end
    node = node:parent()
  end
  return nil
end

local function extract_data_under_cursor()
  local bufnr = api.nvim_get_current_buf()
  local node = get_json_node()
  local json_raw = nil
  local title = nil

  if node then
    local s_row, s_col, e_row, e_col = node:range()
    local lines = api.nvim_buf_get_text(bufnr, s_row, s_col, e_row, e_col, {})
    json_raw = table.concat(lines, "\n")
    local full_line = api.nvim_buf_get_lines(bufnr, s_row, s_row + 1, false)[1]
    title = full_line:match('"(.-)"')
  else
    local line = api.nvim_get_current_line()
    json_raw = line:match("{.*}") or line:match("%[.*%]")
    title = line:match('"(.-)"')
  end

  if not json_raw then
    return nil
  end
  local parsed = safe_decode_any(json_raw)
  return parsed and { title = title or "", data = parsed } or nil
end

local function open_floating_window(content, title)
  if float_win and api.nvim_win_is_valid(float_win) then
    api.nvim_win_close(float_win, true)
  end
  if float_buf and api.nvim_buf_is_valid(float_buf) then
    api.nvim_buf_delete(float_buf, { force = true })
  end

  float_buf = api.nvim_create_buf(false, true)
  api.nvim_buf_set_option(float_buf, "filetype", "json")

  api.nvim_buf_set_lines(float_buf, 0, -1, false, vim.split(content, "\n"))

  float_win = api.nvim_open_win(float_buf, false, {
    relative = "cursor",
    row = 1,
    col = 1,
    width = math.min(80, api.nvim_get_option("columns") - 4),
    height = math.min(15, api.nvim_get_option("lines") - 4),
    border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
    title = title or "Hover JSON",
    title_pos = "center",
    style = "minimal",
  })

  -- Simple keymap to jump in/out
  vim.keymap.set("n", "<leader>jj", function()
    if api.nvim_get_current_win() == float_win then
      vim.cmd("wincmd p")
    else
      api.nvim_set_current_win(float_win)
    end
  end, { desc = "Jump in/out of hover window", buffer = 0 })
end

function M.update_if_active()
  if not active then
    return
  end
  local result = extract_data_under_cursor()
  if not result then
    return
  end

  local formatted = vim.inspect(result.data)
  open_floating_window(formatted, result.title)
end

function M.toggle()
  active = not active
  if not active then
    if float_win and api.nvim_win_is_valid(float_win) then
      api.nvim_win_close(float_win, true)
    end
    if float_buf and api.nvim_buf_is_valid(float_buf) then
      api.nvim_buf_delete(float_buf, { force = true })
    end
    float_win = nil
    float_buf = nil
    return
  end
  M.update_if_active()
end

vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
  callback = function()
    vim.schedule(M.update_if_active)
  end,
})

vim.keymap.set("n", "<leader>jl", M.toggle, { desc = "Toggle JSON/Lua table hover" })

return M
