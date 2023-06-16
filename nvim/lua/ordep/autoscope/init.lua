local config = {
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
}
require("autoclose").setup(config)
