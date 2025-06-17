-- return {
--   "rebelot/kanagawa.nvim",
--   config = function()
--     -- Default options:
--     require('kanagawa').setup({
--       compile = false,  -- enable compiling the colorscheme
--       undercurl = true, -- enable undercurls
--       commentStyle = { italic = true },
--       functionStyle = {},
--       keywordStyle = { italic = true },
--       statementStyle = { bold = true },
--       typeStyle = {},
--       transparent = false,   -- do not set background color
--       dimInactive = false,   -- dim inactive window `:h hl-NormalNC`
--       terminalColors = true, -- define vim.g.terminal_color_{0,17}
--       colors = {             -- add/modify theme and palette colors
--         palette = {},
--         theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
--       },
--       overrides = function(colors) -- add/modify highlights
--         return {
--           Normal       = { bg = "#16161d" },
--           NormalNC     = { bg = "#16161d" },
--           SignColumn   = { bg = "#16161d" },
--           EndOfBuffer  = { bg = "#16161d" },
--           LineNr       = { bg = "#16161d" },
--           CursorLineNr = { bg = "#16161d" },
--           MsgArea      = { bg = "#16161d" },
--         }
--       end,
--     })
--     vim.cmd("colorscheme kanagawa-dragon")
--   end,
-- }
--
return {
  "ellisonleao/gruvbox.nvim",
  config = function()
    -- Default options:
    require("gruvbox").setup({
      terminal_colors = true, -- add neovim terminal colors
      undercurl = true,
      underline = true,
      bold = true,
      italic = {
        strings = true,
        emphasis = true,
        comments = true,
        operators = false,
        folds = true,
      },
      strikethrough = true,
      invert_selection = false,
      invert_signs = false,
      invert_tabline = false,
      inverse = true,    -- invert background for search, diffs, statuslines and errors
      contrast = "hard", -- can be "hard", "soft" or empty string
      palette_overrides = {},
      overrides = {},
      dim_inactive = false,
      transparent_mode = false,
    })
    vim.cmd("colorscheme gruvbox")
  end,
}
