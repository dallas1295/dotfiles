return {
	{ "nvim-mini/mini.surround",
		version = false,
		opts = {
			mappings = {
				add = "sa", -- Add surrounding in Normal mode
				delete = "sd", -- Delete surrounding
				find = "sf", -- Find surrounding
				find_left = "sF", -- Find surrounding to the left
				replace = "sr", -- Replace surrounding
				update_n_lines = "sn", -- Update `n_lines`
				
				-- Visual mode mappings
				add_visual = "sa", -- Add surrounding in Visual mode
			},
		},
	}
}
