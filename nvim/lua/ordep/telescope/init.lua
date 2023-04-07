local builtin = require('telescope.builtin')
local mapper = vim.keymap.set

local has_telescope, telescope = pcall(require, "telescope")
if not has_telescope then
    print("NEOVIM DOESN'T HAVE TELESCOPE PLUGGED IN")
    return
end

telescope.setup {
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
        file_sorter = require 'telescope.sorters'.get_fuzzy_file,
        file_ignore_patterns = {},
        generic_sorter = require 'telescope.sorters'.get_generic_fuzzy_sorter,
        winblend = 0,
        border = {},
        borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
        color_devicons = true,
        use_less = true,
        path_display = {},
        set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
        file_previewer = require 'telescope.previewers'.vim_buffer_cat.new,
        grep_previewer = require 'telescope.previewers'.vim_buffer_vimgrep.new,
        qflist_previewer = require 'telescope.previewers'.vim_buffer_qflist.new,
        -- Developer configurations: Not meant for general override
        buffer_previewer_maker = require 'telescope.previewers'.buffer_previewer_maker
    }
}

mapper('n', "<leader>bf", builtin.buffers, { desc = "Open Telescope window with all opened buffers on session."})
mapper('n', "<leader>ff", builtin.find_files, { desc = "Open Telescope window for find files."})
mapper('n', "<leader>gf", builtin.git_files, { desc = "Open Telescope window showing git files."})
mapper('n', "<leader>fh", builtin.help_tags, { desc = "Open Telescope window showing all help tags."})
mapper('n', "<leader>fr", builtin.live_grep, { desc = "Open Telescope window for find words in text files using ripgrep."})
mapper('n', "<leader>fc", builtin.colorscheme, { desc = "Open Telescope window showing all colorschemes installed."})
mapper('n', "<leader>kk", builtin.keymaps, { desc = "Open Telescope window showing all registered keymaps."})
