vim.opt.compatible = false
vim.opt.filetype = 'off'
vim.cmd('colorscheme desert')
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.smarttab = true
vim.opt.number = true
vim.opt.autoindent = true

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "c", "cpp", "objc", "objcpp" },
    callback = function()
        vim.opt_local.cindent = true
        -- l1: выравниваем код внутри case относительно самого case-лейбла,
        -- а не относительно {. Без этого } уходит вправо на уровень кода внутри case.
        vim.opt_local.cinoptions = "l1"
    end,
})
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.listchars = { tab = '→ ', eol = '↲', nbsp = '␣', trail = '•', extends = '⟩', precedes = '⟨' }
vim.opt.list = true
vim.opt.tildeop = true
vim.opt.scrolloff = 3
vim.opt.laststatus = 2
vim.opt.ffs = { 'unix', 'dos', 'mac' }
vim.opt.fileencodings = { 'utf-8', 'cp1251', 'koi8-r', 'ucs-2', 'cp866' }
vim.opt.guifont = 'Inconsolata:h14'
vim.cmd('syntax on')
vim.opt.wildmenu = true

vim.opt.shell = '/bin/bash'
vim.opt.exrc = true
vim.opt.secure = true
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }

vim.g.airline_extensions_tabline_enabled = 1
vim.g.cmake_project_root = '.git;'
vim.g.cmake_link_compile_commands = 1

vim.g.mapleader = " "
vim.g.maplocalleader = " "
