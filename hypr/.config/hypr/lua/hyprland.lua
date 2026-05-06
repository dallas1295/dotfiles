require("keybinds")
require("rules")
require("rules")

hl.env({ ELECTRON_OZONE_PLATFORM_HINT = "auto" })

hl.env({ XCURSOR_SIZE = 20 })
hl.env({ HYPRCURSOR_SIZE = 20 })

-- Laptop Screen
hl.monitor({
	output = "eDP-1",
	mode = "preferred@120",
	position = "auto",
	scale = "1.6",
})

-- Home Monitor
hl.monitor({
	output = "HDMI-A-1",
	mode = "1920x1080@144",
	position = "auto",
	scale = "1",
})

-- Configuration
hl.config({
	general = {

		gaps_in = 2,
		gaps_out = 4,

		border_size = 1,

		layout = "scrolling",
		resize_on_border = true,

		allow_tearing = false,

		col = { active_border = "rgba(b4d4cfff)", inactive_border = "rgba(1a1b26ff)" },
	},

	scrolling = {
		column_width = "0.8",
		explicit_column_widths = "0.333, 0.5, 0.666",
		fullscreen_on_one_column = false,
	},

	dwindle = {
		pseudotile = true,
	},

	master = {
		new_status = "master",
	},

	misc = {
		force_default_wallpaper = false,
		disable_hyprland_logo = true,
		vrr = 3,
	},

	render = {
		direct_scanout = 2,
	},

	input = {
		kb_layout = "us",
		kb_options = "caps:escape",

		accel_profile = "flat",
		follow_mouse = false,

		sensitivity = "0",

		touchpad = {
			natural_scroll = true,
			scroll_factor = "0.35",
			disable_while_typing = false,
		},
	},

	decoration = {
		rounding = 5,
		rounding_power = 5,

		active_opacity = 1,
		inactive_opacity = 0.85,
		fullscreen_opacity = 1,

		shadow = {
			enabled = false,
			range = 4,
			render_power = 3,
			color = "rgba(1d2021FF)",
		},

		blur = {
			enabled = true,
			size = 2,
			passes = 2,
			new_optimizations = true,
			popups = true,

			vibrancy = 1,
		},
	},

	animations = {
		enabled = true,
	},
})

hl.gesture({
	fingers = 3,
	direction = "horizontal",
	action = "workspace",
})

hl.device = {
	name = "tpps/2-elan-trackpoint",
}

-- Autostart on Hyprland initialization
hl.on("hyprland.start", function()
	hl.exec_cmd("/usr/lib/xdg-desktop-portal-hyprland")
	hl.exec_cmd("/usr/lib/xdg-desktop-portal -r")
	hl.exec_cmd("waybar & hyprpaper & hypridle")
	hl.exec_cmd("wlpaste --type text --watch cliphist store")
	hl.exec_cmd("wlpaste --type image --watch cliphist store")
	hl.exec_cmd("kanshi") -- Screen Switcher
	hl.exec_cmd("syncthing")
	hl.exec_cmd("mullvad-vpn")
	hl.exec_cmd("ghostty")
end)
