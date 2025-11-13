--[[
-- Winbar configuration from https://github.com/rachartier/dotfiles/blob/main/.config/nvim/lua/themes/catpuccin/init.lua
--]]
local M = {}
local base = require("plugins.custom.themes.base_palette")

function M.get_colors()
  local palette = require("catppuccin.palettes").get_palette(vim.g.catppuccin_flavour)

  base.validate(palette)
  return palette
end

return M

