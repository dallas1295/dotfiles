local add = function(s)
	vim.pack.add(s, { confirm = false })
end

-- -- Themes
-- add({ { src = "https://github.com/miikanissi/modus-themes.nvim", name = "modus-themes" },
-- })
-- -- Default options
-- require("modus-themes").setup({
-- 	-- Theme comes in two styles `modus_operandi` and `modus_vivendi`
-- 	-- `auto` will automatically set style based on background set with vim.o.background
-- 	style = "modus_vivendi",
--
-- 	-- Theme comes in four variants `default`, `tinted`, `deuteranopia`, and `tritanopia`
-- 	variants = {
-- 		modus_operandi = "default", -- Set variant for `modus_operandi` style
-- 		modus_vivendi = "tinted", -- Set variant for `modus_vivendi` style
-- 	},
-- 	transparent = true, -- Transparent background (as supported by the terminal)
-- 	dim_inactive = true, -- "non-current" windows are dimmed
-- 	hide_inactive_statusline = false, -- Hide statuslines on inactive windows. Works with the standard **StatusLine**, **LuaLine** and **mini.statusline**
-- 	line_nr_column_background = true, -- Distinct background colors in line number column. `false` will disable background color and fallback to Normal background
-- 	sign_column_background = true, -- Distinct background colors in sign column. `false` will disable background color and fallback to Normal background
-- 	styles = {
-- 		-- Style to be applied to different syntax groups
-- 		-- Value is any valid attr-list value for `:help nvim_set_hl`
-- 		comments = { italic = true },
-- 		keywords = { italic = true },
-- 		functions = {},
-- 		variables = {},
-- 	},
-- })
--
-- vim.cmd("colorscheme modus")

add({
	{ src = "https://github.com/blazkowolf/gruber-darker.nvim" },
})

vim.cmd("colorscheme gruber-darker")

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
require("mini.statusline").setup()
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
