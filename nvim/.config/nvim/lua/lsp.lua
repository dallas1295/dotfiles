-- First enable the LSPs
vim.lsp.enable({
	"clangd",
	"gopls",
	"lua_ls",
	"ols",
	"marksman",
	"ts_ls",
	"rust-analyzer",
	"pyright",
})

-- Diagnostic config: squiggles + signs only, no inline text
vim.diagnostic.config({
	virtual_text = false,
	virtual_lines = false,
	underline = true,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "󰅚 ",
			[vim.diagnostic.severity.WARN] = "󰀪 ",
			[vim.diagnostic.severity.INFO] = "󰋽 ",
			[vim.diagnostic.severity.HINT] = "󰌶 ",
		},
		numhl = {
			[vim.diagnostic.severity.ERROR] = "ErrorMsg",
			[vim.diagnostic.severity.WARN] = "WarningMsg",
		},
	},
	update_in_insert = false,
	severity_sort = true,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = {
		"typescript",
		"typescriptreact",
		"typescript.tsx",
		"javascript",
		"javascriptreact",
		"javascript.jsx",
	},
	callback = function(args)
		local buf = args.buf
		local bufname = vim.api.nvim_buf_get_name(buf)

		-- Check for Deno
		local deno_root = vim.fs.find({ "deno.json", "deno.jsonc" }, { upward = true, path = bufname })[1]
		if deno_root then
			vim.lsp.enable("denols", { bufnr = buf })
			return
		end

		-- Check for Node/TS
		local node_root =
			vim.fs.find({ "package.json", "tsconfig.json", "jsconfig.json" }, { upward = true, path = bufname })[1]
		if node_root then
			vim.lsp.enable("ts_ls", { bufnr = buf })
			return
		end
	end,
})
