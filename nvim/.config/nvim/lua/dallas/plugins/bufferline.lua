return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		require("bufferline").setup({
			options = {
				mode = "buffers",
				themable = true,
				numbers = "none",
				close_command = "bdelete! %d",
				right_mouse_command = "bdelete! %d",
				left_mouse_command = "buffer %d",
				middle_mouse_command = nil,
				indicator = {
					icon = "",
					style = "none",
				},
				buffer_close_icon = "",
				modified_icon = "●",
				left_trunc_marker = "",
				right_trunc_marker = "",
				max_name_length = 18,
				max_prefix_length = 20,
				truncate_names = false,
				tab_size = 18,
				diagnostics = false,
				diagnostics_update_in_insert = false,
				color_icons = true,
				show_buffer_icons = true,
				show_buffer_close_icons = false,
				show_close_icon = false,
				show_tab_indicators = false,
				show_duplicate_prefix = true,
				persist_buffer_sort = true,
				separator_style = { "", "" },
				enforce_regular_tabs = true,
				always_show_bufferline = false,
				hover = {
					enabled = false,
				},
				sort_by = "insert_after_current",
			},
			highlights = {
				buffer_selected = {
					bg = "NONE",
					fg = { attribute = "fg", highlight = "Normal" },
					bold = true,
					italic = false,
				},
			},
		})

		-- Auto-toggle bufferline based on number of buffers
		vim.api.nvim_create_autocmd({ "BufAdd", "BufDelete" }, {
			callback = function()
				local buffers = vim.fn.getbufinfo({ buflisted = 1 })
				if #buffers > 1 then
					vim.opt.showtabline = 2
				else
					vim.opt.showtabline = 0
				end
			end,
		})

		-- Initial check
		vim.defer_fn(function()
			local buffers = vim.fn.getbufinfo({ buflisted = 1 })
			if #buffers > 1 then
				vim.opt.showtabline = 2
			else
				vim.opt.showtabline = 0
			end
		end, 100)

		-- Keybindings
		vim.keymap.set("n", "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", { desc = "Close buffers to left" })
		vim.keymap.set("n", "<leader>br", "<Cmd>BufferLineCloseRight<CR>", { desc = "Close buffers to right" })
	end,
}
