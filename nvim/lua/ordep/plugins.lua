local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    is_bootstrap = true
    vim.fn.system {
        'git',
        'clone',
        '--depth',
        '1',
        'https://github.com/wbthomason/packer.nvim',
        install_path
    }
    vim.cmd [[packadd packer.nvim]]
end

return require('packer').startup(function (use)
    -- Package manager
    use 'wbthomason/packer.nvim'

    -- Indent decorator
    use 'lukas-reineke/indent-blankline.nvim'

    use { -- Colorschemes
        'gruvbox-community/gruvbox',
        { 'marko-cerovac/material.nvim' }
    }

    use { -- LSP -> Brings helpers for the languages
        'neovim/nvim-lspconfig',
        requires = {
            'mfussenegger/nvim-jdtls', -- LSP plugin for java LSP...
                                       -- I never used...
                                       -- I think...
            'hrsh7th/vscode-langservers-extracted' -- required for vscode-lsp
        }
    }

    use { -- CMP -> Autocompletion
        'hrsh7th/nvim-cmp',
        requires = {
            'hrsh7th/cmp-calc', -- Calculator in neovim, just type '7 + 6'
            'hrsh7th/cmp-nvim-lua', -- Completion for lua lang
            'hrsh7th/cmp-path', -- shows the related directories in a path...
                                -- try typing '~/'
            'hrsh7th/cmp-nvim-lsp', -- Completion for neovim API
            'hrsh7th/cmp-buffer', -- Completion/recommendation of buffered words
            'hrsh7th/cmp-nvim-lsp-signature-help', -- Signature functions...
                                                   -- don't work so well
            'onsails/lspkind-nvim', -- Adds pictograms to neovim
            'L3MON4D3/LuaSnip', -- Snippet manager
            'saadparwaiz1/cmp_luasnip' -- Allow listing snippets in cmp
        }
    }

    use { -- Telescope -> Search bar
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        requires = {
            'nvim-lua/plenary.nvim',
            'nvim-lua/popup.nvim'
        }
    }

    -- 'Adds a bg color a #RGB string' but it doesn't work with treesitter
    -- active
    use 'ap/vim-css-color'

    use { -- Decoration for the line bar
        'nvim-lualine/lualine.nvim',
        requires = {
            {'ryanoasis/vim-devicons'}, -- Vim devicons
            {'kyazdani42/nvim-web-devicons', opt = true} -- Same as above one,
                                                         -- but it is needed
                                                         -- ¯\_(ツ)_/¯
        }
    }

    use { -- Treesitter -> Highlight, edit, and navigate code
        'nvim-treesitter/nvim-treesitter',
        run = function ()
            local ts_update = require('nvim-treesitter.install').update({
                with_sync = true,
            })
            ts_update()
        end
    }

    use { -- Additional text objects via treesitter... Pending to implement
        'nvim-treesitter/nvim-treesitter-textobjects',
        after = 'nvim-treesitter'
    }

    -- BEST FUNCTION EVER!
    use 'AndrewRadev/splitjoin.vim'

    use { -- Comment decorator
        'folke/todo-comments.nvim',
        -- requires = 'nvim-lua/plenary'
    }

    if is_bootstrap then
        require('packer').sync()
    end
end)
