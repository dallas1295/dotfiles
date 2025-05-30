return {
	"rose-pine/neovim",
	name = "rose-pine",
	config = function()
		require("rose-pine").setup({
			highlight_groups = {
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
