local add = function(s)
	vim.pack.add(s, { confirm = false })
end

-- Theme
add({
	{ src = "https://github.com/vague-theme/vague.nvim", name = "vague" },
})
require("vague").setup({})
vim.cmd("colorscheme vague")

-- Mini (QoL)
add({
	{ src = "https://github.com/nvim-mini/mini.nvim", name = "mini.nvim" },
})
require("mini.pick").setup()
require("mini.ai").setup()
require("mini.snippets").setup()
require("mini.surround").setup()
require("mini.pairs").setup()
require("mini.tabline").setup()
require("mini.statusline").setup()
require("mini.icons").setup()
require("mini.trailspace").setup()
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

-- Neotree
add({
	{ src = "https://github.com/nvim-neo-tree/neo-tree.nvim", version = vim.version.range("3") },
	"https://github.com/MunifTanjim/nui.nvim",
})
	require("neo-tree").setup({
	event_handlers = {
		{
			event = "file_opened",
			handler = function()
				require("neo-tree").close_all()
			end,
		},
	},
	close_if_last_window = false,
	popup_border_style = "rounded",
	enable_git_status = true,
	enable_diagnostics = true,
	open_files_do_not_replace_types = { "terminal", "trouble", "qf" },
	sort_case_insensitive = false,
	default_component_configs = {
		container = {
			enable_character_fade = true,
		},
		indent = {
			indent_size = 2,
			padding = 1,
			with_markers = true,
			indent_marker = "│",
			last_indent_marker = "└",
			highlight = "NeoTreeIndentMarker",
			with_expanders = nil,
			expander_highlight = "NeoTreeExpander",
		},
		icon = {
			folder_closed = "",
			folder_open = "",
			folder_empty = "󰜌",
			default = "*",
		},
		modified = {
			symbol = "[+]",
			highlight = "NeoTreeModified",
		},
		name = {
			trailing_slash = false,
			use_git_status_colors = true,
		},
		git_status = {
			symbols = {
				added = "",
				modified = "",
				deleted = "✖",
				renamed = "󰁕",
				untracked = "★",
				ignored = "◌",
			},
		},
	},
	window = {
		position = "left",
		width = 40,
		mapping_options = {
			noremap = true,
			nowait = true,
		},
		mappings = {
			["<space>"] = {
				"toggle_node",
				nowait = false,
			},
			["<2-LeftMouse>"] = "open",
			["<cr>"] = "open",
			["<esc>"] = "revert_preview",
			["P"] = { "toggle_preview", config = { use_float = true } },
			["l"] = "focus_preview",
			["S"] = "open_split",
			["s"] = "open_vsplit",
			["t"] = "open_tabnew",
			["w"] = "open_with_window_picker",
			["C"] = "close_node",
			["z"] = "close_all_nodes",
			["a"] = {
				"add",
				config = {
					show_path = "none",
				},
			},
			["A"] = "add_directory",
			["d"] = "delete",
			["r"] = "rename",
			["y"] = "copy_to_clipboard",
			["x"] = "cut_to_clipboard",
			["p"] = "paste_from_clipboard",
			["c"] = "copy",
			["m"] = "move",
			["q"] = "close_window",
		},
	},
	nesting_rules = {},
	filesystem = {
		filtered_items = {
			visible = false,
			hide_dotfiles = false,
			hide_gitignored = false,
			hide_hidden = false,
			hide_by_name = {
				".git",
				".vscode",
				".svelte-kit",
				"node_modules",
				".next",
				"dist",
				"build",
				"target",
				".DS_Store",
			},
			never_show = {},
		},
		follow_current_file = {
			enabled = false,
			leave_dirs_open = false,
		},
		group_empty_dirs = false,
		async_directory_scan = "auto",
		scan_mode = "shallow",
		use_libuv_file_watcher = false,
	},
	buffers = {
		follow_current_file = {
			enabled = true,
			leave_dirs_open = false,
		},
		group_empty_dirs = true,
		show_unloaded = true,
		window = {
			mappings = {
				["bd"] = "buffer_delete",
				["<bs>"] = "navigate_up",
				["."] = "set_root",
				["o"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "o" } },
				["oc"] = { "order_by_created", nowait = false },
				["od"] = { "order_by_diagnostics", nowait = false },
				["og"] = { "order_by_git_status", nowait = false },
				["om"] = { "order_by_modified", nowait = false },
				["on"] = { "order_by_name", nowait = false },
				["os"] = { "order_by_size", nowait = false },
				["ot"] = { "order_by_type", nowait = false },
			},
		},
	},
	git_status = {
		window = {
			position = "float",
			mappings = {
				["A"] = "git_add_all",
				["gu"] = "git_unstage_file",
				["ga"] = "git_add_file",
				["gr"] = "git_revert_file",
				["gc"] = "git_commit",
				["gp"] = "git_push",
				["gg"] = "git_commit_and_push",
			},
		},
	},
})

-- Render Markdown (for notes)
add({
	"https://github.com/MeanderingProgrammer/render-markdown.nvim",
})
require("render-markdown").setup({}) -- only mandatory if you want to set custom options

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

-- Autotag
add({
	{ src = "https://github.com/windwp/nvim-ts-autotag", name = "nvim-ts-autotag" },
})
require("nvim-ts-autotag").setup()

-- Completions and Formatters
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

add({
	{ src = "https://github.com/saghen/blink.cmp", name = "blink", version = vim.version.range("1") },
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
	fuzzy = { implementation = "prefer_rust_with_warning" },
})
