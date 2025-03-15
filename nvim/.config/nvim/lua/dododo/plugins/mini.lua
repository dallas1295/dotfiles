return {
	"echasnovski/mini.nvim",
	version = false,
	config = function()
		require("mini.deps").setup()
		require("mini.ai").setup()
		require("mini.surround").setup()
		require("mini.pairs").setup()
		require("mini.diff").setup()
		require("mini.git").setup()
		require("mini.notify").setup()
		require("mini.animate").setup()
	end,
}
