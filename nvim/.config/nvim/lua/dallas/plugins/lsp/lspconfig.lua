return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "folke/neodev.nvim", opts = {} },
	},
	config = function()
		-- import lspconfig plugin
		local lspconfig = require("lspconfig")

		-- import mason_lspconfig plugin
		local mason_lspconfig = require("mason-lspconfig")
		local capabilities = vim.lsp.protocol.make_client_capabilities()

		local keymap = vim.keymap -- for conciseness

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				-- Buffer local mappings.
				-- See `:help vim.lsp.*` for documentation on any of the below functions
				local opts = { buffer = ev.buf, silent = true }

				opts.desc = "Restart LSP"
				keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
			end,
		})

		-- Change the Diagnostic symbols in the sign column (gutter)
		-- (not in youtube nvim video)
		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		vim.diagnostic.config({
			signs = {
				text = signs,
				numhl = "",
				texthl = "",
			},
			virtual_text = {
				prefix = "●", -- Could be '■', '▎', 'x'
				spacing = 4,
				source = "if_many",
				severity = {
					min = vim.diagnostic.severity.INFO,
				},
			},
			float = {
				source = "always",
				border = "rounded",
			},
			severity_sort = true,
			update_in_insert = false,
		})

		-- Dynamically set up all installed LSP servers with default capabilities
		local installed_servers = mason_lspconfig.get_installed_servers()
		for _, server_name in ipairs(installed_servers) do
			if lspconfig[server_name] then
				lspconfig[server_name].setup({
					capabilities = capabilities,
					-- Add any default configuration options here if needed
				})
			end
		end

		-- Now, configure specific LSP servers with custom settings
		lspconfig["denols"].setup({
			capabilities = capabilities,
			filetypes = { "typescriptreact", "javascriptreact", "javascript", "typescript" },
			root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
			settings = {
				deno = {
					enable = true,
					enablePaths = true,
					lint = true,
				},
			},
		})

		lspconfig["ts_ls"].setup({
			capabilities = capabilities,
			filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
			root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", "jsconfig.json"),
			on_attach = function(client, bufnr)
				if vim.lsp.get_clients({ bufnr = bufnr, name = "denols" })[1] then
					client:stop()
					return
				end
			end,
		})

		lspconfig["lua_ls"].setup({
			capabilities = capabilities,
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
					completion = {
						callSnippet = "Replace",
					},
				},
			},
		})

		lspconfig["tailwindcss"].setup({
			capabilities = capabilities,
			filetypes = {
				"html",
				"css",
				"javascriptreact",
				"typescriptreact",
			},
		})

		lspconfig["gopls"].setup({
			cmd = { "gopls" },
			filetypes = { "go", "gomod", "gowork", "gotmpl" },
			settings = {
				gopls = {
					analyses = {
						unusedparams = true,
						shadow = true,
						undeclarednames = true,
					},
					staticcheck = true,
					usePlaceholders = true,
				},
			},
		})
	end,
}
