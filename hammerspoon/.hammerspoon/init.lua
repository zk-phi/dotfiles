hs.window.animationDuration = 0
hs.alert.defaultStyle.textSize = 16
hs.alert.defaultStyle.radius = 8

--
-- Window Tiler
--

local WindowTiler = hs.loadSpoon("WindowTiler")

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

hs.hotkey.bind({ 'command', 'ctrl' }, 'right', WindowTiler.tileRight, WindowTiler.releaseRight)
hs.hotkey.bind({ 'command', 'ctrl' }, 'left', WindowTiler.tileLeft, WindowTiler.releaseLeft)
hs.hotkey.bind({ 'command', 'ctrl' }, 'up', WindowTiler.tileUp, WindowTiler.releaseUp)
hs.hotkey.bind({ 'command', 'ctrl' }, 'down',  WindowTiler.tileDown, WindowTiler.releaseDown)
