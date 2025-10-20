local capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.lsp.configs = vim.lsp.configs or {}

vim.lsp.configs.clangd = {
    name = "clangd",
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
    root_dir = function() return vim.fs.root(0, { ".clangd", "compile_commands.json", ".git" }) end,
    capabilities = capabilities,
}

vim.lsp.configs.pyright = {
    name = "pyright",
    cmd = { "pyright-langserver", "--stdio" },
    filetypes = { "python" },
    root_dir = function() return vim.fs.root(0, { "pyproject.toml", "setup.cfg", "setup.py", ".git" }) end,
    capabilities = capabilities,
}

vim.lsp.configs.ts_ls = {
    name = "ts_ls",
    cmd = { "typescript-language-server", "--stdio" },
    filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
    root_dir = function() return vim.fs.root(0, { "tsconfig.json", "jsconfig.json", "package.json", ".git" }) end,
    capabilities = capabilities,
}

vim.lsp.configs.svelte = {
    name = "svelte",
    cmd_env = { CHOKIDAR_USEPOLLING = "true", CHOKIDAR_INTERVAL = "1000" },
    cmd = { "svelteserver", "--stdio", "--no-watch" },
    filetypes = { "svelte" },
    root_dir = function() return vim.fs.root(0, { "svelte.config.js", "svelte.config.ts", "package.json", ".git" }) end,
    capabilities = capabilities,
}

local ft2server = {
    c = "clangd",
    cpp = "clangd",
    objc = "clangd",
    objcpp = "clangd",
    python = "pyright",
    javascript = "ts_ls",
    typescript = "ts_ls",
    javascriptreact = "ts_ls",
    typescriptreact = "ts_ls",
    svelte = "svelte",
}

vim.api.nvim_create_autocmd("FileType", {
    pattern = vim.tbl_keys(ft2server),
    callback = function()
        local name = ft2server[vim.bo.filetype]
        if not name then return end
        for _, c in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
            if c.name == name then return end
        end
        local cfg = vim.lsp.configs[name]
        if cfg then vim.lsp.start(cfg) end
    end,
})

vim.api.nvim_create_user_command("LspInfo", function()
    print(vim.inspect(vim.lsp.get_clients({ bufnr = 0 })))
end, { desc = "Show active LSP clients" })

