return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lint = require("lint")
		local json = vim.json

		lint.linters = {
			deno_lint = {
				cmd = "deno",
				args = { "lint", "--json", "-" },
				stream = "stdout",
				on_chunk = function(chunk)
					return {} -- Minimal parser
				end,
				source_name = "deno_lint",
				separate_stderr = false,
			},
		}

		lint.linters_by_ft = {
			javascript = { "deno_lint" },
			typescript = { "deno_lint" },
			javascriptreact = { "deno_lint" },
			typescriptreact = { "deno_lint" },
			go = { "gopls" },
		}

		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = lint_augroup,
			callback = function()
				lint.try_lint()
			end,
		})
	end,
}
