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
		require("mini.move").setup({
			mappings = {
				-- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
				left = "<M-S-h>",
				right = "<M-S-l>",
				down = "<M-S-j>",
				up = "<M-S-k>",

				-- Move current line in Normal mode
				line_left = "<M-S-h>",
				line_right = "<M-S-l>",
				line_down = "<M-S-j>",
				line_up = "<M-S-k>",
			},

			-- Options which control moving behavior
			options = {
				-- Automatically reindent selection during linewise vertical move
				reindent_linewise = true,
			},
		})
		require("mini.git").setup()
		require("mini.notify").setup()
	end,
}
