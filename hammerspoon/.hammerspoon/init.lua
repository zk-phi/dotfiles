local C_ = { 'ctrl' }
local S_ = { 'shift' }
local M_ = { 'command' }
local C_S_ = { 'ctrl', 'shift' }
local M_S_ = { 'command', 'shift' }
local C_M_ = { 'ctrl', 'command' }
local C_M_S_ = { 'ctrl', 'command', 'shift' }

hs.window.animationDuration = 0
hs.alert.defaultStyle.textSize = 16
hs.alert.defaultStyle.radius = 8

--
-- Window Tiler
--

local WindowTiler = hs.loadSpoon('WindowTiler')

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

hs.hotkey.bind(C_M_, 'right', WindowTiler.tileRight, WindowTiler.releaseRight)
hs.hotkey.bind(C_M_, 'left', WindowTiler.tileLeft, WindowTiler.releaseLeft)
hs.hotkey.bind(C_M_, 'up', WindowTiler.tileUp, WindowTiler.releaseUp)
hs.hotkey.bind(C_M_, 'down',  WindowTiler.tileDown, WindowTiler.releaseDown)

--
-- EWOM
--

local EWOM = hs.loadSpoon('EWOM')

EWOM.setApplicationFilter(
  function (app)
    return app == 'Emacs' or app == 'iTerm2'
  end
)

EWOM.setInputMethodFilter(
  function (method)
    return method and method:find('SKK')
  end
)

function EWOM.cmd.myFourLinesUp (arg)
  for i = 1, math.max(1, arg) do
    EWOM.sendKey({}, 'up')
    EWOM.sendKey({}, 'up')
    EWOM.sendKey({}, 'up')
    EWOM.sendKey({}, 'up')
  end
end

function EWOM.cmd.myFourLinesDown (arg)
  for i = 1, math.max(1, arg) do
    EWOM.sendKey({}, 'down')
    EWOM.sendKey({}, 'down')
    EWOM.sendKey({}, 'down')
    EWOM.sendKey({}, 'down')
  end
end

function EWOM.cmd.myExpandRegion ()
  if EWOM.lastCommand == EWOM.cmd.myExpandRegion then
    EWOM.sendKey({ 'command', 'shift' }, 'right')
    EWOM.sendKey({ 'command', 'shift' }, 'left')
  else
    EWOM.sendKey({ 'option', 'shift' }, 'right')
    EWOM.sendKey({ 'option', 'shift' }, 'left')
  end
end

function EWOM.cmd.myKillLineBackward ()
  EWOM.sendKey({ 'command', 'shift' }, 'left')
  EWOM.sendKey({ 'command' }, 'x')
  EWOM.runHooks(EWOM.afterChangeHook)
end

function EWOM.cmd.myBackwardKillWord (arg)
  for i = 1, math.max(1, arg) do
    EWOM.sendKey({ 'option', 'shift' }, 'left')
    EWOM.sendKey({ 'command' }, 'x')
    EWOM.runHooks(EWOM.afterChangeHook)
  end
end

function EWOM.cmd.myNewlineBetween (arg)
  for i = 1, math.max(1, arg) do
    EWOM.sendKey({}, 'return')
    EWOM.sendKey({}, 'return')
    EWOM.sendKey({}, 'left')
  end
  EWOM.runHooks(EWOM.afterChangeHook)
end

function EWOM.cmd.myNextOpenedLine (arg)
  for i = 1, math.max(1, arg) do
    EWOM.sendKey({ 'command' }, 'right')
    EWOM.sendKey({}, 'return')
  end
  EWOM.runHooks(EWOM.afterChangeHook)
end

function EWOM.cmd.myBackwardTransposeWords ()
  EWOM.sendKey({ 'option' }, 'left')
  EWOM.sendKey({ 'option' }, 'left')
  EWOM.sendKey({ 'option' }, 'left')
  EWOM.sendKey({ 'option' }, 'right')
  EWOM.sendKey({ 'option', 'shift' }, 'right')
  EWOM.sendKey({ 'command' }, 'x')
  EWOM.usePasteboard(
    function ()
      EWOM.sendKey({ 'option' }, 'right')
      EWOM.sendKey({ 'command' }, 'v')
    end
  )
  EWOM.runHooks(EWOM.afterChangeHook)
end

function EWOM.cmd.myBackwardTransposeLines ()
  EWOM.sendKey({ 'command' }, 'right')
  EWOM.sendKey({ 'shift' }, 'up')
  EWOM.sendKey({ 'command', 'shift' }, 'right')
  EWOM.sendKey({ 'command' }, 'x')
  EWOM.usePasteboard(
    function ()
      EWOM.sendKey({}, 'up')
      EWOM.sendKey({ 'command' }, 'right')
      EWOM.sendKey({ 'command' }, 'v')
    end
  )
  EWOM.runHooks(EWOM.afterChangeHook)
end

function EWOM.cmd.mySmartComma ()
  EWOM.sendKey({}, ',')
  EWOM.sendKey({}, 'space')
  EWOM.runHooks(EWOM.afterChangeHook)
end

function EWOM.cmd.mySmartParen ()
  -- For JIS model
  EWOM.sendKey({ 'shift' }, '8')
  EWOM.sendKey({ 'shift' }, '9')
  -- -- For US model
  -- EWOM.sendKey({ 'shift' }, '9')
  -- EWOM.sendKey({ 'shift' }, '0')
  EWOM.sendKey({}, 'left')
  EWOM.runHooks(EWOM.afterChangeHook)
end

function EWOM.cmd.mySmartBrace ()
  -- For JIS model
  EWOM.sendKey({ 'shift' }, ']')
  EWOM.sendKey({ 'shift' }, '\\')
  -- -- For US model
  -- EWOM.sendKey({ 'shift' }, '[')
  -- EWOM.sendKey({ 'shift' }, ']')
  EWOM.sendKey({}, 'left')
  EWOM.runHooks(EWOM.afterChangeHook)
end

function EWOM.cmd.mySmartBracket ()
  local title = hs.window.focusedWindow():title()
  if title:find("Cosense") or title:find("scrapbox") then
    EWOM.sendKey({}, ']')
  else
    EWOM.sendKey({}, ']')
    EWOM.sendKey({}, '\\')
    EWOM.sendKey({}, 'left')
  end
  EWOM.runHooks(EWOM.afterChangeHook)
end

EWOM.registerBaseKeymap()

EWOM.globalSetKey({}, '[', EWOM.cmd.mySmartBracket)
EWOM.globalSetKey({}, ',', EWOM.cmd.mySmartComma)
EWOM.globalSetKey(S_, '9', EWOM.cmd.mySmartParen)
EWOM.globalSetKey(S_, '[', EWOM.cmd.mySmartBrace)

EWOM.globalSetKey(C_, '`', EWOM.cmd.ignore)
EWOM.globalSetKey(C_, '1', EWOM.cmd.digitArgument)
EWOM.globalSetKey(C_, '2', EWOM.cmd.digitArgument)
EWOM.globalSetKey(C_, '3', EWOM.cmd.digitArgument)
EWOM.globalSetKey(C_, '4', EWOM.cmd.digitArgument)
EWOM.globalSetKey(C_, '5', EWOM.cmd.digitArgument)
EWOM.globalSetKey(C_, '6', EWOM.cmd.digitArgument)
EWOM.globalSetKey(C_, '7', EWOM.cmd.digitArgument)
EWOM.globalSetKey(C_, '8', EWOM.cmd.digitArgument)
EWOM.globalSetKey(C_, '9', EWOM.cmd.digitArgument)
EWOM.globalSetKey(C_, '0', EWOM.cmd.digitArgument)
EWOM.globalSetKey(C_, '-', EWOM.cmd.undo, true)
EWOM.globalSetKey(C_, '=', EWOM.cmd.textScaleIncrease)
EWOM.globalSetKey(C_, 'q', EWOM.cmd.unsupported('quotedInsert'))
EWOM.globalSetKey(C_, 'w', EWOM.cmd.killRegion)
EWOM.globalSetKey(C_, 'e', EWOM.cmd.endOfLine)
EWOM.globalSetKey(C_, 'r', EWOM.cmd.unsupported('queryReplace'))
EWOM.globalSetKey(C_, 't', EWOM.cmd.myBackwardTransposeWords)
EWOM.globalSetKey(C_, 'y', EWOM.cmd.yank)
EWOM.globalSetKey(C_, 'u', EWOM.cmd.scrollDown, true)
EWOM.globalSetKey(C_, 'i', EWOM.cmd.indentForTab, true)
EWOM.globalSetKey(C_, 'o', EWOM.cmd.openLine, true)
EWOM.globalSetKey(C_, 'p', EWOM.cmd.previousLine, true)
EWOM.globalSetKey(C_, '[', EWOM.cmd.remap({}, 'escape'))
EWOM.globalSetKey(C_, ']', EWOM.cmd.keyboardQuit)
EWOM.globalSetKey(C_, 'a', EWOM.cmd.unsupported('multipleCursors'))
EWOM.globalSetKey(C_, 's', EWOM.cmd.isearch)
EWOM.globalSetKey(C_, 'd', EWOM.cmd.deleteChar)
EWOM.globalSetKey(C_, 'f', EWOM.cmd.forwardChar, true)
EWOM.globalSetKey(C_, 'g', EWOM.cmd.keyboardQuit)
EWOM.globalSetKey(C_, 'h', EWOM.cmd.deleteBackwardChar, true)
EWOM.globalSetKey(C_, 'j', EWOM.cmd.beginningOfLine)
EWOM.globalSetKey(C_, 'k', EWOM.cmd.killLine)
EWOM.globalSetKey(C_, 'l', EWOM.cmd.unsupported('recenter'))
EWOM.globalSetKey(C_, ';', EWOM.cmd.unsupported('commentDwim'))
EWOM.globalSetKey(C_, '\'', EWOM.cmd.ignore)
EWOM.globalSetKey(C_, '\\', EWOM.cmd.ignore)
EWOM.globalSetKey(C_, 'z', EWOM.cmd.suspendFrame)
EWOM.globalSetKey(C_, 'x', EWOM.cmd.cx)
EWOM.globalSetKey(C_, 'c', EWOM.cmd.unsupported('C-c *'))
EWOM.globalSetKey(C_, 'v', EWOM.cmd.scrollUp, true)
EWOM.globalSetKey(C_, 'b', EWOM.cmd.backwardChar, true)
EWOM.globalSetKey(C_, 'n', EWOM.cmd.nextLine, true)
EWOM.globalSetKey(C_, 'm', EWOM.cmd.newline)
EWOM.globalSetKey(C_, ',', EWOM.cmd.myExpandRegion)
EWOM.globalSetKey(C_, '.', EWOM.cmd.unsupported('includeAnywhere'))
EWOM.globalSetKey(C_, '/', EWOM.cmd.ignore)
EWOM.globalSetKey(C_, 'space', EWOM.cmd.setMarkCommand)

EWOM.globalSetKey(C_M_, '`', EWOM.cmd.ignore)
EWOM.globalSetKey(C_M_, '1', EWOM.cmd.digitArgument)
EWOM.globalSetKey(C_M_, '2', EWOM.cmd.digitArgument)
EWOM.globalSetKey(C_M_, '3', EWOM.cmd.digitArgument)
EWOM.globalSetKey(C_M_, '4', EWOM.cmd.digitArgument)
EWOM.globalSetKey(C_M_, '5', EWOM.cmd.digitArgument)
EWOM.globalSetKey(C_M_, '6', EWOM.cmd.digitArgument)
EWOM.globalSetKey(C_M_, '7', EWOM.cmd.digitArgument)
EWOM.globalSetKey(C_M_, '8', EWOM.cmd.digitArgument)
EWOM.globalSetKey(C_M_, '9', EWOM.cmd.digitArgument)
EWOM.globalSetKey(C_M_, '0', EWOM.cmd.digitArgument)
EWOM.globalSetKey(C_M_, '-', EWOM.cmd.redo, true)
EWOM.globalSetKey(C_M_, '=', EWOM.cmd.textScaleDecrease)
EWOM.globalSetKey(C_M_, 'q', EWOM.cmd.ignore)
EWOM.globalSetKey(C_M_, 'w', EWOM.cmd.killRingSave)
EWOM.globalSetKey(C_M_, 'e', EWOM.cmd.endOfLine) -- end-of-defun
EWOM.globalSetKey(C_M_, 'r', EWOM.cmd.unsupported('replace'))
EWOM.globalSetKey(C_M_, 't', EWOM.cmd.myBackwardTransposeLines)
EWOM.globalSetKey(C_M_, 'y', EWOM.cmd.yank) -- expand-oneshot-snippet
EWOM.globalSetKey(C_M_, 'u', EWOM.cmd.beginningOfBuffer)
EWOM.globalSetKey(C_M_, 'i', EWOM.cmd.unsupported('fillParagraph'))
EWOM.globalSetKey(C_M_, 'o', EWOM.cmd.myNewlineBetween)
EWOM.globalSetKey(C_M_, 'p', EWOM.cmd.myFourLinesUp, true)
EWOM.globalSetKey(C_M_, '[', EWOM.cmd.remap({ 'option' }, 'escape'))
EWOM.globalSetKey(C_M_, ']', EWOM.cmd.ignore)
EWOM.globalSetKey(C_M_, 'a', EWOM.cmd.unsupported('multipleCursors'))
EWOM.globalSetKey(C_M_, 's', EWOM.cmd.unsupported('isearchBackward'))
EWOM.globalSetKey(C_M_, 'd', EWOM.cmd.killWord)
EWOM.globalSetKey(C_M_, 'f', EWOM.cmd.forwardWord, true)
EWOM.globalSetKey(C_M_, 'g', EWOM.cmd.keyboardQuit)
EWOM.globalSetKey(C_M_, 'h', EWOM.cmd.myBackwardKillWord)
EWOM.globalSetKey(C_M_, 'j', EWOM.cmd.beginningOfLine) -- beginning-of-defun
EWOM.globalSetKey(C_M_, 'k', EWOM.cmd.myKillLineBackward)
EWOM.globalSetKey(C_M_, 'l', EWOM.cmd.unsupported('retop'))
EWOM.globalSetKey(C_M_, ';', EWOM.cmd.ignore)
EWOM.globalSetKey(C_M_, '\'', EWOM.cmd.ignore)
EWOM.globalSetKey(C_M_, '\\', EWOM.cmd.unsupported('indentRegion'))
EWOM.globalSetKey(C_M_, 'z', EWOM.cmd.ignore)
EWOM.globalSetKey(C_M_, 'x', EWOM.cmd.unsupported('evalDefun'))
EWOM.globalSetKey(C_M_, 'c', EWOM.cmd.launch('Calculator'))
EWOM.globalSetKey(C_M_, 'v', EWOM.cmd.endOfBuffer)
EWOM.globalSetKey(C_M_, 'b', EWOM.cmd.backwardWord, true)
EWOM.globalSetKey(C_M_, 'n', EWOM.cmd.myFourLinesDown, true)
EWOM.globalSetKey(C_M_, 'm', EWOM.cmd.myNextOpenedLine)
EWOM.globalSetKey(C_M_, ',', EWOM.cmd.markWholeBuffer)
EWOM.globalSetKey(C_M_, '.', EWOM.cmd.unsupported('xref'))
EWOM.globalSetKey(C_M_, '/', EWOM.cmd.unsupported('dabbrev'))

-- Most 'M-*' bindings are reserved for built-in shortcuts
EWOM.globalSetKey(M_, '2', EWOM.cmd.tabNew)
EWOM.globalSetKey(M_, '9', EWOM.cmd.tabPrevious)
EWOM.globalSetKey(M_, '0', EWOM.cmd.tabNext)
EWOM.globalSetKey(M_, 'd', EWOM.cmd.finder)
EWOM.globalSetKey(M_, 'f', EWOM.cmd.spotlight)
EWOM.globalSetKey(M_, 'k', EWOM.cmd.tabClose)
EWOM.globalSetKey(M_, 'x', EWOM.cmd.spotlight) -- execute-extended-command
-- EWOM.globalSetKey(M_, 'm', EWOM.cmd.repeatLastCommand, true)

-- Unspecified 'C-x *' bindings are ignored by default (see EWOM.spoon/init.lua)
EWOM.defineKey(EWOM.cxMap, C_, '9', EWOM.cmd.kmacroStartMacro)
EWOM.defineKey(EWOM.cxMap, C_, '0', EWOM.cmd.kmacroEndMacro)
EWOM.defineKey(EWOM.cxMap, C_, 'w', EWOM.cmd.writeFile)
EWOM.defineKey(EWOM.cxMap, C_, 's', EWOM.cmd.saveBuffer)
EWOM.defineKey(EWOM.cxMap, C_, 'k', EWOM.cmd.tabClose)
EWOM.defineKey(EWOM.cxMap, C_, 'c', EWOM.cmd.killApp)
EWOM.defineKey(EWOM.cxMap, C_, 'm', EWOM.cmd.kmacroEndAndCallMacro)
