vim.g.mapleader = " "

vim.cmd ('so ~/.config/nvim/vim_scripts/pluggins_vim-plug.vim')
vim.cmd ('so ~/.config/nvim/vim_scripts/splitjoin_script.vim')


-- vim.cmd 'colorscheme monalisa'
vim.cmd 'colorscheme my_material'

vim.cmd [[
augroup yanking
    au TextYankPost * lua vim.highlight.on_yank { higroup="IncSearch", timeout=150, on_visual=true }
augroup END
]]

vim.cmd [[runtime plugin/astronauta.vim]]
require "ordep.lualineconf"
require "ordep.telescope"
require "ordep.cmp-config"
require "ordep.lsp"
require "ordep.indent"
--require "ordep.lspsaga"
require "ordep.treesitter"
require "ordep.lua-snippets"
