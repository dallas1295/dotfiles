return {
	"echasnovski/mini.nvim",
	version = false,
	config = function()
		--appearance
		require("mini.notify").setup()
		require("mini.animate").setup()
		require("mini.icons").setup()
		require("mini.statusline").setup()
		require("mini.tabline").setup()
		require("mini.indentscope").setup()
		require("mini.git").setup()
		require("mini.diff").setup()
		local miniclue = require("mini.clue")
		miniclue.setup({
			triggers = {
				-- Leader triggers
				{ mode = "n", keys = "<Leader>" },
				{ mode = "x", keys = "<Leader>" },

				-- Built-in completion
				{ mode = "i", keys = "<C-x>" },

				-- `g` key
				{ mode = "n", keys = "g" },
				{ mode = "x", keys = "g" },

				-- Marks
				{ mode = "n", keys = "'" },
				{ mode = "n", keys = "`" },
				{ mode = "x", keys = "'" },
				{ mode = "x", keys = "`" },

				-- Registers
				{ mode = "n", keys = '"' },
				{ mode = "x", keys = '"' },
				{ mode = "i", keys = "<C-r>" },
				{ mode = "c", keys = "<C-r>" },

				-- Window commands
				{ mode = "n", keys = "<C-w>" },

				-- `z` key
				{ mode = "n", keys = "z" },
				{ mode = "x", keys = "z" },
			},

			clues = {
				-- Enhance this by adding descriptions for <Leader> mapping groups
				miniclue.gen_clues.builtin_completion(),
				miniclue.gen_clues.g(),
				miniclue.gen_clues.marks(),
				miniclue.gen_clues.registers(),
				miniclue.gen_clues.windows(),
				miniclue.gen_clues.z(),
			},
			window = {
				config = {},
				delay = 10,
			},
		})
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

		-- simplifiers
		require("mini.snippets").setup()
		require("mini.surround").setup()
		require("mini.pairs").setup()
		require("mini.ai").setup()
		require("mini.comment").setup()
		require("mini.trailspace").setup()
		require("mini.operators").setup()
		require("mini.cursorword").setup()
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
	end,
}
