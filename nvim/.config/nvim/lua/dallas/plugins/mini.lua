return {
	"echasnovski/mini.nvim",
	version = false,
	config = function()
		--appearance
		require("mini.statusline").setup()
		local hipatterns = require("mini.hipatterns")
		hipatterns.setup({
			highlighters = {
				-- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
				fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
				hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
				todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
				note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },

				hex_color = hipatterns.gen_highlighter.hex_color(),
			},
		})

		-- simplifiers
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
		})
		require("mini.pairs").setup()
		require("mini.ai").setup()
		require("mini.snippets").setup()
		require("mini.surround").setup()
		require("mini.diff").setup({
			view = {
				style = "number",
			},
		})
	end,
}
