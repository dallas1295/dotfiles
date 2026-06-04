vim.pack.add({
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", name = "nvim-treesitter" },
})

vim.opt.runtimepath:append(vim.fn.stdpath("data") .. "/site/pack/core/opt/nvim-treesitter/runtime")

local languages = {
	"elixir",
	"heex",
	"eex",
	"go",
	"json",
	"javascript",
	"typescript",
	"tsx",
	"yaml",
	"html",
	"css",
	"markdown",
	"markdown_inline",
	"graphql",
	"bash",
	"lua",
	"dockerfile",
	"gitignore",
	"query",
	"vimdoc",
	"cpp",
	"rust",
	"zig",
	"sql",
	"svelte",
}

require("nvim-treesitter.config").setup()

local installed = require("nvim-treesitter.config").get_installed()
local missing = vim.tbl_filter(function(l)
	return not vim.list_contains(installed, l)
end, languages)
if #missing > 0 then
	require("nvim-treesitter.install").install(missing, { summary = true })
end

vim.api.nvim_create_autocmd("FileType", {
	callback = function()
		pcall(vim.treesitter.start)
	end,
})
