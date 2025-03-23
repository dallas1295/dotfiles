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
		require("mini.icons").setup()
		require("mini.statusline").setup()
		require("mini.tabline").setup()
		require("mini.trailspace").setup()
		require("mini.operators").setup()
		require("mini.clue").setup({
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
			window = {
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
		require("mini.snippets").setup({
			mappings = {
				expand = "C-p",
			},
		})
		require("mini.completion").setup({
			mappings = {
				-- Force two-step/fallback completions
				force_twostep = "<C-Space>",
				force_fallback = "<A-Space>",

				-- Scroll info/signature window down/up. When overriding, check for
				-- conflicts with built-in keys for popup menu (like `<C-u>`/`<C-o>`
				-- for 'completefunc'/'omnifunc' source function; or `<C-n>`/`<C-p>`).
				scroll_down = "<C-f>",
				scroll_up = "<C-b>",
			},
		})
	end,
}
