hs.window.animationDuration = 0

savedFrames = {}
lastKnownFrames = {}

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
  if not sameFrame(frame, lastKnownFrames[window:id()]) then
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
  function () moveWindow({ x = 0.50, y = 0.00, w = 0.50, h = 1.00 }) end
)

hs.hotkey.bind(
  { 'command', 'ctrl' },
  'left',
  function () moveWindow({ x = 0.00, y = 0.00, w = 0.50, h = 1.00 }) end
)

hs.hotkey.bind(
  { 'command', 'ctrl' },
  'up',
  function () moveWindow({ x = 0.00, y = 0.00, w = 1.00, h = 1.00 }) end
)

hs.hotkey.bind(
  { 'command', 'ctrl' },
  'down',
  function () restoreWindow() end
)
