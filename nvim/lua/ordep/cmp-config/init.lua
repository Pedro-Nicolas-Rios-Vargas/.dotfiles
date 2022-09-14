local has_words_before = function ()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]
    :sub(col, col):match("%s") == nil
end

-- local luasnip = require("luasnip")
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
    mapping = cmp.mapping.preset.insert({
        [ '<C-d>' ] = cmp.mapping.scroll_docs(-4),
        [ '<C-f>' ] = cmp.mapping.scroll_docs(4),
        [ '<C-Space>' ] = cmp.mapping.complete(),
        [ '<C-e>' ] = cmp.mapping.abort(),
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
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp_signature_help'},
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
    view = {
        entries = 'native', -- old experimental.native_menu
    },
    window = {
        documentation = true,
    },
    experimental = {
        ghost_text = true,
    },
})

