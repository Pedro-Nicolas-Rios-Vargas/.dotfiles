local mapper = vim.keymap.set

-- unable process frezzing
mapper({ 'n', 'v', }, '<C-z>', '<nop>', { desc = "PERSONAL Disable <C-z> kmap." })
--
-- WINDOWS KEYMAPS
-- increase/decrease window width
mapper('n', '+', '10<C-w><', { desc = "PERSONAL Increase windows width." })
mapper('n', '-', '10<C-w>>', { desc = "PERSONAL Decrease windows width." })

-- open terminal in nvim
mapper('n', '<C-t>', ':vsplit term://zsh', { desc = "PERSONAL Open in a vertical split a zsh terminal" })
-- reload the actual file in nvim
mapper('n', '<leader>r', ':so %<CR>', { desc = "PERSONAL Reload the file in neovim" })
--[[
--
-- NOTE: DEPRECATED FOR autoclose.lua plugin
--
-- FAST BLOCKS
-- open backtick block
mapper('i', "`", "``<C-c>i", { desc = "PERSONAL Open Apostrophe block and place the cursor inside."})
-- open double quote block
mapper('i', '"', '""<C-c>i', { desc = "PERSONAL Open quote block and place the cursor inside." })
-- open single quote block
mapper('i', "'", "''<C-c>i", { desc = "PERSONAL Open single quote block and place the cursor inside." })
-- open parentheses block
mapper('i', "(", "()<C-c>i", { desc = "PERSONAL Open parentheses block and place the cursor inside." })
mapper('i', ")", "<C-c>va(<C-c>a", { desc = "PERSONAL Go to the close parenthesis of the context block and place the cursor outside." })
-- open brackets block
mapper('i', "{", "{}<C-c>i", { desc = "PERSONAL Open curly braces block and place the cursor inside." })
mapper('i', "}", "<C-c>va{<C-c>a", { desc = "PERSONAL Go to the close curly brace of the context block and place the cursor outside." })
-- open braces block
mapper('i', "[", "[]<C-c>i", { desc = "PERSONAL Open square braces block and place the cursor inside." })
mapper('i', "]", "<C-c>va[<C-c>a", { desc = "PERSONAL Go to the close square brace of the context block and place the cursor outside." })
-- open diamond braces block
mapper('i', "<", "<><C-c>i", { desc = "PERSONAL Open angle braces block and place the cursor inside." })
mapper('i', ">", "<C-c>va<<C-c>a", { desc = "PERSONAL Go to the close angle brace of the context block and place the cursor outside." })
-- start a indented bracket block
mapper('i', "{<CR>", "{<CR>}<C-c>O", { desc = "PERSONAL Open curly braces block with new line and place the cursor inside." })
-- start a indented brace block
mapper('i', "[<CR>", "[<CR>]<C-c>O<Tab>", { desc = "PERSONAL Open square braces block with new line and place the cursor inside." })

-- Move selected text into block closures.
mapper('v', "(", "di(<C-c>pa)<C-c>i", { desc = "PERSONAL Move the selected text to parentheses." })
mapper('v', "[", "di[<C-c>pa]<C-c>i", { desc = "PERSONAL Move the selected text to square brackets." })
mapper('v', "{", "di{<C-c>pa}<C-c>i", { desc = "PERSONAL Move the selected text to curly braces." })
mapper('v', '"', 'di"<C-c>pa"<C-c>i', { desc = "PERSONAL Move the selected text to doble quote." })
mapper('v', "'", "di'<C-c>pa'<C-c>i", { desc = "PERSONAL Move the selected text to single quote." })
mapper('v', "`", "di`<C-c>pa`<C-c>i", { desc = "PERSONAL Move the selected text to Apostrophe quote." })
--]]


-- VISUAL BLOCK LINE MANAGEMENT
-- let move selected lines one line up
mapper('v', "J", " :m '>+1'<CR>gv=gv", { desc = "PERSONAL Let move selected lines one line up without affecting unselected lines." })
-- let move selected lines one line down
mapper('v', "K", " :m '<-2'<CR>gv=gv", { desc = "PERSONAL Let move selected lines one line down without affecting unselected lines." })
-- add indentation to selected lines
mapper('v', ">", ">gv", { desc = "PERSONAL Add indentation to selected lines." })
-- decrease indentation to selected lines
mapper('v', "<", "<gv", { desc = "PERSONAL Decrease indentation to selected lines." })

-- deactivate highlight search
mapper('n', "<CR>", function()
    return vim.v.hlsearch and ":nohl<CR>" or "<CR>"
end, {
    desc = "PERSONAL Deactivate the highlight search with ENTER (<CR>)",
    expr = true,
})


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

