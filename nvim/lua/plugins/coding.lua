return {
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "rafamadriz/friendly-snippets",
      config = function ()
        require("luasnip.loaders.from_vscode").lazy_load()
        require("ordep.lua-snippets.keymaps")
      end,
    },
  },
  {
    "hrsh7th/nvim-cmp",
    version = false,
    dependencies = {
      'hrsh7th/cmp-calc',                          -- Calculator in neovim, just type '7 + 6'
      'hrsh7th/cmp-nvim-lua',                      -- Completion for lua lang
      'hrsh7th/cmp-path',                          -- shows the related directories in a path...
      -- try typing '~/'
      'hrsh7th/cmp-nvim-lsp',                      -- Completion for neovim API
      'hrsh7th/cmp-buffer',                        -- Completion/recommendation of buffered words
      'hrsh7th/cmp-nvim-lsp-signature-help',       -- Signature functions...
      -- don't work so well
      'onsails/lspkind-nvim',                      -- Adds pictograms to neovim
      'L3MON4D3/LuaSnip',                          -- Snippet manager
      'saadparwaiz1/cmp_luasnip',                   -- Allow listing snippets in cmp
    },
    opts = function ()
      local has_words_before = function ()
          local line, col = unpack(vim.api.nvim_win_get_cursor(0))
          return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]
          :sub(col, col):match("%s") == nil
      end
      local cmp = require("cmp")

      return {
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
            { name = 'nvim_lsp_signature_help' },
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
            completion = cmp.config.window.bordered(),
            documentation = cmp.config.window.bordered(),
        },
        experimental = {
            ghost_text = true,
        },
      }
    end,
  },
  {
    "m4xshen/autoclose.nvim",
    opts = {
      --[[
      --  options in keys:
      --      -> escape:  If set to true, pressing the character again will 
      --                  escape it instead of inserting a closing character.
      --
      --      -> close:	If set to true, pressing the character will insert both
      --               	the opening and closing characters, and place the
      --               	cursor between them.
      --
      --      -> pair:    The string that represents the pair of opening and
      --                  closing characters. This should be a two-character
      --                  string, with the opening character first and the
      --                  closing character second.
      --]]
      keys = {
        ["("] = { escape = false, close = true, pair = "()"},
        ["["] = { escape = false, close = true, pair = "[]"},
        ["{"] = { escape = false, close = true, pair = "{}"},
        ["<"] = { escape = false, close = true, pair = "<>"},

        [">"] = { escape = true, close = false, pair = "<>"},
        [")"] = { escape = true, close = false, pair = "()"},
        ["]"] = { escape = true, close = false, pair = "[]"},
        ["}"] = { escape = true, close = false, pair = "{}"},

        ['"'] = { escape = true, close = true, pair = '""'},
        ["'"] = { escape = true, close = true, pair = "''"},
        ["`"] = { escape = true, close = true, pair = "``"},
      },
      options = {
        disabled_filetypes = { "text" },
        disable_when_touch = true,
        pair_spaces = true,
        auto_indent = true
      },
    },
  },
}
