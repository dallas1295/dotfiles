return {
	"windwp/nvim-autopairs",
	event = "InsertEnter",
	config = function()
		require("nvim-autopairs").setup({
			disable_filetype = { "TelescopePrompt", "spectre_panel" },
			disable_in_macro = false,
			disable_in_visualblock = false,
			ignored_next_char = [=[[%w%%%'%[%"%.%`%$]]=],
			enable_moveright = true,
			enable_afterquote = true,
			check_ts = false,
			map_bs = true,
			map_c_h = false,
			map_c_w = false,
		})
	end,
}