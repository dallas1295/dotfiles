return {
  --   {
  --     "ellisonleao/gruvbox.nvim",
  --     config = function()
  --       -- Default options:
  --       require("gruvbox").setup({
  --         terminal_colors = true, -- add neovim terminal colors
  --         undercurl = true,
  --         underline = true,
  --         bold = true, italic = {
  --           strings = true,
  --           emphasis = true,
  --           comments = true,
  --           operators = false,
  --           folds = true,
  --         },
  --         strikethrough = true,
  --         invert_selection = false,
  --         invert_signs = false,
  --         invert_tabline = false,
  --         inverse = true, -- invert background for search, diffs, statuslines and errors
  --         contrast = "hard", -- can be "hard", "soft" or empty string
  --         palette_overrides = {},
  --         overrides = {
  --           NormalFloat = { bg = "#1d2021" },
  --           FloatBorder = { bg = "#1d2021" },
  --           TelescopeNormal = { bg = "#1d2021" },
  --           TelescopeBorder = { bg = "#1d2021" },
  --         },
  --         dim_inactive = false,
  --         transparent_mode = true,
  --       })
  --       vim.cmd("colorscheme gruvbox")
  --     end,
  --   },
  {
    "rebelot/kanagawa.nvim",
    name = "kanagawa",
    config = function()
      require("kanagawa").setup({
        transparent = true,
        theme = "dragon",
        overrides = function()
          return {
            NormalFloat = { bg = "#1F1F28" },
            FloatBorder = { bg = "#1F1F28" },
            TelescopeNormal = { bg = "#1F1F28" },
            TelescopeBorder = { bg = "#1F1F28" },
          }
        end,
      })
      vim.cmd("colorscheme kanagawa-dragon")
    end,
  },
}
