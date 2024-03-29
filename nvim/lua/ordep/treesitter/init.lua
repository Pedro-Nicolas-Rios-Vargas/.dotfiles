--[[
-- Old memories of configurations
require("nvim-treesitter.configs").setup {
    ensure_installed = { "c", "lua", "vim", "java", "python",
                         "javascript", "css", "html", "bash", "arduino",
                         "markdown", "markdown_inline", "mermaid", "json" },
    sync_install = true,
    highlight = {
        enable = true,
    },
    incremental_selection = {
        enable = true
    },
    textobjects = {
        enable = true
    },
    -- Treesitter modules...
    playground = {
        enable = true,
        disable = {},
        updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
        persist_queries = false, -- Whether the query persists across vim sessions
        keybindings = {
            toggle_query_editor = 'o',
            toggle_hl_groups = 'i',
            toggle_injected_languages = 't',
            toggle_anonymous_nodes = 'a',
            toggle_language_display = 'I',
            focus_language = 'f',
            unfocus_language = 'F',
            update = 'R',
            goto_node = '<cr>',
            show_help = '?',
        },
    },

    autotag = {
        enable = true,
    },
}
--]]
