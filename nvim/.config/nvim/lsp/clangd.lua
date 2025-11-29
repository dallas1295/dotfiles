return {
	name = "clangd",
	cmd = { "clangd" },
	filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
	root_markers = {
		".clangd",
		".clang-tidy",
		".clang-format",
		"compile_commands.json",
		"compile_flags.txt",
		"configure.ac",
	},
	init_options = {
		clangdFileStatus = true,
		fallbackFlags = { "-std=c++23" },
	},
}
