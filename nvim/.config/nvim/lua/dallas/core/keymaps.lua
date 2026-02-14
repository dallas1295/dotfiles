-- set leader key to space
vim.g.mapleader = " "
local keymap = vim.keymap -- for conciseness

------------------ General Keymaps -------------------

-- pane navigation
keymap.set("n", "<c-j", ":wincmd j<CR>")
keymap.set("n", "<c-k>", ":wincmd k<CR>")
keymap.set("n", "<c-h>", ":wincmd h<CR>")
keymap.set("n", "<c-l>", ":wincmd l<CR>")

-- open link
vim.keymap.set("n", "gx", function()
	local url = vim.fn.expand("<cfile>")
	if url:match("https?://%S+") then
		vim.ui.open(url) -- Uses Neovim's built-in system opener
	else
		print("No URL found under cursor")
	end
end, { desc = "Open URL under cursor" })

-- exit insert mode
-- keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode" })

-- clear search highlights
keymap.set("n", "<leader>on", ":nohl<CR>", { desc = "Clear search highlights" })

-- Yank/paste to/from system clipboard
keymap.set("v", "<leader>y", '"+y', { desc = "Yank selection to system clipboard" })
keymap.set("n", "<leader>yy", '"+yy', { desc = "Yank line to system clipboard" })
keymap.set("n", "<leader>p", '"+p', { desc = "Paste from system clipboard" })

-- Rust
keymap.set("n", "<leader>cr", ":Cargo run<CR>", { desc = "Cargo run" })
keymap.set("n", "<leader>cb", ":Cargo Build<CR>", { desc = "Cargo build" })

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
keymap.set("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Close current buffer" })
keymap.set("n", "<leader>bq", "<cmd>bdelete!<CR>", { desc = "Close current buffer" })

keymap.set("n", "<leader>bs", "<cmd>w<CR>", { desc = "Close current buffer" })
keymap.set("n", "<leader>qq", "<cmd>q<CR>", { desc = "Close current buffer" })
keymap.set("n", "<leader>qf", "<cmd>q!<CR>", { desc = "Close current buffer" })

-- Oil
keymap.set("n", "-", "<cmd>Oil<CR>", { desc = "Open parent directory" })

-- Buffer navigation
keymap.set("n", "<S-h>", "<Cmd>bprev<CR>", { desc = "Previous buffer" })
keymap.set("n", "<S-l>", "<Cmd>bnext<CR>", { desc = "Next buffer" })
-- quits
keymap.set("n", "<leader>qq", "<cmd>qall<CR>", { desc = "Close Neovim", noremap = true, silent = true })
keymap.set("n", "<leader>wq", "<cmd>wq<CR>", { desc = "Write Quit Buffer", noremap = true, silent = true })

-- Menus
keymap.set("n", "<leader>pl", "<cmd>Lazy<cr>", { desc = "Open Lazy menu" })

-- Diagnostics
keymap.set("n", "<leader>dd", function()
	vim.diagnostic.setqflist()
	vim.cmd("copen")
end, { desc = "Diagnostics to quickfix" })
keymap.set("n", "<leader>tt", function()
	MiniExtra.pickers.diagnostic()
end, { desc = "project diagnostics" })
keymap.set("n", "<leader>td", function()
	MiniExtra.pickers.hipatterns()
end, { desc = "comment picker" })
keymap.set("n", "<leader>ts", "<cmd>Pick list scope='quickfix'<cr>", { desc = "comment picker" })

-- Pick
keymap.set("n", "<leader><leader>", "<cmd>Pick files<cr>", { desc = "Find files" })
keymap.set("n", "<leader>fl", "<cmd>Pick grep_live<cr>", { desc = "Grep search" })
keymap.set("n", "<leader>fw", "<cmd>Pick grep pattern=<cword><cr>", { desc = "Search word under cursor" })
keymap.set("n", "<leader>fp", "<cmd>Pick history<cr>", { desc = "Search History" })
keymap.set("n", "<leader>fj", "<cmd>Pick buffers<cr>", { desc = "Show buffers" })
keymap.set("n", "<leader>fb", "<cmd>Pick buffers<cr>", { desc = "Show buffers" })

-- -- Fzf
-- keymap.set("n", "<leader><leader>", "<cmd>FzfLua files<cr>", { desc = "Find files" })
-- keymap.set("n", "<leader>fo", "<cmd>FzfLua oldfiles<cr>", { desc = "recent files" })
-- keymap.set("n", "<leader>fg", "<cmd>FzfLua grep<cr>", { desc = "Grep search" })
-- keymap.set("n", "<leader>fw", "<cmd>FzfLua grep_cword<cr>", { desc = "Search word under cursor" })
-- keymap.set("n", "<leader>fW", "<cmd>FzfLua grep_cWORD<cr>", { desc = "Search WORD under cursor" })
-- keymap.set("n", "<leader>fv", "<cmd>FzfLua grep_visual<cr>", { desc = "Search highlighted" })
-- keymap.set("n", "<leader>fl", "<cmd>FzfLua live_grep<cr>", { desc = "Live grep in root" })
-- keymap.set("n", "<leader>fL", "<cmd>FzfLua live_grep_resume<cr>", { desc = "Resume live grep in root" })
-- keymap.set("n", "<leader>fp", "<cmd>FzfLua search_history<cr>", { desc = "Search History" })
-- keymap.set("n", "<leader>fb", "<cmd>FzfLua buffers<cr>", { desc = "Show buffers" })
-- keymap.set("n", "<leader>fq", "<cmd>FzfLua quickfix<cr>", { desc = "Open quickfix" })
