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
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",

    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "theHamsta/nvim-dap-virtual-text",
            "nvim-neotest/nvim-nio",
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
    },
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    "folke/tokyonight.nvim",
    "EdenEast/nightfox.nvim"
})
