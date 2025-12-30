local obj = {};

-- Metadata

obj.name = "Window Tiler Spoon"
obj.version = "1.0"
obj.author = "zk-phi"
obj.license = "MIT"
obj.homepage = "https://github.com/zk-phi/dotfiles"

-- internal fns

local savedFrames = {}
local lastKnownFrames = {}
local currentCommand = nil

local function sameFrame (f1, f2)
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

local function moveWindow (position)
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

local function restoreWindow ()
  local window = hs.window.focusedWindow()
  if savedFrames[window:id()] then
    window:setFrame(savedFrames[window:id()])
    lastKnownFrames[window:id()] = savedFrames[window:id()]
  end
end

-- entrypoints

function obj:tileRight ()
  if currentCommand == 'up' then
    moveWindow({ x = 0.50, y = 0.00, w = 0.50, h = 0.50 })
  elseif currentCommand == 'down' then
    moveWindow({ x = 0.50, y = 0.50, w = 0.50, h = 0.50 })
  else
    currentCommand = 'right'
    moveWindow({ x = 0.50, y = 0.00, w = 0.50, h = 1.00 })
  end
end

function obj:releaseRight ()
  if currentCommand == 'right' then
    currentCommand = nil
  end
end

function obj:tileLeft ()
  if currentCommand == 'up' then
    moveWindow({ x = 0.00, y = 0.00, w = 0.50, h = 0.50 })
  elseif currentCommand == 'down' then
    moveWindow({ x = 0.00, y = 0.50, w = 0.50, h = 0.50 })
  else
    currentCommand = 'left'
    moveWindow({ x = 0.00, y = 0.00, w = 0.50, h = 1.00 })
  end
end

function obj:releaseLeft ()
  if currentCommand == 'left' then
    currentCommand = nil
  end
end

function obj:tileUp ()
  if currentCommand == 'left' then
    moveWindow({ x = 0.00, y = 0.00, w = 0.50, h = 0.50 })
  elseif currentCommand == 'right' then
    moveWindow({ x = 0.50, y = 0.00, w = 0.50, h = 0.50 })
  else
    currentCommand = 'up'
    moveWindow({ x = 0.00, y = 0.00, w = 1.00, h = 1.00 })
  end
end

function obj:releaseUp ()
  if currentCommand == 'up' then
    currentCommand = nil
  end
end

function obj:tileDown ()
  if currentCommand == 'left' then
    moveWindow({ x = 0.00, y = 0.50, w = 0.50, h = 0.50 })
  elseif currentCommand == 'right' then
    moveWindow({ x = 0.50, y = 0.50, w = 0.50, h = 0.50 })
  else
    currentCommand = 'down'
    restoreWindow()
  end
end

function obj:releaseDown ()
  if currentCommand == 'down' then
    currentCommand = nil
  end
end

return obj
