return {
	"rcarriga/nvim-notify",
	config = function()
		require("notify").setup({
			max_width = 60,
			timeout = 2000,
		})
		vim.notify = require("notify")
		vim.keymap.set("n", "<leader>nd", function()
			require("notify").dismiss({ silent = true, pending = true })
		end, { desc = "Dismiss all notifications" })
	end,
}
