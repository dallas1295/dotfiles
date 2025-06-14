-- return {
-- 	"rose-pine/neovim",
-- 	name = "rose-pine",
-- 	config = function()
-- 		require("rose-pine").setup({
-- 			highlight_groups = {
-- 				Normal = { bg = "#000000" },
-- 				NormalNC = { bg = "#000000" },
-- 				SignColumn = { bg = "#000000" },
-- 				EndOfBuffer = { bg = "#000000" },
-- 				MsgArea = { bg = "#000000" },
-- 			},
-- 		})
-- 		vim.cmd("colorscheme rose-pine")
-- 	end,
-- }
--
return {
  "rebelot/kanagawa.nvim",
  config = function()
    -- Default options:
    require('kanagawa').setup({
      compile = false,  -- enable compiling the colorscheme
      undercurl = true, -- enable undercurls
      commentStyle = { italic = true },
      functionStyle = {},
      keywordStyle = { italic = true },
      statementStyle = { bold = true },
      typeStyle = {},
      transparent = false,   -- do not set background color
      dimInactive = false,   -- dim inactive window `:h hl-NormalNC`
      terminalColors = true, -- define vim.g.terminal_color_{0,17}
      colors = {             -- add/modify theme and palette colors
        palette = {},
        theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
      },
      overrides = function(colors) -- add/modify highlights
        return {
          Normal       = { bg = "#000000" },
          NormalNC     = { bg = "#000000" },
          SignColumn   = { bg = "#000000" },
          EndOfBuffer  = { bg = "#000000" },
          LineNr       = { bg = "#000000" },
          CursorLineNr = { bg = "#000000" },
          MsgArea      = { bg = "#000000" },
        }
      end,
      theme = "wave", -- Load "wave" theme
    })
    vim.cmd("colorscheme kanagawa")
  end,
}
