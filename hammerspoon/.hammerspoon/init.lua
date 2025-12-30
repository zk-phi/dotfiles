hs.window.animationDuration = 0
hs.alert.defaultStyle.textSize = 16
hs.alert.defaultStyle.radius = 8

--
-- Window Tiler
--

hs.loadSpoon("WindowTiler");

-- Window manipulation commands

-- default Mac commands:
--   C-left  next desktop
--   C-right previous desktop
--   C-up    List apps
--   C-down  List windows
--   M-tab   Cycle through apps
--   C-M-f   Toggle fullscreen

-- extra commands added by this script
--   C-M-left  Snap window to left
--   C-M-right Snap window to right
--   C-M-up    Maximize window
--   C-M-down  Restore window size

hs.hotkey.bind(
  { 'command', 'ctrl' },
  'right',
  function () spoon.WindowTiler:tileRight() end,
  function () spoon.WindowTiler:releaseRight() end
)

hs.hotkey.bind(
  { 'command', 'ctrl' },
  'left',
  function () spoon.WindowTiler:tileLeft() end,
  function () spoon.WindowTiler:releaseLeft() end
)

hs.hotkey.bind(
  { 'command', 'ctrl' },
  'up',
  function () spoon.WindowTiler:tileUp() end,
  function () spoon.WindowTiler:releaseUp() end
)

hs.hotkey.bind(
  { 'command', 'ctrl' },
  'down',
  function () spoon.WindowTiler:tileDown() end,
  function () spoon.WindowTiler:releaseDown() end
)
