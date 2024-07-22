local wezterm = require("wezterm")
local config = {}
config.initial_cols = 120
config.initial_rows = 40
-- all of the themes: https://wezfurlong.org/wezterm/colorschemes/c/index.html
config.color_scheme = 'Chalk (base16)'
-- NOTE: example of multiple keys
-- {
--   key = "1",
--   mods = "CMD",
--   action = wezterm.action.Multiple({
--     wezterm.action.SendKey({mods = "CTRL", key = " "}),
--     wezterm.action.SendKey({key = "1"})
--   })
-- }

config.keys = {
  { key = "t", mods = "CMD|SHIFT", action = wezterm.action{SpawnTab="CurrentPaneDomain"} },
  { key = "n", mods = "CMD|SHIFT", action = wezterm.action{SpawnCommandInNewWindow={}}},
  { key = "w", mods = "CMD|SHIFT", action = wezterm.action{CloseCurrentTab={confirm=true}}},

  -- tmux leader \x16: <C-v>
  { key = "t", mods = "CMD", action = wezterm.action{SendString="\x16c"} },
  { key = "w", mods = "CMD", action = wezterm.action{SendString="\x16x"} },
  { key = "d", mods = "CMD", action = wezterm.action{SendString="\x16d"} },

  { key = "s", mods = "CMD", action = wezterm.action{SendString="\x16s"} },
  { key = "s", mods = "CMD|SHIFT", action = wezterm.action{SendString="\x16v"} },

  { key = ".", mods = "CMD", action = wezterm.action{SendString="\x16."} },
  { key = ",", mods = "CMD", action = wezterm.action{SendString="\x16,"} },

  { key = "g", mods = "CMD", action = wezterm.action{SendString="\x16g"} }, -- lazygit: <C-v>g
  { key = "f", mods = "CMD", action = wezterm.action{SendString="\x16f"} }, -- lf: <C-v>f

  { key = "l", mods = "CMD", action = wezterm.action{SendString="\x16l"} },
  { key = "u", mods = "CMD", action = wezterm.action{SendString="\x16u"} },

  { key = "z", mods = "CMD", action = wezterm.action{SendString="\x16z"} },
  { key = "p", mods = "CMD", action = wezterm.action{SendString="qingdao_lab_2022\n"}},

  -- tmux navigation
  { key = "h", mods = "CMD", action = wezterm.action{SendString="\027[1;5D"} },
  { key = "n", mods = "CMD", action = wezterm.action{SendString="\027[1;5B"} },
  { key = "e", mods = "CMD", action = wezterm.action{SendString="\027[1;5A"} },
  { key = "i", mods = "CMD", action = wezterm.action{SendString="\027[1;5C"} },
  -- { key = "h", mods = "CMD|SHIFT", action = wezterm.action{SendString="\x16H"} },
  -- { key = "n", mods = "CMD|SHIFT", action = wezterm.action{SendString="\x16N"} },
  -- { key = "e", mods = "CMD|SHIFT", action = wezterm.action{SendString="\x16E"} },
  -- { key = "i", mods = "CMD|SHIFT", action = wezterm.action{SendString="\x16I"} },

  -- tmux select window
  { key = "1", mods = "CMD", action = wezterm.action{SendString="\x161"} },
  { key = "2", mods = "CMD", action = wezterm.action{SendString="\x162"} },
  { key = "3", mods = "CMD", action = wezterm.action{SendString="\x163"} },
  { key = "4", mods = "CMD", action = wezterm.action{SendString="\x164"} },
  { key = "5", mods = "CMD", action = wezterm.action{SendString="\x165"} },
  { key = "6", mods = "CMD", action = wezterm.action{SendString="\x166"} },
  { key = "7", mods = "CMD", action = wezterm.action{SendString="\x167"} },
  { key = "8", mods = "CMD", action = wezterm.action{SendString="\x168"} },
  { key = "9", mods = "CMD", action = wezterm.action{SendString="\x169"} },
  { key = "0", mods = "CMD", action = wezterm.action{SendString="\x160"} },
}
config.font = wezterm.font_with_fallback({
  { family = "JetBrainsMono Nerd Font", weight = "Regular" },
  -- { family = "Microsoft YaHei", weight = "Regular" },
  { family = "LXGW WenKai Mono", weight = "Bold" },
  { family = "BlexMono Nerd Font", weight = "Regular" },
})
config.font_size = 14
return config
