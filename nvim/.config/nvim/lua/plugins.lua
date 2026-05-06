local add = function(s)
	vim.pack.add(s, { confirm = false })
end

-- Themes
add({
	{ src = "https://github.com/rebelot/kanagawa.nvim", name = "kanagawa" },
})

-- Default options:
require("kanagawa").setup({
	compile = false, -- enable compiling the colorscheme
	undercurl = true, -- enable undercurls
	commentStyle = { italic = true },
	functionStyle = {},
	keywordStyle = { italic = true },
	statementStyle = { bold = true },
	typeStyle = {},
	transparent = true, -- do not set background color
	dimInactive = true, -- dim inactive window `:h hl-NormalNC`
	terminalColors = true, -- define vim.g.terminal_color_{0,17}
	colors = { -- add/modify theme and palette colors
		palette = {},
		theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
	},
	theme = "dragon", -- Load "wave" theme
	background = { -- map the value of 'background' option to a theme
		dark = "dragon", -- try "dragon" !
		light = "dragon",
	},
})

-- setup must be called before loading
vim.cmd("colorscheme kanagawa-dragon")

-- Mini
add({
	{ src = "https://github.com/nvim-mini/mini.nvim", name = "mini.nvim" },
})
require("mini.snippets").setup()
require("mini.surround").setup()
require("mini.pairs").setup()
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
	},
	files = {
		file_ignore_patterns = {
			"^.git/",
			"^.vscode/",
			"^.svelte-kit/",
			"^node_modules/",
			"^.next/",
			"^dist/",
			"^build/",
			"^.DS_Store",
			"^target/",
		},
		fd_opts = [[--color=never --type f --type l --hidden --exclude .git --exclude .vscode --exclude .svelte-kit --exclude node_modules --exclude .next --exclude dist --exclude build --exclude target]],
		rg_opts = [[--color=never --files --hidden --glob '!.git' --glob '!.vscode' --glob '!.svelte-kit' --glob '!node_modules' --glob '!.next' --glob '!dist' --glob '!build' --glob '!target/**']],
	},
	grep = {
		rg_opts = [[--color=never --hidden --glob '!.git' --glob '!.vscode' --glob '!.svelte-kit' --glob '!node_modules' --glob '!.next' --glob '!dist' --glob '!build' --glob '!target/**' -e]],
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
	},
	format_on_save = {
		lsp_fallback = true,
		async = false,
		timeout_ms = 1000,
	},
})
vim.keymap.set({ "n", "v" }, "<leader>mp", function()
	conform.format({
		lsp_fallback = false,
		async = false,
		timeout_ms = 1000,
	})
end, { desc = "Format file" })

-- Completions
add({
	{ src = "https://github.com/saghen/blink.cmp", name = "blink", version = vim.version.range("1.*") },
})

require("blink.cmp").setup({
	snippets = { preset = "mini_snippets" },
	keymap = {
		preset = "super-tab",
	},
	appearance = {
		nerd_font_variant = "mono",
	},
	completion = { documentation = { auto_show = true } },
	sources = {
		default = {
			"lsp",
			"path",
			"snippets",
			"buffer",
		},
	},
	fuzzy = { implementation = "lua" },
})

-- Bento
add({
	{ src = "https://github.com/serhez/bento.nvim", name = "bento" },
})

require("bento").setup({
	ui = {
		mode = "floating", -- "floating" | "tabline"
		floating = {
			position = "middle-right", -- See position options below
			offset_x = 0, -- Horizontal offset from position
			offset_y = 0, -- Vertical offset from position
			dash_char = "─", -- Character for collapsed dashes
			border = nil, -- "rounded" | "single" | "double" | etc. (see :h winborder)
			label_padding = 1, -- Padding around labels
			minimal_menu = "dashed", -- nil | "dashed" | "filename" | "full"
			max_rendered_buffers = nil, -- nil (no limit) or number for pagination
		},
		tabline = {
			left_page_symbol = "❮", -- Symbol shown when previous buffers exist
			right_page_symbol = "❯", -- Symbol shown when more buffers exist
			separator_symbol = "│", -- Separator between buffer components
		},
	},
})
