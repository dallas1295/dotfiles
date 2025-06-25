-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

---------------------
-- General Keymaps -------------------

keymap.set("i", "<Tab>", "<Nop>")
-- change listing binds
keymap.set("i", "<C-h>", "<C-n>", { remap = true, silent = true })
keymap.set("i", "<C-l>", "<C-p>", { remap = true, silent = true })

-- clear search highlights
keymap.set("n", "<leader>on", ":nohl<CR>", { desc = "Clear search highlights" })

-- Increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- Window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })     -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })   -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })      -- make split windows equal width & height
keymap.set("n", "<leader>sc", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

-- Buffers
keymap.set("n", "<leader>bdd", "<cmd>bdelete<CR>", { desc = "Close current buffer" })
keymap.set("n", "<leader>bdq", "<cmd>bdelete!<CR>", { desc = "Close current buffer" })
keymap.set("n", "<leader>bl", "<cmd>ls<CR>", { desc = "List open buffers" })
keymap.set("n", "<S-h>", "<cmd>bn<CR>", { desc = "Go to next buffer" })
keymap.set("n", "<S-l", "<cmd>bp<CR>", { desc = "Go to previous buffer" })

-- quits
keymap.set("n", "<leader>qq", "<cmd>qall<CR>", { desc = "Close Neovim", noremap = true, silent = true })
keymap.set("n", "<leader>wq", "<cmd>wq<CR>", { desc = "Write Quit Buffer", noremap = true, silent = true })

-- Lazy & Plugins

-- Menus
keymap.set("n", "<leader>pl", "<cmd>Lazy<cr>", { desc = "Open Lazy menu" })
keymap.set("n", "<leader>pm", "<cmd>Mason<CR>", { desc = "Open Mason menu" })

-- Mini
keymap.set("n", "<leader>e", "<cmd>lua MiniFiles.open()<CR>", { desc = "Open explorer" })

--Copilot
keymap.set("n", "<leader>cc", "<cmd>CopilotChatToggle<CR>", { desc = "Copilot Chat" })

-- Telescope
keymap.set("n", "<leader><leader>", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
keymap.set("n", "<leader>fo", "<cmd>Telescope oldfiles<cr>", { desc = "recent files" })
keymap.set("n", "<leader>fg", "<cmd>Telescope grep_string<cr>", { desc = "Grep search" })
keymap.set("n", "<leader>fv", function()
  require("telescope.builtin").grep_string({ search = vim.fn.expand("<cword>") })
end, { desc = "Search word under cursor" })
keymap.set("n", "<leader>fl", "<cmd>Telescope live_grep<cr>", { desc = "Live grep in root" })
keymap.set("n", "<leader>fr", "<cmd>Telescope resume<cr>", { desc = "Resume grep" })
keymap.set("n", "<leader>fp", "<cmd>Telescope search_history<cr>", { desc = "Search History" })
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Show buffers" })
keymap.set("n", "<leader>fh", "<cmd>Telescope harpoon marks<cr>", { desc = "Search Harpoon marks" })
