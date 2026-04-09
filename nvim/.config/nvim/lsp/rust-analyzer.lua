return {
	name = "rust-analyzer",
	cmd = { "rust-analyzer" },
	filetypes = { "rust" },
	capabilities = {
		experimental = {
			commands = {
				commands = { "rust-analyzer.showReferences", "rust-analyzer.runSingle", "rust-analyzer.debugSingle" },
			},
			serverStatusNotification = true,
		},
	},
	settings = {
		["rust-analyzer"] = {
			lens = {
				debug = {
					enable = true,
				},
				enable = true,
				implementations = {
					enable = true,
				},
				references = {
					adt = {
						enable = true,
					},
					enumVariant = {
						enable = true,
					},
					method = {
						enable = true,
					},
					trait = {
						enable = true,
					},
				},
				run = {
					enable = true,
				},
				updateTest = {
					enable = true,
				},
			},
		},
	},
}
