vim.g.mapleader = " "
-- gruvbox global vars
vim.g.gruvbox_contrast_dark = "hard"

-- Assign the copy/paste functions to wl-clipboard
vim.g.clipboard = {
  name = 'myClipboard',
  copy = {
    ['+'] = 'wl-copy',
    ['*'] = 'wl-copy',
  },
  paste = {
    ['+'] = 'wl-paste',
    ['*'] = 'wl-paste',
  },
  cache_enabled = 1,
}


local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup("plugins")

-- vim.cmd ('so ~/.config/nvim/vim_scripts/pluggins_vim-plug.vim')
vim.cmd ('so ~/.config/nvim/vim_scripts/splitjoin_script.vim')

-- load augroups
require("ordep.groups")

vim.cmd [[ colorscheme gruvbox ]]

-- vim.cmd [[ colorscheme catppuccin ]]

-- require "ordep.autoscope"

-- require "ordep.test"
