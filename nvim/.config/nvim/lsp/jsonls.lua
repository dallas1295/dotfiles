return {
	filetypes = { "json", "jsonc" },
	settings = {
		json = {
			schemas = {
				{
					fileMatch = { "package.json" },
					url = "https://json.schemastore.org/package.json",
				},
				{
					fileMatch = { "tsconfig*.json" },
					url = "https://json.schemastore.org/tsconfig.json",
				},
				{
					fileMatch = { ".prettierrc*.json" },
					url = "https://json.schemastore.org/prettierrc.json",
				},
				{
					fileMatch = { "eslintrc*.json" },
					url = "https://json.schemastore.org/eslintrc.json",
				},
				{
					fileMatch = { ".babelrc*.json" },
					url = "https://json.schemastore.org/babelrc.json",
				},
				{
					fileMatch = { "lerna.json" },
					url = "https://json.schemastore.org/lerna.json",
				},
				{
					fileMatch = { "now.json" },
					url = "https://json.schemastore.org/now.json",
				},
				{
					fileMatch = { "composer.json" },
					url = "https://json.schemastore.org/composer.json",
				},
			},
			validate = {
				enable = true,
			},
		},
	},
}