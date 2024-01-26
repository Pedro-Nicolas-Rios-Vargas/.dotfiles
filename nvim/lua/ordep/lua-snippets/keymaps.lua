local has_luasnip, ls = pcall(require, "luasnip")

if not has_luasnip then
  print("Luasnip module not present. Skiping keymaps setup...")
  return
end

local mapper = vim.keymap.set

mapper({ "i", "s" }, "<A-d>", function () ls.expand() end, { silent = true, desc = "LuaSnip Expand the snippet in INSERT and SELECT mode" })
mapper({ "i", "s" }, "<A-s>", function () ls.jump(1) end, { silent = true, desc = "LuaSnip jump to the previous option of the snippet in INSERT and SELECT mode" })
mapper({ "i", "s" }, "<A-e>", function () ls.jump(-1) end, { silent = true, desc = "LuaSnip jumps to the next field choice INSERT and SELECT mode" })
