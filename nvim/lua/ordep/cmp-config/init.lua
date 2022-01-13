local has_words_before = function ()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]
    :sub(col, col):match("%s") == nil
end

local luasnip = require("luasnip")
local cmp = require("cmp")

vim.cmd [[
  set completeopt=menu,menuone,noselect
]]

cmp.setup({
    snippet = {
        expand = function(args)
            --vim.fn["vsnip#anonymous"](args.body)
            require("luasnip").lsp_expand(args.body)
        end,
    },
    mapping = {
        [ '<C-d>' ] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
        [ '<C-f>' ] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
        [ '<C-Space>' ] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
        [ '<C-e>' ] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        }),
        [ '<CR>' ] = cmp.mapping.confirm({ select = false }),
        [ '<C-n>' ] = cmp.mapping(function (fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end, { "i", "s" }),
        [ '<C-p>' ] = cmp.mapping(function (fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            else
                fallback()
            end
        end, { "i", "s" }),
    },
    sources = cmp.config.sources({
        { name = 'luasnip' },
        { name = 'nvim_lsp' },
        { name = 'nvim_lua' },
        --{ name = 'vsnip' },
        { name = 'path' },
        { name = 'calc' },
    }, {
        { name = 'buffer' },
    }),
    formatting = {
        format = require("lspkind").cmp_format({
            with_text = true,
            menu = ({
                buffer = "[Buffer]",
                nvim_lsp = "[LSP]",
                luasnip = "[LuaSnip]",
                nvim_lua = "[Lua]",
                --vsnip = "[vsnip]",
                path = "[Path]",
                calc = "[Calc]",
            }),
        }),
    },
    experimental = {
        native_menu = false,
        ghost_text = true,
    },
})

