vim.g.material_style = 'deep ocean'
require'lualine'.setup {
    options = {
        theme = 'material-nvim'
    }
}

require("material").setup {
    contrast = false,
    borders = false,

    popup_menu = "dark",

    italics = {
        comments = false,
        keywords = false,
        functions = false,
        strings = false,
        variables = false
    },
    contrast_windows = {
        "terminal",
        "packer",
        "qf"
    },
    text_contrast = {
        lighter = false,
        darker = false
    },
    disable = {
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
