local M = {}

function M.setup()
  local has_ts, ts = pcall(require, "nvim-treesitter.configs")
  if not has_ts then
    print("Treesitter module not present. Skipping setup...")
  end

  local config = {
    ensure_installed = {
      "c",
      "lua",
      "vim",
      "vimdoc",
      "java",
      "python",
      "javascript",
      "css",
      "html",
      "htmldjango",
      "bash",
      "arduino",
      "markdown",
      "markdown_inline",
      "mermaid",
      "json",
    },
    sync_install = true,
    auto_install = true,
    incremental_selection = {
      enable = true,
    },

    -- Tresitter modules...
    highlight = {
      enable = true,
    },
    textobjects = {
      enable = true,
    },
    --[[
    -- playground is deprecated because Neovim already implement Treesitter node's
    -- view, just use :Inspect :InspectTree or :EditQuery
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
    --]]
    autotag = {
      enable = true,
    },
  }
  ts.setup(config)
end
return M
