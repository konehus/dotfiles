require("chatgpt").setup({
  api_key_cmd = "secret-tool lookup service chatgpt api_key openai",
  openai_params = {
    model = "gpt-4o",
    max_tokens = 4096,
  },
})

local mappings = {
  c = "ChatGPT",
  e = "ChatGPTEditWithInstruction",
  g = "ChatGPTRun grammar_correction",
  t = "ChatGPTRun translate",
  k = "ChatGPTRun keywords",
  d = "ChatGPTRun docstring",
  a = "ChatGPTRun add_tests",
  o = "ChatGPTRun optimize_code",
  s = "ChatGPTRun summarize",
  f = "ChatGPTRun fix_bugs",
  x = "ChatGPTRun explain_code",
  r = "ChatGPTRun roxygen_edit",
  l = "ChatGPTRun code_readability_analysis",
}

for key, cmd in pairs(mappings) do
  vim.api.nvim_set_keymap("n", "<leader>v" .. key, "<Cmd>" .. cmd .. "<CR>", { desc = mappings[key] })
  vim.api.nvim_set_keymap("v", "<leader>v" .. key, "<Cmd>" .. cmd .. "<CR>", { desc = mappings[key] })
end
