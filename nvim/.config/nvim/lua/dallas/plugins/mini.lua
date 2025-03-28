return {
	"echasnovski/mini.nvim",
	version = false,
	config = function()
		require("mini.notify").setup()
		require("mini.git").setup()
		require("mini.ai").setup()
		require("mini.surround").setup()
		require("mini.indentscope").setup()
		require("mini.pairs").setup()
		require("mini.diff").setup()
		require("mini.comment").setup()
		require("mini.statusline").setup()
		require("mini.tabline").setup()
		require("mini.trailspace").setup()
		require("mini.operators").setup()
		require("mini.animate").setup()
		require("mini.files").setup({
			mappings = {
				close = "q",
				go_in = "l",
				go_in_plus = "<CR>",
				go_out = "h",
				go_out_plus = "H",
				mark_goto = "'",
				mark_set = "m",
				reset = "<BS>",
				reveal_cwd = "@",
				show_help = "g?",
				synchronize = "=",
				trim_left = "<",
				trim_right = ">",
			},
		})
		require("mini.move").setup({
			mappings = {
				left = "<M-S-h>",
				right = "<M-S-l>",
				down = "<M-S-j>",
				up = "<M-S-k>",

				line_left = "<M-S-h>",
				line_right = "<M-S-l>",
				line_down = "<M-S-j>",
				line_up = "<M-S-k>",
			},

			options = {
				reindent_linewise = true,
			},
		})
		-- mini.icons installed via dependency
		require("mini.icons").setup()
		require("mini.snippets").setup()
	end,
}
