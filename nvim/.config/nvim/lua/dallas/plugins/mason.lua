return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim", -- Add this line
	},
	config = function()
		-- import mason
		local mason = require("mason")

		-- import mason-lspconfig
		local mason_lspconfig = require("mason-lspconfig")

		-- import mason-tool-installer
		local mason_tool_installer = require("mason-tool-installer")

		-- enable mason and configure icons
		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		mason_lspconfig.setup({
			-- list of servers for mason to install
			ensure_installed = {
				"ts_ls",
				"denols",
				"tailwindcss",
				"lua_ls",
				"gopls",
			},
		})

		mason_tool_installer.setup({
			ensure_installed = {
				"goimports",
				"gofumpt",
				"prettier",
			},
			auto_update = true,
			run_on_start = true,
			debounce_hours = 5, -- at least 5 hours between attempts to install/update
		})
	end,
}
