local terminal = "ghostty"
local fileManager = "ghostty -e yazi"
local music = "spotify"
local browser = "brave"

local mainMod = "SUPER"

-- Apps
hl.bind(mainMod .. "+RETURN", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. "+Q", hl.dsp.window.close())
hl.bind("SUPER+SHIFT+END", hl.dsp.exit())
hl.bind(mainMod .. "+E", hl.dsp.exec_cmd(fileManager))
hl.bind("SUPER+SHIFT+F", hl.dsp.window.fullscreen({ mode = "maximized" }))
hl.bind(mainMod .. "+TAB", hl.dsp.window.cycle_next())
hl.bind(mainMod .. "+SPACE", hl.dsp.exec_cmd("rofi -show drun"))
hl.bind("ALT+SPACE", hl.dsp.exec_cmd("rofi -show drun"))
hl.bind(mainMod .. "+SHIFT+SPACE", hl.dsp.exec_cmd("rofi -show run"))
hl.bind(mainMod .. "+M", hl.dsp.exec_cmd(music))
hl.bind(mainMod .. "+B", hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. "+W", hl.dsp.exec_cmd("hiddify"))
hl.bind(mainMod .. "+G", hl.dsp.exec_cmd('gtk-launch "Steam (No VPN)"'))

-- Column resize (scrolling layout)
hl.bind(mainMod .. "+V", hl.dsp.layout("colresize +conf"))
hl.bind(mainMod .. "+SHIFT+V", hl.dsp.layout("colresize -conf"))
hl.bind(mainMod .. "+SHIFT+EQUAL", hl.dsp.layout("colresize +conf"))
hl.bind(mainMod .. "+SHIFT+MINUS", hl.dsp.layout("colresize -conf"))
hl.bind(mainMod .. "+F", hl.dsp.layout("colresize 1.0"))

-- System
hl.bind("SUPER+ALT+L", hl.dsp.exec_cmd("hyprlock"))
hl.bind("SUPER+SHIFT+P", hl.dsp.exec_cmd("rofi -show power-menu -modi power-menu:rofi-power-menu"))
hl.bind("SUPER+SHIFT+S", hl.dsp.exec_cmd("hyprshot -m window"))
hl.bind(mainMod .. "+S", hl.dsp.exec_cmd("hyprshot -m region"))
hl.bind(mainMod .. "+BACKSLASH", hl.dsp.exec_cmd("hyprpicker"))
hl.bind(mainMod .. "+I", hl.dsp.exec_cmd("ghostty -e btop"))

-- Window management
hl.bind("SUPER+ALT+V", hl.dsp.window.pseudo())
hl.bind("SUPER+SHIFT+R", hl.dsp.layout("movetoroot"))

-- Focus movement
hl.bind(mainMod .. "+H", hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. "+L", hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. "+K", hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. "+J", hl.dsp.focus({ direction = "d" }))

-- Window movement
hl.bind(mainMod .. "+SHIFT+H", hl.dsp.window.move({ direction = "l" }))
hl.bind(mainMod .. "+SHIFT+L", hl.dsp.window.move({ direction = "r" }))
hl.bind(mainMod .. "+SHIFT+K", hl.dsp.window.move({ direction = "u" }))
hl.bind(mainMod .. "+SHIFT+J", hl.dsp.window.move({ direction = "d" }))

-- Resize
hl.bind(mainMod .. "+9", hl.dsp.window.resize({ x = -20, y = -20, relative = true }))
hl.bind(mainMod .. "+0", hl.dsp.window.resize({ x = 20, y = 20, relative = true }))

-- Workspace switching
for i = 1, 10 do
	local key = i % 10 -- 10 maps to key 0
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Column swap (scrolling layout)
hl.bind(mainMod .. "+PERIOD", hl.dsp.layout("swapcol r"))
hl.bind(mainMod .. "+COMMA", hl.dsp.layout("swapcol l"))

-- Monitor focus if used
-- hl.bind(mainMod .. "SHIFT+COMMA", hl.dsp.focus({ monitor = "l" }))
-- hl.bind(mainMod .. "SHIFT+PERIOD", hl.dsp.focus({ monitor = "r" }))
-- Workspace scrolling
hl.bind(mainMod .. "+EQUAL", hl.dsp.focus({ workspace = "+1" }))
hl.bind(mainMod .. "+MINUS", hl.dsp.focus({ workspace = "-1" }))

-- Move window to workspace
hl.bind(mainMod .. "+SHIFT+1", hl.dsp.window.move({ workspace = 1 }))
hl.bind(mainMod .. "+SHIFT+2", hl.dsp.window.move({ workspace = 2 }))
hl.bind(mainMod .. "+SHIFT+3", hl.dsp.window.move({ workspace = 3 }))
hl.bind(mainMod .. "+SHIFT+4", hl.dsp.window.move({ workspace = 4 }))
hl.bind(mainMod .. "+SHIFT+5", hl.dsp.window.move({ workspace = 5 }))
hl.bind(mainMod .. "+SHIFT+6", hl.dsp.window.move({ workspace = 6 }))
hl.bind(mainMod .. "+SHIFT+7", hl.dsp.window.move({ workspace = 7 }))
hl.bind(mainMod .. "+SHIFT+8", hl.dsp.window.move({ workspace = 8 }))

-- -- Mouse wheel workspace scroll
-- hl.bind(mainMod .. "+MOUSE_DOWN", hl.dsp.focus({ workspace = "e+1" }))
-- hl.bind(mainMod .. "+MOUSE_UP", hl.dsp.focus({ workspace = "e-1" }))
--
-- -- Mouse binds
-- hl.bind(mainMod .. "+mouse:272", hl.dsp.window.drag(), { mouse = true })
-- hl.bind(mainMod .. "+mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Volume
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"),
	{ repeating = true, locked = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
	{ repeating = true, locked = true }
)
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true })

-- Brightness
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl s 5%+"), { repeating = true, locked = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl s 5%-"), { repeating = true, locked = true })

-- Media
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
