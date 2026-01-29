return {
	"nvim-mini/mini.nvim",
	version = false,
	config = function()
		require("mini.ai").setup()
		require("mini.files").setup({
			mappings = {
				close = "q",
				go_in = "l",
				go_in_plus = "L",
				go_out = "h",
				go_out_plus = "H",
				mark_goto = "'",
				mark_set = "m",
				reset = "<BS>",
				reveal_cwd = "@",
				show_help = "g?",
				synchronize = "<CR>",
				trim_left = "<",
				trim_right = ">",
			},
		})
		require("mini.snippets").setup()
		require("mini.surround").setup()
		require("mini.pairs").setup()
		-- require("mini.tabline").setup()
		require("mini.icons").setup()
		require("mini.notify").setup()
		require("mini.trailspace").setup()
		require("mini.indentscope").setup()
		require("mini.diff").setup({
			style = "number",
		})
		require("mini.comment").setup()
		require("mini.statusline").setup()
		require("mini.pick").setup()
		require("mini.extra").setup()
		require("mini.move").setup( -- No need to copy this inside `setup()`. Will be used automatically.
			{
				mappings = {
					left = "<M-C-h>",
					right = "<M-C-l>",
					down = "<M-C-j>",
					up = "<M-C-k>",
					-- Move current line in Normal mode
					line_left = "<M-C-h>",
					line_right = "<M-C-l>",
					line_down = "<M-C-j>",
					line_up = "<M-C-k>",
				},

				-- Options which control moving behavior
				options = {
					-- Automatically reindent selection during linewise vertical move
					reindent_linewise = true,
				},
			}
		)
		local hipatterns = require("mini.hipatterns")
		hipatterns.setup({
			highlighters = {
				-- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
				fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
				hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
				todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
				note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },

				-- Highlight hex color strings (`#rrggbb`) using that color
				hex_color = hipatterns.gen_highlighter.hex_color(),
			},
		})
	end,
}
