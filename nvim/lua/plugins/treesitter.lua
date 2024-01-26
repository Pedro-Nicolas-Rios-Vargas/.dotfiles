return {
  {
    "nvim-treesitter/nvim-treesitter",
    config = function (_, opts)
      require("ordep.treesitter.setup").setup()
    end
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    opts = {
      enable = true, -- Enable this plugin (Can be enabled/disabled via commands)
      max_lines = 0, -- How many lines the window should span. Values <= 0 means
                     -- no limit.
      min_window_height = 0, -- Minimum editor window height to enable context.
                             -- Values <= 0 mean no limit.
      line_numbers = true,
      multiline_threshold = 20, -- Maximum number of lines to collapse for a
                                -- single context line.
      trim_scope = 'outer', -- Which context lines to discard if 'max_lines' is
                            -- exceeded. Choices: 'inner', 'outer'
      mode = 'cursor', -- Line used to calculate context. Choices 'cursor',
                       -- 'topline'
      separator = nil, -- Separator between context and content. Should be a
                       -- single character string, like '-'.
                       --
                       -- When separator is set, the context will only show up
                       -- when there are at least 2 lines above cursorline.
      zindex = 20, -- The Z-index of the context window
      on_attach = nil, -- (fun(buf: integer): boolean) return false to disable
                       -- attaching
    },
    config = function (_, opts)
      require('treesitter-context').setup(opts)
    end,
  },
  {
    "folke/twilight.nvim",
  },
  'nvim-treesitter/nvim-treesitter-textobjects',
  --[[
  -- playground is deprecated because Neovim already implement Treesitter node's
  -- view, just use :Inspect :InspectTree or :EditQuery
  "nvim-treesitter/playground",
  --]]
  "windwp/nvim-ts-autotag"
}
