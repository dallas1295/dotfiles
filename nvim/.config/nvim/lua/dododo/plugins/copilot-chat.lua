return {
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		dependencies = {
			{ "zbirenbaum/copilot.lua" },
			{ "nvim-lua/plenary.nvim", branch = "master" },
		},
		build = "make tiktoken",
		opts = function()
			local user = vim.env.USER or "User"
			user = user:sub(1, 1):upper() .. user:sub(2)
			return {
				auto_insert_mode = true,
				question_header = "  " .. user .. " ",
				answer_header = "  Copilot ",
				window = {
					width = 0.45,
				},
				model = "claude-3.7-sonnet",
				mappings = {
					submit_prompt = {
						normal = "<CR>",
						insert = "<C-s>",
					},
					complete = {
						insert = "<Tab>",
					},
					close = {
						normal = "q",
						insert = "<C-c>",
					},
					reset = {
						normal = false,
						insert = false,
					},
				},
			}
		end,
		-- See Configuration section for options
		-- See Commands section for default commands if you want to lazy load on them
	},
}
