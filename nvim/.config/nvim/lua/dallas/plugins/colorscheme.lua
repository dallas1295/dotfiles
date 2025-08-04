return {
	"rebelot/kanagawa.nvim",
	name = "kanagawa",
	config = function()
		require("kanagawa").setup({
			compile = false, -- enable compiling the colorscheme
			undercurl = true, -- enable undercurls
			commentStyle = { italic = true },
			functionStyle = {},
			keywordStyle = { italic = true },
			statementStyle = { bold = true },
			typeStyle = {},
			transparent = false, -- do not set background color
			dimInactive = false, -- dim inactive window `:h hl-NormalNC`
			terminalColors = true, -- define vim.g.terminal_color_{0,17}
			theme = "dragon",
			overrides = function()
				return {
					NormalFloat = { bg = "#1F1F28" },
					FloatBorder = { bg = "#1F1F28" },
					TelescopeNormal = { bg = "#1F1F28" },
					TelescopeBorder = { bg = "#1F1F28" },
				}
			end,
		})
		vim.cmd("colorscheme kanagawa-dragon")
	end,
}
