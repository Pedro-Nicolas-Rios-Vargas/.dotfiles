local inoremap = vim.keymap.inoremap
local nnoremap = vim.keymap.nnoremap
local vnoremap = vim.keymap.vnoremap
local noremap = vim.keymap.noremap

noremap { "<C-z>", "<nop>" }
nnoremap { "+", "10<C-w><" }
nnoremap { "-", "10<C-w>>" }

inoremap { "<A-}>", "``<C-c>i" }
inoremap { '<A-">', '""<C-c>i' }
inoremap { "<A-'>", "''<C-c>i" }
inoremap { "<A-(>", "()<C-c>i" }
inoremap { "<A-{>", "{}<C-c>i" }
inoremap { "<A-[>", "[]<C-c>i" }
inoremap { "<A-<>", "<><C-c>i" }
inoremap { "{<CR>", "{<CR>}<C-c>O" }
inoremap { "[<CR>", "[<CR>]<C-c>O<Tab>" }

vnoremap { "J", " :m '>+1'<CR>gv=gv" }
vnoremap { "K", " :m '<-2'<CR>gv=gv" }
vnoremap { ">", ">gv" }
vnoremap { "<", "<gv" }

