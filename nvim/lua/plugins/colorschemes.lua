return {
  {
    "gruvbox-community/gruvbox",
    lazy = true,
  },
  {
    "folke/tokyonight.nvim",
    lazy = true,
  },
  {
    "catppuccin/nvim",
    name = 'catppuccin',
    lazy = true,
    opts = {
      flavour = "mocha",
      term_colors = true,
      transparent_background = false,
      styles = {
        comments = {},
        conditionals = {},
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
      },
      color_overrides = {
        mocha = {
          base = "#000000",
          mantle = "#000000",
          crust = "#000000",
        },
      },
      integrations = {
        cmp = true,
        nvimtree = true,
        treesitter = true,
        --[[
        telecope = {
        enabled = true,
        style = "nvchad",
        },
        --]]
      }
    }
  },
}
