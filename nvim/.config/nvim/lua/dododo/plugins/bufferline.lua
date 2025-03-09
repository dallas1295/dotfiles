return {
	"akinsho/bufferline.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	version = "*",
	opts = {
		options = {
			mode = "buffers",
			close_command = "bdelete!%d",
			left_mouse_command = "buffer%d",
			diagnostics = "nvim_lsp",
			show_buffer_icons = "true",
			seperator_style = "sloped",
			auto_toggle_bufferline = true,
			sort_by = "insert_after_current",
		},
	},
}
