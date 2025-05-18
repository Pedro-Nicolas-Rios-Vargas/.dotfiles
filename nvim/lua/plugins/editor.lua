-- global vars for nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

return {
  { "nvim-tree/nvim-tree.lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      sort = {
        sorter = "case_sensitive",
      },
      view = {
        width = "25%"
      },
      renderer = {
        group_empty = true,
      },
      filters = {
        dotfiles = true,
      },
    },
    keys = {
      { "<leader>t", ":NvimTreeToggle<CR>", desc = "[NvimTree] Toggle the NvimTree Buffer." },
    }
  },
  { "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    config = function ()
      require("ordep.telescope.setup")
      require("ordep.telescope.keys")
    end,
  },
  { "folke/todo-comments.nvim",
    opts = {
      signs = true,      -- show icons in the signs column
      sign_priority = 8, -- sign priority
      -- keywords recognized as todo comments
      keywords = {
        -- FIX: Example of fix highlight
        FIX = {
          icon = " ", -- icon used for the sign, and in search results
          color = "error", -- can be a hex color, or a named color (see below)
          alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
          -- signs = false, -- configure signs for some keywords individually
        },
        -- TODO: Example of todo highlight
        TODO = {
          icon = " ",
          color = "info",
        },
        -- HACK: Example of hack highlight
        HACK = {
          icon = " ",
          color = "warning",
        },
        -- WARN: Example of warn highlight
        WARN = {
          icon = " ",
          color = "warning",
          alt = { "WARNING", "XXX" },
        },
        -- PERF: Example of performance highlight
        PERF = {
          icon = " ",
          alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" },
        },
        -- NOTE: Example of note highlight
        NOTE = {
          icon = " ",
          color = "hint",
          alt = { "INFO" },
        },
      },
      merge_keywords = true, -- when true, custom keywords will be merged with the defaults
      -- highlighting of the line containing the todo comment
      -- * before: highlights before the keyword (typically comment characters)
      -- * keyword: highlights of the keyword
      -- * after: highlights after the keyword (todo text)
      highlight = {
        before = "",                       -- "fg" or "bg" or empty
        keyword = "wide",                  -- "fg", "bg", "wide" or empty. (wide is the same as bg, but will also highlight surrounding characters)
        after = "fg",                      -- "fg" or "bg" or empty
        pattern = [[.*<(KEYWORDS)\s*:]],   -- pattern or table of patterns, used for highlightng (vim regex)
        comments_only = true,              -- uses treesitter to match keywords in comments only
        max_line_len = 400,                -- ignore lines longer than this
        exclude = {},                      -- list of file types to exclude highlighting
      },
      -- list of named colors where we try to extract the guifg from the
      -- list of hilight groups or use the hex color if hl not found as a fallback
      colors = {
        error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
        warning = { "DiagnosticWarning", "WarningMsg", "#FBBF24" },
        info = { "DiagnosticInfo", "#2563EB" },
        hint = { "DiagnosticHint", "#10B981" },
        default = { "Identifier", "#7C3AED" },
      },
      search = {
        command = "rg",
        args = {
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
        },
        -- regex that will be used to match keywords.
        -- don't replace the (KEYWORDS) placeholder
        pattern = [[\b(KEYWORDS):]],   -- ripgrep regex
        -- pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
      },
    },
  },
  {
    "folke/trouble.nvim",
    opts = {},
    cmd = "Trouble",
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "TROUBLE-NVIM Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "TROUBLE-NVIM Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "TROUBLE-NVIM Symbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "TROUBLE-NVIM LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "TROUBLE-NVIM Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "TROUBLE-NVIM Quickfix List (Trouble)",
      },
    },
  }
}
