local mapper = vim.keymap.set
local builtin = require("telescope.builtin")

mapper('n', "<leader>bf",  builtin.buffers, { desc = "[Telescope] Open Telescope window with all opened buffers on session."  })
mapper('n', "<leader>ff",  builtin.find_files, { desc = "[Telescope] Open Telescope window for find files."  } )
mapper('n', "<leader>gf",  builtin.git_files, { desc = "[Telescope] Open Telescope window showing git files."  } )
mapper('n', "<leader>fh",  builtin.help_tags, { desc = "[Telescope] Open Telescope window showing all help tags."  } )
mapper('n', "<leader>fr",  builtin.live_grep, { desc = "[Telescope] Open Telescope window for find words in text files using ripgrep."  } )
mapper('n', "<leader>fc",  builtin.colorscheme, { desc = "[Telescope] Open Telescope window showing all colorschemes installed."  } )
mapper('n', "<leader>kk",  builtin.keymaps, { desc = "[Telescope] Open Telescope window showing all registered keymaps."  } )

