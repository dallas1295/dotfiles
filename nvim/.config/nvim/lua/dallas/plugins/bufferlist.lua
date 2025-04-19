return {
	"EL-MASTOR/bufferlist.nvim",
	lazy = true,
	keys = { { "<Leader>b", ":BufferList<CR>", desc = "Open bufferlist" } },
	dependencies = "nvim-tree/nvim-web-devicons",
	cmd = "BufferList",
	opts = {
		win_keymaps = {
			{
				"<cr>",
				function(opts)
					local curpos = vim.fn.line(".")
					vim.cmd("bwipeout | buffer " .. opts.buffers[curpos])
				end,
				{ desc = "Open Buffer" },
			},
		},
		bufs_keymaps = {
			{
				"v",
				function(opts)
					vim.cmd("bwipeout | vs " .. vim.fn.bufname(opts.buffers[opts.line_number]))
				end,
				{ desc = "Open Buffer in split" },
			},
		},
	},
}
