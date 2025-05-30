-- return {
-- 	"rebelot/kanagawa.nvim",
-- 	config = function()
-- 		require("kanagawa").setup({
-- 			undercurl = true,
-- 			commentStyle = { italic = true },
-- 			-- Add any other Kanagawa configuration options you want here
-- 		})
-- 		vim.cmd("colorscheme kanagawa-wave")
-- 	end,
-- }

return {
	"rose-pine/neovim",
	name = "rose-pine",
	config = function()
		require("rose-pine").setup({
			highlight_groups = {
				-- This will override the background for Normal and NormalNC
				Normal = { bg = "#000000" },
				NormalNC = { bg = "#000000" },
				SignColumn = { bg = "#000000" },
				EndOfBuffer = { bg = "#000000" },
				MsgArea = { bg = "#000000" },
			},
		})
		vim.cmd("colorscheme rose-pine")
	end,
}
