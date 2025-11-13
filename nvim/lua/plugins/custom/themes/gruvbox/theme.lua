local M = {}

local base = require("plugins.custom.themes.base_palette")

function M.get_colors()
  local gp = require("gruvbox").palette
  local bg = vim.o.background
  local palette = {
    dark = {
      base = gp.dark0,
      mantle = gp.dark1,
      crust = gp.dark2,
      text = gp.gray,
      subtext1 = gp.light0,
      subtext0 = gp.light4,
      overlay2 = gp.light4,
      overlay1 = gp.dark4,
      overlay0 = gp.dark3,
      surface2 = gp.dark2,
      surface1 = gp.dark1,
      surface0 = gp.dark0_hard,
      blue = gp.bright_blue,
      lavender = gp.neutral_purple,
      sapphire = gp.dark_aqua,
      sky = gp.bright_blue,
      teal = gp.dark_green,
      green = gp.bright_green,
      yellow = gp.bright_yellow,
      peach = gp.bright_orange,
      maroon = gp.dark_red,
      red = gp.bright_red,
      mauve = gp.neutral_red,
      pink = gp.bright_purple,
      flamingo = gp.bright_red,
      rosewater = gp.bright_red,
    },
    light = {
      base = gp.light0,
      mantle = gp.light1,
      crust = gp.light2,
      text = gp.gray,
      subtext1 = gp.light3,
      subtext0 = gp.light4,
      overlay2 = gp.dark4,
      overlay1 = gp.dark1,
      overlay0 = gp.dark3,
      surface2 = gp.dark2,
      surface1 = gp.dark1,
      surface0 = gp.dark0,
      blue = gp.faded_blue,
      lavender = gp.faded_purple,
      sapphire = gp.light_aqua,
      sky = gp.faded_blue,
      teal = gp.light_green,
      green = gp.faded_green,
      yellow = gp.faded_yellow,
      peach = gp.faded_orange,
      maroon = gp.light_red,
      red = gp.faded_red,
      mauve = gp.faded_orange,
      pink = gp.faded_purple,
      flamingo = gp.faded_red,
      rosewater = gp.faded_red,
    }
  }

  base.validate(palette[bg])
  return palette[bg]
end

return M
