return {
  "CopilotC-Nvim/CopilotChat.nvim",
  branch = "main",                                        -- or "main" for stable
  dependencies = {
    { "github/copilot.vim" },                             -- required
    { "nvim-lua/plenary.nvim" },                          -- required
    { "nvim-telescope/telescope.nvim", optional = true }, -- optional, for Telescope integration
  },
  opts = {
    -- You can add options here, or leave empty for defaults
  },
  event = "VeryLazy", -- or "InsertEnter" or any event you prefer
}
