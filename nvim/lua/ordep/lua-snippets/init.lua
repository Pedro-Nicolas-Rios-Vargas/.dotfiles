local function prequire(...)
    local status, lib = pcall(require, ...)
    if (status) then return lib end
    return nil
end

local luasnip = prequire('luasnip')

local t = function (str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function ()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

_G.tab_complete = function()
    if luasnip and luasnip.expand_or_jumpable() then
        return t("<Plug>luasnip-expand-or-jump")
    elseif check_back_space() then
        return t "<Tab>"
    end
    return ""
end
_G.s_tab_complete = function()
    if luasnip and luasnip.jumpable(-1) then
        return t("<Plug>luasnip-jump-prev")
    else
        return t "<S-Tab>"
    end
    return ""
end

vim.api.nvim_set_keymap("i", "<A-d>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<A-d>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<A-s>", "v:lua.s_tab_complete()", { expr = true })
vim.api.nvim_set_keymap("s", "<A-s>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<C-E>", "<Plug>luasnip-next-choice", {})
vim.api.nvim_set_keymap("s", "<C-E>", "<Plug>luasnip-next-choice", {})

require('ordep.lua-snippets.snippets')
