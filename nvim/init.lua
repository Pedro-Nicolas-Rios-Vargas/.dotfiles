vim.g.mapleader = " "

-- Assign the copy/paste functions to wl-clipboard
vim.cmd [[
let g:clipboard = {
      \   'name': 'myClipboard',
      \   'copy': {
      \      '+': 'wl-copy',
      \      '*': 'wl-copy',
      \    },
      \   'paste': {
      \      '+': 'wl-paste',
      \      '*': 'wl-paste',
      \   },
      \   'cache_enabled': 1,
      \ }
]]

-- Load the plugins with packer
require "ordep.plugins"

-- Old plugins loader
-- vim.cmd ('so ~/.config/nvim/vim_scripts/pluggins_vim-plug.vim')
vim.cmd ('so ~/.config/nvim/vim_scripts/splitjoin_script.vim')

vim.cmd [[
augroup yanking
    au TextYankPost * lua vim.highlight.on_yank { higroup="IncSearch", timeout=150, on_visual=true }
augroup END
]]

require "ordep.nvimtree"

vim.cmd [[runtime plugin/astronauta.vim]]
require "ordep.lualineconf"
require "ordep.telescope"
require "ordep.cmp-config"
require "ordep.lsp"
require "ordep.indent"
--require "ordep.lspsaga"
require "ordep.treesitter"
require "ordep.treesitter-context-config"
require "ordep.lua-snippets"
require "ordep.todo-comments-config"

require "ordep.colorize"
-- vim.cmd 'colorscheme monalisa'
vim.cmd 'colorscheme my_gruvbox'
-- require "ordep.colors.my_material"
--vim.cmd 'colorscheme my_material'

require "ordep.autoscope"

-- require "ordep.test"
