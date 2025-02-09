vim.keymap.set('n', '<C-f>', ':FzfLua files<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-s>', ':FzfLua lsp_workspace_symbols<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-g>', ':Grepper<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-j>', 'i<CR><Esc>^', { noremap = true, silent = true })
