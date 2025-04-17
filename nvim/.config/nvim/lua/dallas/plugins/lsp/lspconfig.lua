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

		-- used to enable autocompletion (assign to every lsp server config)

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

		mason_lspconfig.setup_handlers({
			-- default handler for installed servers
			function(server_name)
				lspconfig[server_name].setup({
					capabilities = capabilities,
				})
			end,
			["denols"] = function()
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
			end,
			["ts_ls"] = function()
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
			end,
			["lua_ls"] = function()
				-- configure lua server (with special settings)
				lspconfig["lua_ls"].setup({
					capabilities = capabilities,
					settings = {
						Lua = {
							-- make the language server recognize "vim" global
							diagnostics = {
								globals = { "vim" },
							},
							completion = {
								callSnippet = "Replace",
							},
						},
					},
				})
			end,
			["tailwindcss"] = function()
				lspconfig["tailwindcss"].setup({
					capabilities = capabilities,
					filetypes = {
						"html",
						"css",
						"javascriptreact",
						"typescriptreact",
					},
				})
			end,
			["gopls"] = function()
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
		})
	end,
}
