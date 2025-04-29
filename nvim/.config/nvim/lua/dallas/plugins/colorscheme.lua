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
		vim.cmd("colorscheme rose-pine")
	end,
}
