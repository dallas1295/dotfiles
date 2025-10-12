return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local colors = {
			bg = "#1d2021",
			fg = "#ebdbb2",
			yellow = "#d79921",
			cyan = "#689d6a",
			darkblue = "#458588",
			green = "#98971a",
			orange = "#d65d0e",
			violet = "#b16286",
			magenta = "#d3869b",
			blue = "#458588",
			red = "#cc241d",
			tan = "#d4be98",
		}

		local conditions = {
			buffer_not_empty = function()
				return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
			end,
			hide_in_width = function()
				return vim.fn.winwidth(0) > 80
			end,
			check_git_workspace = function()
				local filepath = vim.fn.expand("%:p:h")
				local gitdir = vim.fn.finddir(".git", filepath .. ";")
				return gitdir and #gitdir > 0
			end,
		}

		local config = {
			options = {
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				theme = {
					normal = { 
						a = { fg = colors.bg, bg = colors.blue, gui = "bold" },
						b = { fg = colors.fg, bg = colors.bg },
						c = { fg = colors.fg, bg = colors.bg }
					},
					inactive = { 
						a = { fg = colors.fg, bg = colors.bg },
						b = { fg = colors.fg, bg = colors.bg },
						c = { fg = colors.fg, bg = colors.bg }
					},
				},
				disabled_filetypes = { "alpha", "dashboard", "NvimTree", "Outline" },
			},
			sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_y = {},
				lualine_z = {},
				lualine_c = {},
				lualine_x = {},
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_y = {},
				lualine_z = {},
				lualine_c = {},
				lualine_x = {},
			},
		}

		local function ins_left(component)
			table.insert(config.sections.lualine_c, component)
		end

		local function ins_right(component)
			table.insert(config.sections.lualine_x, component)
		end

		local function ins_a(component)
			table.insert(config.sections.lualine_a, component)
		end

		ins_a({
			"mode",
			color = function()
				local mode_color = {
					n = colors.yellow,
					i = colors.green,
					v = colors.blue,
					[""] = colors.blue,
					V = colors.blue,
					c = colors.magenta,
					no = colors.red,
					s = colors.orange,
					S = colors.orange,
					[""] = colors.orange,
					ic = colors.yellow,
					R = colors.violet,
					Rv = colors.violet,
					cv = colors.red,
					ce = colors.red,
					r = colors.cyan,
					rm = colors.cyan,
					["r?"] = colors.cyan,
					["!"] = colors.red,
					t = colors.red,
				}
				return { fg = colors.bg, bg = mode_color[vim.fn.mode()], gui = "bold" }
			end,
			padding = { left = 1, right = 1 },
		})

		

		ins_left({
			"diff",
			symbols = { added = " ", modified = "", removed = " " },
			diff_color = {
				added = { fg = colors.green },
				modified = { fg = colors.orange },
				removed = { fg = colors.red },
			},
			cond = conditions.hide_in_width,
		})

		ins_left({
			function()
				return "%="
			end,
		})

		ins_left({
			"diagnostics",
			sources = { "nvim_diagnostic" },
			symbols = { error = " ", warn = " ", info = " " },
			diagnostics_color = {
				color_error = { fg = colors.red },
				color_warn = { fg = colors.yellow },
				color_info = { fg = colors.cyan },
			},
		})

		ins_left({
			function()
				local fname = vim.fn.expand("%:t")
				if fname == "" then
					return " [No Name] "
				end
				if vim.bo.modified then
					return fname .. " [+]"
				end
				return fname
			end,
			color = { fg = colors.magenta, gui = "bold" },
			cond = conditions.buffer_not_empty,
		})

		ins_right({
			"o:encoding",
			fmt = string.upper,
			cond = conditions.hide_in_width,
			color = { fg = colors.green, gui = "bold" },
		})

		ins_right({
			"fileformat",
			fmt = string.upper,
			icons_enabled = false,
			color = { fg = colors.green, gui = "bold" },
		})

		ins_right({
			"filetype",
			icons_enabled = true,
			color = { fg = colors.darkblue, gui = "bold" },
		})

		ins_right({
			"progress",
			color = { fg = colors.fg, gui = "bold" },
		})

		ins_right({
			"location",
			color = { fg = colors.fg, gui = "bold" },
		})

		ins_right({
			function()
				return "▊"
			end,
			color = { fg = colors.blue },
			padding = { left = 1 },
		})

		require("lualine").setup(config)
	end,
}