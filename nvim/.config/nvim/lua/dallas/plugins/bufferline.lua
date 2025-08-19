return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = "echasnovski/mini.icons",
	config = function()
		local bufferline = require("bufferline")
		local mini_icons = require("mini.icons")
		bufferline.setup({
			options = {
				diagnostics = "nvim_lsp",
				diagnostics_update_on_event = true,
				name_formatter = function(buf)
					local name = vim.fn.fnamemodify(buf.name, ":t:r")
					return name
				end,
				get_element_icon = function(element)
					-- element.path is the full file path
					local ext = vim.fn.fnamemodify(element.path, ":e")
					local icon, hl = mini_icons.get("file", element.path, ext)
					return icon, hl
				end,
				style_preset = { bufferline.style_preset.noitalic, bufferline.style_preset.minimal },
				show_buffer_close_icons = false,
				separator_style = "thin",
				enforce_regular_tabs = true,
				always_show_bufferline = false,
				auto_toggle_bufferline = true,
				tab_size = 16,
			},
		})
	end,
}
