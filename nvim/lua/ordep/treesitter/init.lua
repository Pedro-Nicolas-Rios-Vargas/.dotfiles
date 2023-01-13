require("nvim-treesitter.configs").setup {
    ensure_installed = { "c", "lua", "vim", "help", "java", "python",
                         "javascript", "css", "html", "bash", "arduino",
                         "markdown", "markdown_inline", "mermaid", "json" },
    highlight = {
        enable = true,
    },
    incremental_selection = {
        enable = true
    },
    textobjects = {
        enable = true
    },
}
