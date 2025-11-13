--[[
-- Winbar configuration from https://github.com/rachartier/dotfiles/blob/main/.config/nvim/lua/theme.lua
--]]

local M = {}

local theme_manager = require("plugins.custom.themes")

function M.setup()
  require("plugins.themes.groups").override_hl(theme_manager.get_colors())
end

function M.get_colors()
  return theme_manager.get_colors()
end

function M.get_lualine_colors()
  local c = theme_manager.get_colors()
  local lualine_colors = {
    bg = c.surface0,
    fg = c.subtext0,
    surface0 = c.surface0,
    yellow = c.yellow,
    flamingo = c.flamingo,
    cyan = c.shappire,
    darkblue = c.mantle,
    green = c.green,
    orange = c.peach,
    violet = c.lavender,
    mauve = c.mauve,
    blue = c.blue,
    red = c.red,
  }

  return vim.tbl_extend("force", lualine_colors, c)
end

return M
