return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local harpoon = require("harpoon")
    harpoon:setup()

    -- <leader>h to add current file to Harpoon list
    vim.keymap.set("n", "<leader>h", function()
      harpoon:list():add()
    end, { desc = "Harpoon: Add file" })

    -- <leader>a to open the Harpoon quick menu
    vim.keymap.set("n", "<leader>a", function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = "Harpoon: Quick Menu" })

    -- <leader>1 ... <leader>9 to jump to Harpoon marks 1-9
    for i = 1, 9 do
      vim.keymap.set("n", "<leader>" .. i, function()
        harpoon:list():select(i)
      end, { desc = "Harpoon: Go to mark " .. i })
    end
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "harpoon-menu",
      callback = function(args)
        vim.keymap.set("n", "q", function()
          local bufnr = args.buf
          -- Get all lines from the quick menu buffer
          local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
          -- Remove empty lines
          local new_marks = {}
          for _, line in ipairs(lines) do
            if line ~= "" then
              table.insert(new_marks, line)
            end
          end
          -- Replace Harpoon's list with the new marks
          harpoon:list().items = {}
          for _, mark in ipairs(new_marks) do
            harpoon:list():add(mark)
          end
          harpoon:list():save()
          -- Close the menu
          vim.api.nvim_buf_delete(bufnr, { force = true })
        end, { buffer = args.buf, desc = "Harpoon: Save and close menu" })
      end,
    })
  end,
}
