local dap, dapui = require("dap"), require("dapui")
-- Setup the dap ui with default configuration
dapui.setup()

-- setup an event listener for when the debugger is launched
dap.listeners.before.launch.dapui_config = function()
  -- when the debugger is launched open up the debug ui
  dapui.open()
end

-- set a vim motion for <Space> + d + t to toggle a breakpoint at the line where the cursor is currently on
vim.keymap.set("n", "<leader>dt", dap.toggle_breakpoint, { desc = "Debug [t]oggle breakpoint" })

vim.keymap.set("n", "<leader>ds", dap.continue, { desc = "Debug [s]tart" })

vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "step [o]ver" })

vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "step [i]nto" })

vim.keymap.set("n", "<leader>db", dap.step_back, { desc = "step [b]ack" })

vim.keymap.set("n", "<leader>du", dap.step_out, { desc = "step o[u]t" })

vim.keymap.set("n", "<leader>dd", dap.clear_breakpoints, { desc = "[d]elete breakpoints" })

vim.keymap.set("n", "<leader>dc", dapui.close, { desc = "Debug Close" })

dap.listeners.before.attach.dapui_config = function()
  dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
  dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
  dapui.close()
end
