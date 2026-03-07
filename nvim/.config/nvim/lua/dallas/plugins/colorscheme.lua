return {
	"vague-theme/vague.nvim",
	lazy = false, -- make sure we load this during startup if it is your main colorscheme
	priority = 1000, -- make sure to load this before all the other plugins
	config = function()
		-- NOTE: you do not need to call setup if you don't want to.
		require("vague").setup({
			-- optional configuration here
		})
		vim.cmd("colorscheme vague")

		-- vim.api.nvim_set_hl(0, "Normal", { bg = "#000000" })
		-- vim.api.nvim_set_hl(0, "NormalNC", { bg = "#000000" })
	end,
}

-- return {
-- 	"ellisonleao/gruvbox.nvim",
-- 	priority = 1000,
-- 	opts = {
-- 		terminal_colors = true, -- add neovim terminal colors
-- 		undercurl = true,
-- 		underline = true,
-- 		bold = true,
-- 		italic = {
-- 			strings = true,
-- 			emphasis = true,
-- 			comments = true,
-- 			operators = false,
-- 			folds = true,
-- 		},
-- 		strikethrough = true,
-- 		invert_selection = false,
-- 		invert_signs = false,
-- 		invert_tabline = false,
-- 		inverse = true, -- invert background for search, diffs, statuslines and errors
-- 		contrast = "hard", -- can be "hard", "soft" or empty string
-- 		palette_overrides = {},
-- 		overrides = {},
-- 		dim_inactive = false,
-- 		transparent_mode = true,
-- 	},
-- 	config = function(_, opts)
-- 		require("gruvbox").setup(opts)
-- 		vim.cmd("colorscheme gruvbox")
-- 	end,
-- }
