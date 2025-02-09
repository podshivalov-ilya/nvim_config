local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--depth", "1", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        lazypath
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    "vim-scripts/a.vim",
    "kenn7/vim-arsync",
    "m-pilia/vim-ccls",
    "lervag/vimtex",
    "easymotion/vim-easymotion",
    "vim-airline/vim-airline",
    "ilyachur/cmake4vim",
    "tpope/vim-fugitive",
    "junegunn/gv.vim",
    "preservim/nerdcommenter",
    "airblade/vim-gitgutter",
    "rhysd/git-messenger.vim",
    "mhinz/vim-grepper",
    "romainl/vim-qf",
    { "junegunn/fzf", build = "./install --all" },
    "ibhagwan/fzf-lua",
    "nvim-lualine/lualine.nvim",
    "windwp/nvim-autopairs",
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
    "neovim/nvim-lspconfig",
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",

    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "theHamsta/nvim-dap-virtual-text",
            "nvim-neotest/nvim-nio",
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "jay-babu/mason-nvim-dap.nvim",
        }
    },
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },
    }
})
