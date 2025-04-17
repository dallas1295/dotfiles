return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	opts = {
		menu = {
			width = vim.api.nvim_win_get_width(0) - 4,
		},
		settings = {
			save_on_toggle = true,
		},
	},
	keys = function()
		local keys = {
			{
				"<leader>v",
				function()
					require("harpoon"):list():add()
				end,
				desc = "Harpoon File",
			},
			{
				"<leader>h",
				function()
					local harpoon = require("harpoon")
					harpoon.ui:toggle_quick_menu(harpoon:list())
				end,
				desc = "Harpoon Quick Menu",
			},
			{
				"<C-t>",
				function()
					local harpoon = require("harpoon")
					harpoon.ui:select_menu_item({ bufedit = true })
				end,
				desc = "Harpoon New Tab",
			},
			{
				"<C-v>",
				function()
					local harpoon = require("harpoon")
					harpoon.ui:select_menu_item({ vsplit = true })
				end,
				desc = "Harpoon New Split",
			},
		}

		for i = 1, 5 do
			table.insert(keys, {
				"<leader>" .. i,
				function()
					require("harpoon"):list():select(i)
				end,
				desc = "Harpoon to File " .. i,
			})
		end
		return keys
	end,
}
