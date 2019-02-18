-- hello world
hs.hotkey.bind({"cmd", "ctrl"}, "W", function ()
  hs.notify.new({title="hello world", informativeText="hi"}):send()
end)

--reload hammerspoon config
hs.hotkey.bind({"cmd", "ctrl"}, "R", function ()
  hs.reload()
end)

-- arrow keys for Poker II keyboard
hs.hotkey.bind({"alt"}, "J", function ()
  hs.eventtap.keyStroke({}, "down")
end)

-- urlevent
hs.urlevent.bind("alert", function(eventName, params)
  hs.notify.new({title="alert", informativeText=params["text"]}):send()
end)

-- shrug
hs.hotkey.bind({"ctrl", "alt"}, "H", function ()
  hs.eventtap.keyStrokes("¯\\_(ツ)_/¯")
end)

-- table flip
hs.hotkey.bind({"cmd", "ctrl"}, "F", function ()
  hs.eventtap.keyStrokes("(╯°□°）╯︵ ┻━┻")
end)

-- caffine alternative in menu
local caffeine = hs.menubar.new()
function setCaffeineDisplay(state)
  if state then
    caffeine:setTitle("Awake")
    hs.notify.new({title="No Sleep", informativeText="'til Brooklyn"}):send()
  else
    caffeine:setTitle("Sleepy")
  end
end

function caffeineClicked()
  setCaffeineDisplay(hs.caffeinate.toggle("displayIdle"))
end

if caffeine then
  caffeine:setClickCallback(caffeineClicked)
  setCaffeineDisplay(hs.caffeinate.get("displayIdle"))
end

-- echo
lastKeys = ""
firstAlert = nil
echoTap = hs.eventtap.new({hs.eventtap.event.types.keyDown}, function(event)
  local newKeys = ""
  local keycode = event:getKeyCode()
  local flags = event:getFlags()
  local chars = event:getCharacters(true)
  if flags["cmd"] then
    newKeys = "⌘ + "
  end
  if flags["ctrl"] then
    newKeys = "ctrl + "
  end
  if string.sub(lastKeys, -1) == chars then
    newKeys = lastKeys
  end

  if keycode == 36 then
    hs.alert.closeAll()
    hs.alert("<return>")
    return false
  end
  if keycode == 48 then
    hs.alert.closeAll()
    hs.alert("<tab>")
    return false
  end
  if keycode == 49 then
    hs.alert.closeAll()
    hs.alert("<space>")
    return false
  end
  if keycode == 53 then
    hs.alert.closeAll()
    hs.alert("<esc>")
    return false
  end
  if newKeys == "" then newKeys = chars else newKeys = newKeys .. chars end
  if not (newKeys == lastKeys) then
    hs.alert.closeAll()
    hs.alert(newKeys)
  end
  lastKeys = newKeys
  return false
end)
echoMode = hs.hotkey.modal.new({"cmd", "ctrl"}, "e")
function echoMode:entered()
  echoTap:start()
  hs.alert.defaultStyle['atScreenEdge'] = 1
  hs.alert.defaultStyle['textSize'] = 40
  hs.alert("entered echo mode")
end
function echoMode:exited()
  echoTap:stop()
  hs.alert.defaultStyle['atScreenEdge'] = 0
  hs.alert("exited echo mode")
end
echoMode:bind({"cmd", "ctrl"}, "e", function() echoMode:exit() end)

-- make caps lock act like esc when tapped
send_escape = false
last_mods = {}

control_key_handler = function()
  send_escape = false
end

control_key_timer = hs.timer.delayed.new(0.15, control_key_handler)

control_handler = function(evt)
  local new_mods = evt:getFlags()
  if last_mods["ctrl"] == new_mods["ctrl"] then
    return false
  end
  if not last_mods["ctrl"] then
    last_mods = new_mods
    send_escape = true
    control_key_timer:start()
  else
    if send_escape then
      hs.eventtap.keyStroke({}, "ESCAPE")
    end
    last_mods = new_mods
    control_key_timer:stop()
  end
  return false
end

control_tap = hs.eventtap.new({hs.eventtap.event.types.flagsChanged}, control_handler)
control_tap:start()

other_handler = function(evt)
  send_escape = false
  return false
end

other_tap = hs.eventtap.new({hs.eventtap.event.types.keyDown}, other_handler)
other_tap:start()
