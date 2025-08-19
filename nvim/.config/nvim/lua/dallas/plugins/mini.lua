return {
	"echasnovski/mini.nvim",
	version = false,
	config = function()
		--appearance
		require("mini.statusline").setup()
		local hipatterns = require("mini.hipatterns")
		hipatterns.setup({
			highlighters = {
				hex_color = hipatterns.gen_highlighter.hex_color(),
			},
		})

		-- simplifiers
		require("mini.snippets").setup()
		require("mini.surround").setup()
		require("mini.diff").setup()
	end,
}
