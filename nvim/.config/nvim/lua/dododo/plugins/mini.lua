return {
	"echasnovski/mini.nvim",
	version = false,
	config = function()
		--help stuff
		require("mini.ai").setup()
		require("mini.surround").setup()
		require("mini.pairs").setup()
		require("mini.diff").setup()
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
		require("mini.indentscope").setup()
		-- extra cool stuff
		require("mini.git").setup()
		require("mini.notify").setup()
	end,
}
