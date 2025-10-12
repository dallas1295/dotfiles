return {
	"brenoprata10/nvim-highlight-colors",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require("nvim-highlight-colors").setup({
			render = "background",
			enable_hex = true,
			enable_short_hex = true,
			enable_rgb = true,
			enable_hsl = true,
			enable_var_usage = true,
			enable_named_colors = true,
			enable_tailwind = false,
			custom_colors = nil,
			exclude_filetypes = {
				"dashboard",
				"NvimTree",
				"lazy",
				"mason",
				"help",
				"terminal",
				"packer",
				"lspinfo",
				"TelescopePrompt",
				"TelescopeResults",
			},
		})
	end,
}