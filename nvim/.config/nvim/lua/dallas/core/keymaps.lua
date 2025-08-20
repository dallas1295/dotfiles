-- set leader key to space
vim.g.mapleader = " "
local keymap = vim.keymap -- for conciseness

------------------ General Keymaps -------------------

keymap.set("i", "<Tab>", "<Nop>")

-- clear search highlights
keymap.set("n", "<leader>on", ":nohl<CR>", { desc = "Clear search highlights" })

-- diagnostic output
keymap.set("n", "<leader>tb", function()
	vim.diagnostic.setloclist()
	vim.cmd("lopen")
end, { desc = "Show LSP diagnostics in location list" })

keymap.set("n", "<C-M-j>", "<cmd>cnext<CR>")
keymap.set("n", "<C-M-k>", "<cmd>cprev<CR>")
keymap.set("n", "<leader>tt", function()
	vim.diagnostic.setqflist()
	vim.cmd("copen")
end, { desc = "Show Quick Fix list in location list" })

-- Up and Down

keymap.set("n", "<C-M-j>", ":m .+1<CR>==", { noremap = true, silent = true })
keymap.set("v", "<C-M-j>", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
keymap.set("n", "<C-M-k>", ":m .-2<CR>==", { noremap = true, silent = true })
keymap.set("v", "<C-M-k>", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })

-- Window management
keymap.set("n", "<leader>sv", ":vnew<CR>", { desc = "Split window vertically" })
keymap.set("n", "<leader>sh", ":new<CR>", { desc = "Split window horizontally" })
keymap.set("n", "<leader>be", "<C-w>=", { desc = "Make splits equal size" })
keymap.set("n", "<leader>bk", "<C-w>5+", { desc = "Increase the height of the buffer split" })
keymap.set("n", "<leader>bj", "<C-w>5-", { desc = "Decrease the height of the buffer split" })
keymap.set("n", "<leader>bl", "<C-w>5<", { desc = "Increase the width of the buffer split" })
keymap.set("n", "<leader>bh", "<C-w>5>", { desc = "Decrease the width of the buffer split" })
keymap.set("n", "<leader>sc", "<cmd>close<CR>", { desc = "Close current split" })

keymap.set("n", "<leader>bn", "<cmd>enew<CR>", { desc = "Create an empty buffer" })
keymap.set("n", "<leader>bo", "<cmd>BufferLineCloseOthers<CR>", { desc = "Close all buffer except current" })
keymap.set("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Close current buffer" })
keymap.set("n", "<leader>bq", "<cmd>bdelete!<CR>", { desc = "Close current buffer" })

keymap.set("n", "-", "<cmd>Oil<CR>", { desc = "Open parent directory" })

keymap.set("n", "<leader>cp", "<cmd>Floaterminal<CR>", { desc = "Toggle a terminal buffer" })

-- quits
keymap.set("n", "<leader>qq", "<cmd>qall<CR>", { desc = "Close Neovim", noremap = true, silent = true })
keymap.set("n", "<leader>wq", "<cmd>wq<CR>", { desc = "Write Quit Buffer", noremap = true, silent = true })

-- Lazy & Plugins

-- Menus
keymap.set("n", "<leader>pl", "<cmd>Lazy<cr>", { desc = "Open Lazy menu" })

-- Bufferline
for i = 1, 9 do
	vim.keymap.set("n", "<leader>" .. i, function()
		vim.cmd("BufferLineGoToBuffer " .. i)
	end, { desc = "Go to buffer " .. i })
end

-- Telescope
keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })
keymap.set("n", "<leader><leader>", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
keymap.set("n", "<leader>fo", "<cmd>Telescope oldfiles<cr>", { desc = "recent files" })
keymap.set("n", "<leader>fg", "<cmd>Telescope grep_string<cr>", { desc = "Grep search" })
keymap.set("n", "<leader>fv", function()
	require("telescope.builtin").grep_string({ search = vim.fn.expand("<cword>") })
end, { desc = "Search word under cursor" })
keymap.set("n", "<leader>fl", "<cmd>Telescope live_grep<cr>", { desc = "Live grep in root" })
keymap.set("n", "<leader>fb", "<cmd>Telescope multigrep<cr>", { desc = "Multigrep in root" })
keymap.set("n", "<leader>fr", "<cmd>Telescope resume<cr>", { desc = "Resume grep" })
keymap.set("n", "<leader>fp", "<cmd>Telescope search_history<cr>", { desc = "Search History" })
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Show buffers" })
