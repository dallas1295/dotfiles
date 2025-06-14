return {
	"echasnovski/mini.nvim",
	version = false,
	config = function()
		--appearance
		require("mini.animate").setup({
			-- Window resize
			resize = {
				enable = false,
			},
			-- Window close
			close = {
				enable = false,
			},
		})
		require("mini.notify").setup()
		local hi = require("mini.hipatterns")
		hi.setup({
			highlighters = {
				-- Highlighting for comments
				fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
				hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
				todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
				note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },

				-- Hexcode highlighting
				hex_color = hi.gen_highlighter.hex_color({ priority = 2000 }),
				shorthand = {
					pattern = "()#%x%x%x()%f[^%x%w]",
					group = function(_, _, data)
						local match = data.full_match
						local r, g, b = match:sub(2, 2), match:sub(3, 3), match:sub(4, 4)
						local hex_color = "#" .. r .. r .. g .. g .. b .. b

						return MiniHipatterns.compute_hex_color_group(hex_color, "bg")
					end,
					extmark_opts = { priority = 2000 },
				},
			},
		})
		require("mini.statusline").setup()
		require("mini.indentscope").setup()
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
				synchronize = "<Esc>",
				trim_left = "<",
				trim_right = ">",
			},
		})
		require("mini.icons").setup()

		-- simplifiers
		require("mini.snippets").setup()
		require("mini.surround").setup()
		require("mini.ai").setup()
		require("mini.pairs").setup()
		require("mini.comment").setup()
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
