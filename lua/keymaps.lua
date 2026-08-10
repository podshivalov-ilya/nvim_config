vim.keymap.set('n', '<C-f>', ':FzfLua files<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-s>', ':FzfLua lsp_workspace_symbols<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-g>', ':Grepper<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-j>', 'i<CR><Esc>^', { noremap = true, silent = true })

-- диагностика
vim.keymap.set('n', '<C-e>', vim.diagnostic.open_float, { desc = "Show diagnostic" })
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = "Prev diagnostic" })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = "Next diagnostic" })
vim.keymap.set('n', '<C-q>', vim.diagnostic.setqflist, { desc = "Diagnostics to quickfix" })

-- a.vim: убираем дефолтные <Leader>-маппинги, вешаем на Ctrl
vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        for _, lhs in ipairs({ '<Leader>ih', '<Leader>is', '<Leader>ihn', '<Leader>isa', '<Leader>iha' }) do
            pcall(vim.keymap.del, 'n', lhs)
        end
    end,
})
vim.keymap.set('n', '<C-h>', ':A<CR>', { noremap = true, silent = true, desc = "Switch header/source" })
