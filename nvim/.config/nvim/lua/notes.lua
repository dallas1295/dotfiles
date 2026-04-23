local add = function(s)
	vim.pack.add(s, { confirm = false })
end

add({
	{ src = "https://github.com/epwalsh/obsidian.nvim", name = "obsidian" },
	{ src = "https://github.com/nvim-lua/plenary.nvim", name = "plenary" },
})

require("obsidian").setup({
	workspaces = {
		{
			name = "stuff",
			path = "~/vaults/stuff/",
		},
		{
			name = "journal",
			path = "~/vaults/journal",
		},
	},

	mappings = {
		-- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
		["gf"] = {
			action = function()
				return require("obsidian").util.gf_passthrough()
			end,
			opts = { noremap = false, expr = true, buffer = true },
		},
		-- Toggle check-boxes.
		["<leader>ch"] = {
			action = function()
				return require("obsidian").util.toggle_checkbox()
			end,
			opts = { buffer = true },
		},
		-- Smart action depending on context, either follow link or toggle checkbox.
		["<cr>"] = {
			action = function()
				return require("obsidian").util.smart_action()
			end,
			opts = { buffer = true, expr = true },
		},
	},
})

-- Render Markdown (for notes)
add({
	"https://github.com/MeanderingProgrammer/render-markdown.nvim",
})
require("render-markdown").setup({}) -- only mandatory if you want to set custom options
