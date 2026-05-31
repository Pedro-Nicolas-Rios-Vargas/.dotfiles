--[[
-- Winbar configuration from https://github.com/rachartier/dotfiles/blob/main/.config/nvim/lua/custom/themes/init.lua
--]]
--
local M = {}

local themes = {
  ["catppuccin-mocha"] = require("plugins.custom.themes.catppuccin.theme"),
  gruvbox = require("plugins.custom.themes.gruvbox.theme"),
  default = require("plugins.custom.themes.default.theme"),
}

M.current = vim.g.colors_name

function M.set_theme(name)
  if not themes[name] then
    error("Theme not found: " .. name)
  end
  M.current = name
end

function M.get_colors()
  return themes[M.current].get_colors()
end

return M
