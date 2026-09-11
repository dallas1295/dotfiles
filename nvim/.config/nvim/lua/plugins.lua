local add = function(s)
	vim.pack.add(s, { confirm = false })
end

-- -- Themes
add({
	{ src = "https://github.com/blazkowolf/gruber-darker.nvim" },
})

vim.cmd.colorscheme("gruber-darker")

-- -- tmux
-- add({
-- 	{ src = "https://github.com/christoomey/vim-tmux-navigator" },
-- })
--
-- Better highlights
add({
	{ src = "https://github.com/kevinhwang91/nvim-hlslens" },
})
require("hlslens").setup()

-- Tab out of things
add({
	{ src = "https://github.com/abecodes/tabout.nvim" },
})
require("tabout").setup()

-- Mini
add({
	{ src = "https://github.com/nvim-mini/mini.nvim", name = "mini.nvim" },
})
require("mini.snippets").setup()
require("mini.completion").setup({})
require("mini.icons").setup()
require("mini.surround").setup()
require("mini.ai").setup()
require("mini.pairs").setup()
require("mini.tabline").setup()
require("mini.statusline").setup()
require("mini.statuscolumn").setup()
require("mini.diff").setup({
	style = "number",
})
require("mini.move").setup({
	mappings = {
		left = "<M-C-h>",
		right = "<M-C-l>",
		down = "<M-C-j>",
		up = "<M-C-k>",
		line_left = "<M-C-h>",
		line_right = "<M-C-l>",
		line_down = "<M-C-j>",
		line_up = "<M-C-k>",
	},
	options = {
		reindent_linewise = true,
	},
})
local hipatterns = require("mini.hipatterns")
hipatterns.setup({
	highlighters = {
		fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
		hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
		todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
		note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },
		hex_color = hipatterns.gen_highlighter.hex_color(),
	},
})

-- Oil
add({
	{ src = "https://github.com/stevearc/oil.nvim", name = "oil" },
})
require("oil").setup({
	default_file_explorer = true,
})

-- Fzf
add({
	{ src = "https://github.com/ibhagwan/fzf-lua", name = "fzf-lua" },
})
require("fzf-lua").setup({
	winopts = {
		split = "belowright new",
		preview = {
			hidden = true,
		},
	},
	keymap = {
		builtin = {
			["<C-g>"] = "toggle-preview",
		},
	},
	files = {
		file_ignore_patterns = {
			"%.git/",
			"%.vscode/",
			"%.svelte%-kit/",
			"node_modules/",
			"%.next/",
			"dist/",
			"build/",
			"%.DS_Store",
			"target/",
		},
		fd_opts = [[--color=never --type f --type l --hidden --exclude .git --exclude .vscode --exclude .svelte-kit --exclude node_modules --exclude .next --exclude dist --exclude build --exclude target]],
		rg_opts = [[--color=never --files --hidden --glob '!.git' --glob '!.vscode' --glob '!.svelte-kit' --glob '!node_modules' --glob '!.next' --glob '!dist' --glob '!build' --glob '!target/**']],
	},
	grep = {
		rg_opts = [[--hidden --line-number --column --glob '!.git' --glob '!.vscode' --glob '!.svelte-kit' --glob '!node_modules' --glob '!.next' --glob '!dist' --glob '!build' --glob '!target/**']],
	},
	buffers = {
		sort_lastused = true,
		file_icons = true,
		fzf_opts = {
			["--no-header"] = true,
			["--with-nth"] = "3..",
		},
	},
})

-- Render Markdown (for notes)
add({
	"https://github.com/MeanderingProgrammer/render-markdown.nvim",
})
require("render-markdown").setup({}) -- only mandatory if you want to set custom options

-- HTML Autotagging
add({
	{ src = "https://github.com/windwp/nvim-ts-autotag", name = "nvim-ts-autotag" },
})
require("nvim-ts-autotag").setup()

-- Formatter
add({
	{ src = "https://github.com/stevearc/conform.nvim", name = "conform" },
})
local conform = require("conform")
conform.setup({
	formatters_by_ft = {
		elixir = { "mix" },
		eex = { "mix" },
		heex = { "mix" },
		javascript = { "prettier" },
		typescript = { "prettier" },
		javascriptreact = { "prettier" },
		typescriptreact = { "prettier" },
		svelte = { "prettier" },
		css = { "prettier" },
		html = { "prettier" },
		json = { "prettier" },
		yaml = { "prettier" },
		markdown = { "prettier" },
		lua = { "stylua" },
		go = { "goimports", "gofumpt" },
		rust = { "rustfmt" },
		c = { "clang-format" },
		cpp = { "clang-format" },
		zig = { "zigfmt" },
		odin = { "odinfmt" },
	},
	formatters = {
		odinfmt = {
			command = "odinfmt",
			args = { "-stdin" },
			stdin = true,
		},
	},
	format_on_save = {
		lsp_fallback = true,
		async = false,
		timeout_ms = 1000,
	},
})
vim.keymap.set({ "n", "v" }, "<leader>cf", function()
	conform.format({
		lsp_fallback = false,
		async = false,
		timeout_ms = 1000,
	})
end, { desc = "Format file" })
