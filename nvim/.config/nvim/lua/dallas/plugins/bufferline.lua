return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		local bufferline = require("bufferline")
		require("bufferline").setup({
			options = {
				show_buffer_close_icons = false,
				always_show_bufferline = false,
				auto_toggle_bufferline = true,

				diagnostics = "nvim_lsp",
				diagnostics_indicator = function(count, level)
					local icon = level:match("error") and " " or " "
					return " " .. icon .. count
				end,

				seperator_style = "thin",
				style_preset = {
					bufferline.style_preset.no_italic,
					bufferline.style_preset.minimal,
					bufferline.style_preset.no_bold,
				},
			},
		})
	end,
}
