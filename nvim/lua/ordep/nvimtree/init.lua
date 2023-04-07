vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- this line is needed but already is set in 'plugin/options.lua'
-- vim.opt.termguicolors = true

require('nvim-tree').setup({
    sort_by = "case_sensitive",
    renderer = {
        group_empty = true,
    },
    filters = {
        dotfiles = true,
    },
})
