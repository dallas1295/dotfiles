return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  dependencies = { 'nvim-lua/plenary.nvim' },
  require('telescope').setup {
    defaults = {
      mappings = {
        i = { -- Insert mode
          ["<C-j>"] = require('telescope.actions').move_selection_next,
          ["<C-k>"] = require('telescope.actions').move_selection_previous,
          -- Optionally, you can disable the old mappings:
          ["<C-n>"] = false,
          ["<C-p>"] = false,
        },
        n = { -- Normal mode
          ["<C-j>"] = require('telescope.actions').move_selection_next,
          ["<C-k>"] = require('telescope.actions').move_selection_previous,
          ["<C-n>"] = false,
          ["<C-p>"] = false,
        },
      },
    },
  },
  require("telescope").load_extension("harpoon"),
}
