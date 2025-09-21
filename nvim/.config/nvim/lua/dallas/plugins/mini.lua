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
		require("mini.pairs").setup()
		require("mini.snippets").setup()
		require("mini.surround").setup()
		require("mini.diff").setup({
			view = {
				style = "number",
			},
		})
	end,
}
