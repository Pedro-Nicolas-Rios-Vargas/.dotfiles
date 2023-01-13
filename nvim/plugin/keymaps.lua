local mapper = vim.keymap.set

-- unable process frezzing
mapper({ 'n', 'v', }, '<C-z>', '<nop>')
--
-- WINDOWS KEYMAPS
-- increase/decrease window width
mapper('n', '+', '10<C-w><')
mapper('n', '-', '10<C-w>>')

--
-- FAST BLOCKS
-- open backtick block
mapper('i', "<A-)>", "``<C-c>i")
-- open double quote block
mapper('i', '<A-">', '""<C-c>i')
-- open single quote block
mapper('i', "<A-'>", "''<C-c>i")
-- open parentheses block
mapper('i', "<A-(>", "()<C-c>i")
-- open brackets block
mapper('i', "<A-{>", "{}<C-c>i")
-- open braces block
mapper('i', "<A-[>", "[]<C-c>i")
-- open diamond braces block
mapper('i', "<A-<>", "<><C-c>i")
-- start a indented bracket block
mapper('i', "{<CR>", "{<CR>}<C-c>O")
-- start a indented brace block
mapper('i', "[<CR>", "[<CR>]<C-c>O<Tab>")

--
-- VISUAL BLOCK LINE MANAGEMENT
-- let move selected lines one line up
mapper('v', "J", " :m '>+1'<CR>gv=gv")
-- let move selected lines one line down
mapper('v', "K", " :m '<-2'<CR>gv=gv")
-- add indentation to selected lines
mapper('v', ">", ">gv")
-- decrease indentation to selected lines
mapper('v', "<", "<gv")

local contador = 0
function ListItem()
    contador = contador + 1
    return contador .. '. '
end
function ListReset()
    contador = 0
    return ''
end
mapper('i', '<C-L>', ListItem, { expr = true })
mapper('i', '<C-R>', ListReset, { expr = true })

