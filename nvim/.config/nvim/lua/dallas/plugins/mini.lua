return {
	"echasnovski/mini.nvim",
	version = false,
	config = function()
		--appearance
		-- require("mini.files").setup({
		-- 	mappings = {
		-- 		close = "q",
		-- 		go_in = "l",
		-- 		go_in_plus = "<CR>",
		-- 		go_out = "h",
		-- 		go_out_plus = "H",
		-- 		mark_goto = "'",
		-- 		mark_set = "m",
		-- 		reset = "<BS>",
		-- 		reveal_cwd = "@",
		-- 		show_help = "g?",
		-- 		synchronize = "<Esc>",
		-- 		trim_left = "<",
		-- 		trim_right = ">",
		-- 	},
		-- })
		require("mini.statusline").setup()
		require("mini.notify").setup()

		-- simplifiers
		require("mini.snippets").setup()
		require("mini.surround").setup()
		require("mini.ai").setup()
		require("mini.pairs").setup()
		require("mini.move").setup({
			mappings = {
				left = "<C-M-h>",
				right = "<C-M-l>",
				down = "<C-M-j>",
				up = "<C-M-k>",

				line_left = "<C-M-h>",
				line_right = "<C-M-l>",
				line_down = "<C-M-j>",
				line_up = "<C-M-k>",
			},

			options = {
				reindent_linewise = true,
			},
		})
	end,
}
