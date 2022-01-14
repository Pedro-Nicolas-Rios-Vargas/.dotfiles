local mapper = vim.keymap.set

mapper({ 'n', 'v', }, '<C-z>', '<nop>')
mapper('n', '+', '10<C-w><')
mapper('n', '-', '10<C-w>>')

mapper('i', "<A-)>", "``<C-c>i")
mapper('i', '<A-">', '""<C-c>i')
mapper('i', "<A-'>", "''<C-c>i")
mapper('i', "<A-(>", "()<C-c>i")
mapper('i', "<A-{>", "{)<C-c>i")
mapper('i', "<A-[>", "[]<C-c>i")
mapper('i', "<A-<>", "<><C-c>i")
mapper('i', "{<CR>", "{<CR>)<C-c>O")
mapper('i', "[<CR>", "[<CR>]<C-c>O<Tab>")

mapper('v', "J", " :m '>+1'<CR>gv=gv")
mapper('v', "K", " :m '<-2'<CR>gv=gv")
mapper('v', ">", ">gv")
mapper('v', "<", "<gv")

