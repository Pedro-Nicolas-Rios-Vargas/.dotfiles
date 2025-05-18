-- option needed for colorizer
vim.opt.termguicolors = true

return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      options = {
        icons_enabled = true,
        -- theme = 'catpuccin', --'gruvbox_dark',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = {},
        always_divide_middle = true,
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff',
          { 'diagnostics', sources = { 'nvim_diagnostic', 'coc' } } },
        lualine_c = { 'filename' },
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' }
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {}
      },
      tabline = {},
      extensions = {}
    },
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
      enabled = true,
      debounce = 100,
      --[[
      indent = {
        char = { "│", }
      },
      whitespace = {
        highlight = { "Whitespace", "NonText" },
      },
      scope = {
        --exclude = { language = { "lua" } },
      }
      --]]
    },
  },
  {
    "j-hui/fidget.nvim",
    tag = "v1.2.0",
    config = function (_)
      require("ordep.fidget")
    end
  },
  {
    "norcalli/nvim-colorizer.lua",
    opts = {
      '*',
      html = {
        mode = 'foreground',
      }
    }
  },
}
