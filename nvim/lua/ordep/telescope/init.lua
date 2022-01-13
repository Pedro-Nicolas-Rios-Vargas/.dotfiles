local nnoremap = vim.keymap.nnoremap

local has_telescope, telescope = pcall(require, "telescope")
if not has_telescope then
    print("NEOVIM DOESN'T HAVE TELESCOPE PLUGGED IN")
    return
end

telescope.setup{
    defaults = {
        vimgrep_arguments = {
            'rg',
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--smart-case'
        },
        prompt_prefix = " ",
        selection_caret = " ",
        entry_prefix = "  ",
        initial_mode = "insert",
        selection_strategy = "reset",
        sorting_strategy = "descending",
        layout_strategy = "horizontal",
        layout_config = {
            horizontal = {
              mirror = false,
            },
            vertical = {
              mirror = false,
            },
        },
        file_sorter =  require'telescope.sorters'.get_fuzzy_file,
        file_ignore_patterns = {},
        generic_sorter =  require'telescope.sorters'.get_generic_fuzzy_sorter,
        winblend = 0,
        border = {},
        borderchars = { '─', '│', '-', '│', '╭', '╮', '╯', '╰' },
        color_devicons = true,
        use_less = true,
        path_display = {},
        set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
        file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
        grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
        qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,

        -- Developer configurations: Not meant for general override
        buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker
    }
}

nnoremap { "<leader>bf", '<cmd>Telescope buffers<CR>' }
nnoremap { "<leader>ff", '<cmd>Telescope find_files<CR>' }
nnoremap { "<leader>gf", '<cmd>Telescope git_files<CR>' }
nnoremap { "<leader>fb", '<cmd>Telescope file_browser<CR>' }
nnoremap { "<leader>fh", '<cmd>Telescope help_tags<CR>' }
nnoremap { "<leader>fr", '<cmd>Telescope grep_string<CR>' }
nnoremap { "<leader>fc", '<cmd>Telescope colorscheme<CR>' }
