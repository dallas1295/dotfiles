return {
	"nvim-mini/mini.nvim",
	version = false,
	config = function()
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
		require("mini.ai").setup()
		require("mini.surround").setup()
		require("mini.pairs").setup()
		require("mini.tabline").setup()
		require("mini.icons").setup()
		require("mini.notify").setup()
		require("mini.trailspace").setup()
		require("mini.indentscope").setup()
		require("mini.cursorword").setup()
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
		require("mini.diff").setup({
			style = "number",
		})
		require("mini.bracketed").setup()
		require("mini.comment").setup()
		require("mini.align").setup()
		require("mini.statusline").setup()
	end,
}
