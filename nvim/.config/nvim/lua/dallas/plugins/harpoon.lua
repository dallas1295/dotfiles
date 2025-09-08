return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local harpoon = require("harpoon")

    harpoon:setup()

    local keymap = vim.keymap

    -- Add file to Harpoon
    keymap.set("n", "<leader>m", function()
      harpoon:list():add()
    end, { desc = "Add file to Harpoon" })

    -- Toggle Harpoon quick menu
    keymap.set("n", "<leader>h", function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = "Harpoon quick menu" })

    -- Jump to files 1–9
    for i = 1, 9 do
      keymap.set("n", "<leader>" .. i, function()
        harpoon:list():select(i)
      end, { desc = "Harpoon to file " .. i })
    end
  end,
}
