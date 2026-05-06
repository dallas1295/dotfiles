hl.window_rule({
	name = "suppress-maximize-events",
	match = { class = ".*" },
	suppress_event = "maximize",
})

hl.window_rule({
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},
	no_focus = true,
})

hl.window_rule({
	name = "move-hyprland-run",
	match = { class = "hyprland-run" },
	move = "20 monitor_h-120",
	float = true,
})

hl.window_rule({ match = { class = "firefox" }, workspace = "2" })
hl.window_rule({ match = { class = "zen" }, workspace = "2" })
hl.window_rule({ match = { class = "brave-bin" }, workspace = "2" })
hl.window_rule({ match = { class = "helium" }, workspace = "2" })

hl.window_rule({
	name = "pip",
	match = { title = "Picture-in-picture" },
	float = true,
	size = "495 287",
	move = "1383 864",
	pin = true,
	opaque = true,
	no_initial_focus = true,
	border_size = 2,
})

hl.window_rule({
	name = "pipc",
	match = { title = "Picture in picture" },
	float = true,
	size = "495 287",
	move = "1412 777",
	pin = true,
	opaque = true,
	no_initial_focus = true,
	border_size = 2,
})

hl.window_rule({
	name = "ghostty",
	match = { class = "com.mitchellh.ghostty" },
	opacity = "0.95",
	workspace = "1",
})

hl.window_rule({
	name = "steam",
	match = { class = "steam" },
	workspace = "3 silent",
})

hl.window_rule({
	name = "friendslist",
	match = { title = "Friends List" },
	workspace = "3 silent",
	size = "435 1089",
})

hl.window_rule({
	name = "heroic",
	match = { class = "heroic" },
	workspace = "3 silent",
})

hl.window_rule({
	name = "discord",
	match = { class = "discord" },
	workspace = "3 silent",
})

hl.window_rule({ match = { class = "org.prismlauncher.PrismLauncher" }, workspace = "3" })

hl.window_rule({
	name = "vpn",
	match = { class = "Mullvad VPN" },
	workspace = "2",
	float = true,
	move = "1444 60",
})

hl.window_rule({
	name = "passwd",
	match = { class = "Bitwarden" },
	workspace = "4",
	size = "651 601",
	move = "897 74",
})

hl.window_rule({
	name = "spotify",
	match = { class = "spotify" },
	workspace = "3",
	-- size = "859 960",
	-- move = "15 130",
})

hl.window_rule({
	name = "bluetooth",
	match = { class = "blueman-manager" },
	float = true,
	size = "651 452",
})
