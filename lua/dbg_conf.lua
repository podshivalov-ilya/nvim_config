local dap = require("dap")
local dapui = require("dapui")
local dap_virtual_text = require("nvim-dap-virtual-text")

require("mason").setup()
local mason_dap = require("mason-nvim-dap").setup({
    ensure_installed = { "codelldb" },
    automatic_installation = true,
})

dapui.setup()
dap_virtual_text.setup({})

local project_dap_config = vim.fn.getcwd() .. "/.nvim/dap.lua"
if vim.fn.filereadable(project_dap_config) == 1 then
    dofile(project_dap_config)
end

dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
end

vim.keymap.set('n', '<F5>', function() dap.continue() end, { desc = "DAP Continue"})
vim.keymap.set('n', '<F10>', function() dap.step_over() end, { desc = "DAP Step Over"})
vim.keymap.set('n', '<F11>', function() dap.step_into() end, { desc = "DAP Step Into"})
vim.keymap.set('n', '<F12>', function() dap.step_out() end, { desc = "DAP Step Out"})
vim.keymap.set('n', '<leader>db', function() dap.toggle_breakpoint() end, { desc = "Toggle Breakpoint"})
vim.keymap.set('n', '<leader>du', function() dapui.toggle() end, { desc = "Toggle DAP UI"})
