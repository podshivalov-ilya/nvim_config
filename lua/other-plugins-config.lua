require('nvim-treesitter.configs').setup {
    ensure_installed = { 'c', 'cpp', 'python', 'lua' },
    highlight = {
        enable = true,
    },
}

require('lualine').setup{}
require('nvim-autopairs').setup{}


require('lspconfig').clangd.setup {
    cmd = {
        "clangd",
        "--background-index",
        "--clang-tidy",
        "--cross-file-rename",
        "--all-scopes-completion",
        "--header-insertion=never",
        "--limit-results=500"
    },
    filetypes = { "c", "cpp", "objc", "objcpp" },
    root_dir = require('lspconfig').util.root_pattern(".clangd", "compile_commands.json", ".git"),
    capabilities = require('cmp_nvim_lsp').default_capabilities(),
}
