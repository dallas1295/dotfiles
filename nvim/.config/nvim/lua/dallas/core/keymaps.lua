-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

---------------------
-- General Keymaps -------------------

keymap.set("i", "<Tab>", "<Nop>")
keymap.set("i", "<C-M-j>", "<Nop>")

-- clear search highlights
keymap.set("n", "<leader>on", ":nohl<CR>", { desc = "Clear search highlights" })

-- Increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- Window management
keymap.set("n", "<leader>sv", ":vnew<CR>", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", ":new<CR>", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>bse", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>bsl", "<C-w>5+", { desc = "Increase the height of the buffer split" })
keymap.set("n", "<leader>bsh", "<C-w>5-", { desc = "Decrease the height of the buffer split" })
keymap.set("n", "<leader>bsk", "<C-w>5<", { desc = "Increase the width of the buffer split" })
keymap.set("n", "<leader>bsj", "<C-w>5>", { desc = "Decrease the width of the buffer split" })
keymap.set("n", "<leader>bo", "<cmd>BufferLineCloseOthers<CR>", { desc = "Close all buffer except current" })
keymap.set("n", "<leader>sc", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

keymap.set("n", "<leader>bdd", "<cmd>bdelete<CR>", { desc = "Close current buffer" })
keymap.set("n", "<leader>bdq", "<cmd>bdelete!<CR>", { desc = "Close current buffer" })
keymap.set("n", "<leader>bl", "<cmd>ls<CR>", { desc = "List open buffers" })
keymap.set("n", "<S-h>", "<cmd>BufferLineCyclePrev<CR>", { desc = "Go to previous buffer" })
keymap.set("n", "<S-l>", "<cmd>BufferLineCycleNext<CR>", { desc = "Go to next buffer" })

-- quits
keymap.set("n", "<leader>qq", "<cmd>qall<CR>", { desc = "Close Neovim", noremap = true, silent = true })
keymap.set("n", "<leader>wq", "<cmd>wq<CR>", { desc = "Write Quit Buffer", noremap = true, silent = true })

-- Lazy & Plugins

-- Menus
keymap.set("n", "<leader>pl", "<cmd>Lazy<cr>", { desc = "Open Lazy menu" })

-- Tree
keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")
-- Telescope
keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })
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
