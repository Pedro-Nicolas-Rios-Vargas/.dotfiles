local mapper = vim.keymap.set

-- unable process frezzing
mapper({ 'n', 'v', }, '<C-z>', '<nop>', { desc = "PERSONAL Disable <C-z> kmap." })
--
-- WINDOWS KEYMAPS
-- increase/decrease window width
mapper('n', '+', '10<C-w><', { desc = "PERSONAL Increase windows width." })
mapper('n', '-', '10<C-w>>', { desc = "PERSONAL Decrease windows width." })

--
-- FAST BLOCKS
-- open backtick block
mapper('i', "<A-)>", "``<C-c>i", { desc = "PERSONAL Open Apostrophe block and place the cursor inside."})
-- open double quote block
mapper('i', '<A-">', '""<C-c>i', { desc = "PERSONAL Open quote block and place the cursor inside." })
-- open single quote block
mapper('i', "<A-'>", "''<C-c>i", { desc = "PERSONAL Open single quote block and place the cursor inside." })
-- open parentheses block
mapper('i', "<A-(>", "()<C-c>i", { desc = "PERSONAL Open parentheses block and place the cursor inside." })
-- open brackets block
mapper('i', "<A-{>", "{}<C-c>i", { desc = "PERSONAL Open curly braces block and place the cursor inside." })
-- open braces block
mapper('i', "<A-[>", "[]<C-c>i", { desc = "PERSONAL Open square braces block and place the cursor inside." })
-- open diamond braces block
mapper('i', "<A-<>", "<><C-c>i", { desc = "PERSONAL Open angle braces block and place the cursor inside." })
-- start a indented bracket block
mapper('i', "{<CR>", "{<CR>}<C-c>O", { desc = "PERSONAL Open curly braces block with new line and place the cursor inside." })
-- start a indented brace block
mapper('i', "[<CR>", "[<CR>]<C-c>O<Tab>", { desc = "PERSONAL Open square braces block with new line and place the cursor inside." })

--
-- VISUAL BLOCK LINE MANAGEMENT
-- let move selected lines one line up
mapper('v', "J", " :m '>+1'<CR>gv=gv", { desc = "PERSONAL Let move selected lines one line up without affecting unselected lines." })
-- let move selected lines one line down
mapper('v', "K", " :m '<-2'<CR>gv=gv", { desc = "PERSONAL Let move selected lines one line down without affecting unselected lines." })
-- add indentation to selected lines
mapper('v', ">", ">gv", { desc = "PERSONAL Add indentation to selected lines." })
-- decrease indentation to selected lines
mapper('v', "<", "<gv", { desc = "PERSONAL Decrease indentation to selected lines." })

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

