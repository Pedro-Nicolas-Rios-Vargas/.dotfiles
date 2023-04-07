vim.g.gruvbox_contrast_dark = 'hard'
require 'lualine'.setup {
    options = {
        theme = 'gruvbox-material'
    }
}
vim.cmd [[
    runtime colors/gruvbox.vim
]]

function Gruvbox_conf()
    vim.g.gruvbox_contrast_dark = 'hard'
    vim.cmd [[
        runtime colors/gruvbox.vim
        hi Normal guibg=NONE ctermbg=NONE
    ]]
end
