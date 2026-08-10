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
    root_dir = function() return vim.fs.root(0, { "tsconfig.json", "jsconfig.json", "package.json" }) end,
    capabilities = capabilities,
}

vim.lsp.configs.svelte = {
    name = "svelte",
    cmd_env = { CHOKIDAR_USEPOLLING = "true", CHOKIDAR_INTERVAL = "1000" },
    cmd = { "svelteserver", "--stdio", "--no-watch" },
    filetypes = { "svelte" },
    root_dir = function() return vim.fs.root(0, { "svelte.config.js", "svelte.config.ts", "package.json" }) end,
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

-- единый автозапуск LSP c корректным root_dir и attach к буферу
vim.api.nvim_create_autocmd("FileType", {
  pattern = vim.tbl_keys(ft2server),
  callback = function(args)
    local bufnr = args.buf
    local ft = vim.bo[bufnr].filetype
    local name = ft2server[ft]
    if not name then return end

    -- не дублируем клиента
    for _, c in ipairs(vim.lsp.get_clients({ bufnr = bufnr })) do
      if c.name == name then return end
    end

    local cfg = vim.lsp.configs[name]
    if not cfg then return end

    -- 1) вычисляем root_dir (строкой!)
    local fname = vim.api.nvim_buf_get_name(bufnr)
    local root
    if type(cfg.root_dir) == "function" then
      root = cfg.root_dir(fname)
    else
      root = cfg.root_dir
    end
    if not root or root == "" then
      root = vim.fs.root(bufnr, { "pyproject.toml", "setup.cfg", "setup.py", ".git" })
      if not root or root == "" then root = (vim.uv or vim.loop).cwd() end
    end
    if not root or root == "" then return end

    -- 2) собираем финальный конфиг (не мутируем глобальный)
    cfg = vim.tbl_deep_extend("force", {}, cfg, {
      root_dir = root,
      workspace_folders = { { uri = vim.uri_from_fname(root), name = root } },
    })

    -- 3) для Pyright включим диагностику по всему воркспейсу (чтобы ошибки подсвечивались)
    if name == "pyright" then
      cfg.settings = vim.tbl_deep_extend("force", cfg.settings or {}, {
        python = {
          analysis = {
            diagnosticMode = "workspace",        -- иначе бывает только по открытым файлам
            autoImportCompletions = true,
            useLibraryCodeForTypes = true,
            extraPaths = { root, root .. "/src", "." },
          },
        },
      })
    end

    -- 4) стартуем и ПРИКРЕПЛЯЕМСЯ К ТЕКУЩЕМУ БУФЕРУ (это важно для подсветки ошибок)
    vim.lsp.start(cfg, { bufnr = bufnr })
  end,
})

vim.api.nvim_create_user_command("LspInfo", function()
    print(vim.inspect(vim.lsp.get_clients({ bufnr = 0 })))
end, { desc = "Show active LSP clients" })

