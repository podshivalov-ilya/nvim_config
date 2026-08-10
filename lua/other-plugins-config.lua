require('nvim-treesitter.configs').setup {
    ensure_installed = { 'c', 'cpp', 'python', 'lua' },
    highlight = {
        enable = true,
    },
    indent = { enable = true, disable = { "c", "cpp" } },
}

require('lualine').setup{}
require('nvim-autopairs').setup{}
