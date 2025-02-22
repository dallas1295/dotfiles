return {
    {
        "catppuccin/nvim",
        priority = 1000,
        dependencies = {
            "LazyVim/LazyVim",
        },
        opts = {
            flavour = "mocha",
            transparent_background = true,
            dim_inactive = {
                enabled = false,
                shade = "dark",
                percentage = 0.15,
            },
        },
    },
}
