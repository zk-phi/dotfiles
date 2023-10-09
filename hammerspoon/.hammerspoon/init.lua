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

hs.window.animationDuration = 0
hs.alert.defaultStyle.textSize = 16
hs.alert.defaultStyle.radius = 8

--
-- Window Tiler
--

savedFrames = {}
lastKnownFrames = {}
currentCommand = nil

function sameFrame (f1, f2)
  if f1 and
    f2 and
    math.abs(f1.x - f2.x) == 0 and
    math.abs(f1.y - f2.y) == 0 and
    math.abs(f1.h - f2.h) == 0 and
    math.abs(f1.w - f2.w) == 0 then
    return true
  else
    return false
  end
end

function moveWindow (position)
  local window = hs.window.focusedWindow()
  local frame = window:frame()
  -- either
  -- 1. lastKnownFrames is not set (= first invocation) or
  -- 2. user hand-modified the window size
  if not sameFrame(frame, lastKnownFrames[window:id()]) then
    hs.alert("Frame size saved")
    savedFrames[window:id()] = frame
  end
  window:move(position, nil, true)
  lastKnownFrames[window:id()] = window:frame()
end

function restoreWindow ()
  local window = hs.window.focusedWindow()
  if savedFrames[window:id()] then
    window:setFrame(savedFrames[window:id()])
    lastKnownFrames[window:id()] = savedFrames[window:id()]
  end
end

hs.hotkey.bind(
  { 'command', 'ctrl' },
  'right',
  function ()
    if currentCommand == 'up' then
      moveWindow({ x = 0.50, y = 0.00, w = 0.50, h = 0.50 })
    elseif currentCommand == 'down' then
      moveWindow({ x = 0.50, y = 0.50, w = 0.50, h = 0.50 })
    else
      currentCommand = 'right'
      moveWindow({ x = 0.50, y = 0.00, w = 0.50, h = 1.00 })
    end
  end,
  function ()
    if currentCommand == 'right' then
      currentCommand = nil
    end
  end
)

hs.hotkey.bind(
  { 'command', 'ctrl' },
  'left',
  function ()
    if currentCommand == 'up' then
      moveWindow({ x = 0.00, y = 0.00, w = 0.50, h = 0.50 })
    elseif currentCommand == 'down' then
      moveWindow({ x = 0.00, y = 0.50, w = 0.50, h = 0.50 })
    else
      currentCommand = 'left'
      moveWindow({ x = 0.00, y = 0.00, w = 0.50, h = 1.00 })
    end
  end,
  function ()
    if currentCommand == 'left' then
      currentCommand = nil
    end
  end
)

hs.hotkey.bind(
  { 'command', 'ctrl' },
  'up',
  function ()
    if currentCommand == 'left' then
      moveWindow({ x = 0.00, y = 0.00, w = 0.50, h = 0.50 })
    elseif currentCommand == 'right' then
      moveWindow({ x = 0.50, y = 0.00, w = 0.50, h = 0.50 })
    else
      currentCommand = 'up'
      moveWindow({ x = 0.00, y = 0.00, w = 1.00, h = 1.00 })
    end
  end,
  function ()
    if currentCommand == 'up' then
      currentCommand = nil
    end
  end
)

hs.hotkey.bind(
  { 'command', 'ctrl' },
  'down',
  function ()
    if currentCommand == 'left' then
      moveWindow({ x = 0.00, y = 0.50, w = 0.50, h = 0.50 })
    elseif currentCommand == 'right' then
      moveWindow({ x = 0.50, y = 0.50, w = 0.50, h = 0.50 })
    else
      currentCommand = 'down'
      restoreWindow()
    end
  end,
  function ()
    if currentCommand == 'down' then
      currentCommand = nil
    end
  end
)
