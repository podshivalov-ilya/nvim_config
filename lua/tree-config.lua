require("neo-tree").setup({
    close_if_last_window = false,
    enable_git_status = true,
    enable_diagnostics = false,

    default_component_configs = {
        indent = {
            indent_size = 2,
            padding = 1,
            with_markers = true,
            expander_collapsed = "▶",
            expander_expanded = "▼",
        },
    },

    window = {
        position = "left",
        width = 30,
    },

    filesystem = {
        filtered_items = {
            visible = true,
            hide_dotfiles = true,
            falsehide_gitignored = true,
        },
        follow_current_file = {
            enabled = false,
        },
        use_libuv_file_watcher = false,
    },

    buffers = {
        follow_current_file = {
            enabled = true,
        },
        show_unloaded = true,
    },

    sources = {
        "filesystem",
        "buffers",
        "git_status",
    },
})

vim.keymap.set("n", "<C-i>", function()
    require("neo-tree.command").execute({
        source = "filesystem",
        position = "left",
        toggle = true,
        reveal = true,
    })
end, { noremap = true, silent = true })
vim.keymap.set("n", "<C-b>", function()
    require("neo-tree.command").execute({
        source = "buffers",
        position = "right",
        toggle = true,
        focus = false
    })
end, { noremap = true, silent = true })
