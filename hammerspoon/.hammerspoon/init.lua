hs.window.animationDuration = 0

savedFrameSizes = {}

function moveWindow (position)
  local window = hs.window.focusedWindow()
  if savedFrameSizes[window:id()] == nil then
    savedFrameSizes[window:id()] = window:frame()
  end
  window:move(position, nil, true)
end

function restoreWindow ()
  local window = hs.window.focusedWindow()
  if savedFrameSizes[window:id()] then
    window:setFrame(savedFrameSizes[window:id()])
    savedFrameSizes[window:id()] = nil
  end
end

hs.hotkey.bind({ 'command', 'ctrl' }, 'right', function ()
  moveWindow({ x = 0.50, y = 0.00, w = 0.50, h = 1.00 })
end)

hs.hotkey.bind({ 'command', 'ctrl' }, 'left', function ()
  moveWindow({ x = 0.00, y = 0.00, w = 0.50, h = 1.00 })
end)

hs.hotkey.bind({ 'command', 'ctrl' }, 'up', function ()
  moveWindow({ x = 0.00, y = 0.00, w = 1.00, h = 1.00 })
end)

hs.hotkey.bind({ 'command', 'ctrl' }, 'down', function ()
  restoreWindow()
end)
