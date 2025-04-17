return {
	"folke/trouble.nvim",
	dependencies = { "ibhagwan/fzf-lua" },
	opts = {}, -- for default options, refer to the configuration section for custom setup
	config = function()
		require("trouble").setup({}) -- Make sure Trouble is set up first

		-- Your fzf-lua integration code goes here
		local config = require("fzf-lua.config")
		local actions = require("trouble.sources.fzf").actions
		config.defaults.actions.files["ctrl-t"] = actions.open
	end,
	cmd = "Trouble",
	keys = {
		{
			"<leader>dt",
			"<cmd>Trouble diagnostics toggle<cr>",
			desc = "Diagnostics (Trouble)",
		},
		{
			"<leader>db",
			"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
			desc = "Buffer Diagnostics (Trouble)",
		},
		{
			"<leader>ts",
			"<cmd>Trouble symbols toggle focus=false<cr>",
			desc = "Symbols (Trouble)",
		},
		{
			"<leader>dl",
			"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
			desc = "LSP Definitions / references / ... (Trouble)",
		},
		{
			"<leader>dw",
			"<cmd>Trouble loclist toggle<cr>",
			desc = "Location List (Trouble)",
		},
		{
			"<leader>dq",
			"<cmd>Trouble qflist toggle<cr>",
			desc = "Quickfix List (Trouble)",
		},
	},
}
