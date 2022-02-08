vim.g.material_style = 'deep ocean'

require'lualine'.setup {
    options = {
        theme = 'material-nvim'
    }
}

require("material").setup {
    contrast = {
        sidebars = true,
        floating_windows = true,
        line_numbers = true,
        sign_column = true,
        popup_menu = true,
        cursor_line = true,
        non_current_windows = true,
    },
    italics = {
        comments = false,
        strings = false,
        keywords = false,
        functions = false,
        variables = false
    },
    contrast_filetypes = {
        "terminal",
        "packer",
        "qf"
    },
    high_visibility = {
        lighter = false,
        darker = false
    },
    disable = {
        borders = false,
        background = false,
        term_colors = false,
        eob_lines = false
    },
    custom_highlights = {}
}

vim.cmd [[
    hi Normal guibg=NONE ctermbg=NONE
    runtime colors/material.vim
]]
