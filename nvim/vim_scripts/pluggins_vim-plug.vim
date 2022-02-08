" Install vim-plug if not found
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
    silent execute '!sh -c curl -fLo '.data_dir.'/site/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
    \| PlugInstall --sync | source $MYVIMRC
    \| endif
call plug#begin('~/.nvim/plugged')

" indent decorator

Plug 'lukas-reineke/indent-blankline.nvim'

" colorscheme
" {{{
Plug 'gruvbox-community/gruvbox'
Plug 'marko-cerovac/material.nvim'
" }}}

" LSP
" {{{
" lsp requirements
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-calc'
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/nvim-cmp'
Plug 'onsails/lspkind-nvim'

" HTML, CSS, JSON
" vscode-lsp requirements
Plug 'hrsh7th/vscode-langservers-extracted'

"}}}

" vscode snippet
" {{{
"Plug 'hrsh7th/cmp-vsnip'
"Plug 'hrsh7th/vim-vsnip'
"Plug 'hrsh7th/vim-vsnip-integ'
"Plug 'rafamadriz/friendly-snippets'
" }}}

" LuaSnip plugs
" {{{
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
" }}}
" telescope pluggins
" {{{
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

Plug 'ap/vim-css-color'
" }}}

" Neovim bar decorator
" {{{
" Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'
Plug 'nvim-lualine/lualine.nvim'

Plug 'ryanoasis/vim-devicons'
Plug 'kyazdani42/nvim-web-devicons'
" }}}

" Plug for remap with lua, now using vim.keymap
" Plug 'tjdevries/astronauta.nvim'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update

Plug 'AndrewRadev/splitjoin.vim'

" Comments highlights
Plug 'folke/todo-comments.nvim'
call plug#end()
