return {
	name = "elixir-ls",
	cmd = { vim.fn.exepath("elixir-ls") },
	filetypes = { "elixir", "eex", "heex" },
	root_markers = { "mix.exs" },
	settings = {},
}
