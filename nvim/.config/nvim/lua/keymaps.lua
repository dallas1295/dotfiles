-- set leader key to space
vim.g.mapleader = " "
local keymap = vim.keymap -- for conciseness

------------------ General Keymaps -------------------

-- plugin
local function pack_clean()
	local active_plugins = {}
	local unused_plugins = {}

	for _, plugin in ipairs(vim.pack.get()) do
		active_plugins[plugin.spec.name] = plugin.active
	end

	for _, plugin in ipairs(vim.pack.get()) do
		if not active_plugins[plugin.spec.name] then
			table.insert(unused_plugins, plugin.spec.name)
		end
	end

	if #unused_plugins == 0 then
		print("No unused plugins.")
		return
	end

	local choice = vim.fn.confirm("Remove unused plugins?", "&Yes\n&No", 2)
	if choice == 1 then
		vim.pack.del(unused_plugins)
	end
end

keymap.set("n", "<leader>pc", pack_clean)
keymap.set("n", "<leader>pl", function()
	vim.pack.update()
end)

-- functions
keymap.set("n", "<leader>cc", ":make!<CR>", { desc = "Compile C Project" })
keymap.set("n", "<leader>co", ":copen<CR>", { desc = "Open Compiler Quickfix List" })
keymap.set("n", "<leader>rr", ":Crun<CR>")
keymap.set("n", "<leader>rb", ":Cbuild ")
keymap.set("n", "<leader>rc", ":Ccheck<CR>")

-- LazyGit
keymap.set("n", "<leader>gg", ":LazyGit<CR>", { desc = "Open LazyGit" })

-- Which-Key
keymap.set("n", "<leader>?", function()
	require("which-key").show({ global = false })
end, { desc = "Open Which-key" })
-- exit insert mode
-- keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode" })

-- pane navigation
keymap.set({ "n", "t" }, "<c-j>", ":wincmd j<CR>")
keymap.set({ "n", "t" }, "<c-k>", ":wincmd k<CR>")
keymap.set({ "n", "t" }, "<c-h>", ":wincmd h<CR>")
keymap.set({ "n", "t" }, "<c-l>", ":wincmd l<CR>")

-- Diagnostics (via fzf-lua)
keymap.set("n", "<leader>dw", function()
	require("fzf-lua").diagnostics_workspace()
end, { desc = "Workspace diagnostics" })

keymap.set("n", "<leader>db", function()
	require("fzf-lua").diagnostics_document()
end, { desc = "Document diagnostics" })

keymap.set("n", "<leader>dn", function()
	vim.diagnostic.get_next()
end, { desc = "Go to next diagnostic error" })

keymap.set("n", "<leader>dp", function()
	vim.diagnostic.get_prev()
end, { desc = "Go to next diagnostic error" })

vim.keymap.set("n", "dl", vim.diagnostic.open_float, { desc = "Line diagnostics" })

-- super-tab
vim.keymap.set("i", "<Tab>", function()
	if vim.fn.pumvisible() == 1 then
		return vim.api.nvim_replace_termcodes("<C-y>", true, true, true)
	end
	return vim.api.nvim_replace_termcodes("<Tab>", true, true, true)
end, { expr = true })

-- Fzf-lua
keymap.set("n", "<leader><leader>", "<cmd>FzfLua files<cr>", { desc = "Find files" })
keymap.set("n", "<leader>fo", "<cmd>FzfLua oldfiles<cr>", { desc = "recent files" })
keymap.set("n", "<leader>fg", "<cmd>FzfLua grep<cr>", { desc = "Grep search" })
keymap.set("n", "<leader>fw", "<cmd>FzfLua grep_cword<cr>", { desc = "Search word under cursor" })
keymap.set("n", "<leader>fW", "<cmd>FzfLua grep_cWORD<cr>", { desc = "Search WORD under cursor" })
keymap.set("n", "<leader>fv", "<cmd>FzfLua grep_visual<cr>", { desc = "Search highlighted" })
keymap.set("n", "<leader>fl", "<cmd>FzfLua live_grep<cr>", { desc = "Live grep in root" })
keymap.set("n", "<leader>fL", "<cmd>FzfLua live_grep resume=true<cr>", { desc = "Resume live grep in root" })
keymap.set("n", "<leader>fp", "<cmd>FzfLua search_history<cr>", { desc = "Search History" })
keymap.set("n", "<leader>i", "<cmd>FzfLua buffers<cr>", { desc = "Show buffers" })
keymap.set("n", "<leader>fq", "<cmd>FzfLua quickfix<cr>", { desc = "Open quickfix" })

-- LSP symbols and navigation (via fzf-lua)
keymap.set("n", "gd", function()
	require("fzf-lua").lsp_definitions()
end, { desc = "Go to definition" })
keymap.set("n", "gD", function()
	require("fzf-lua").lsp_declarations()
end, { desc = "Go to declaration" })
keymap.set("n", "gr", function()
	require("fzf-lua").lsp_references()
end, { desc = "Go to references" })
keymap.set("n", "gi", function()
	require("fzf-lua").lsp_implementations()
end, { desc = "Go to implementation" })
keymap.set("n", "<leader>ds", function()
	require("fzf-lua").lsp_document_symbols()
end, { desc = "Document symbols" })
keymap.set("n", "<leader>ws", function()
	require("fzf-lua").lsp_workspace_symbols()
end, { desc = "Workspace symbols" })
keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover documentation" })
keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })
keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code actions" })
keymap.set("n", "<leader>lr", function()
	local bufnr = vim.api.nvim_get_current_buf()
	local clients = vim.lsp.get_clients({ bufnr = bufnr })
	for _, client in ipairs(clients) do
		vim.lsp.stop(client.id)
	end
	vim.cmd("edit")
end, { desc = "Restart LSP for current buffer" })

keymap.set("n", "<leader>on", ":nohl<CR>", { desc = "Clear search highlights" })

keymap.set("n", "<leader>lw", function()
	vim.wo.wrap = not vim.wo.wrap
end, { desc = "Toggle line wrapping" })

-- Yank/paste to/from system clipboard
keymap.set("v", "<leader>y", '"+y', { desc = "Yank selection to system clipboard" })
keymap.set("n", "<leader>yy", '"+yy', { desc = "Yank line to system clipboard" })
keymap.set("n", "<leader>p", '"+p', { desc = "Paste from system clipboard" })

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

keymap.set("n", "<leader>xs", "<cmd>w<CR>", { desc = "Close current buffer" })
keymap.set("n", "<leader>xc", "<cmd>q<CR>", { desc = "Close Neovim" })
keymap.set("n", "<leader>xC", "<cmd>q!<CR>", { desc = "Force close Neovim" })

-- Oil
keymap.set("n", "-", "<Cmd>Oil<CR>", { desc = "Open Oil" })

-- Buffer navigation
keymap.set("n", "<S-h>", "<Cmd>bprev<CR>", { desc = "Previous buffer" })
keymap.set("n", "<S-l>", "<Cmd>bnext<CR>", { desc = "Next buffer" })

-- Terminal
vim.api.nvim_create_autocmd("TermOpen", {
	group = vim.api.nvim_create_augroup("custom-term-open", { clear = true }),
	callback = function()
		vim.opt.number = false
		vim.opt.relativenumber = false
	end,
})

local term_buf = nil

keymap.set("n", "<leader>tt", function()
	if term_buf and vim.api.nvim_buf_is_valid(term_buf) then
		local wins = vim.fn.win_findbuf(term_buf)
		if #wins > 0 then
			vim.fn.win_gotoid(wins[1])
			vim.cmd("hide")
		else
			vim.cmd("belowright new")
			vim.api.nvim_win_set_height(0, 15)
			vim.api.nvim_win_set_buf(0, term_buf)
			vim.cmd("startinsert")
		end
	else
		vim.cmd("belowright new")
		vim.api.nvim_win_set_height(0, 15)
		vim.cmd.term()
		vim.cmd("startinsert")
		term_buf = vim.api.nvim_get_current_buf()
	end
end, { desc = "Toggle terminal" })

keymap.set("t", "<esc><esc>", "<C-\\><C-n>:hide<CR>", { desc = "Hide terminal" })
keymap.set("t", "<esc><S-esc>", "<C-\\><C-n>:bdelete!<CR>", { desc = "Close terminal" })

keymap.set("n", "<leader>tq", function()
	if term_buf and vim.api.nvim_buf_is_valid(term_buf) then
		vim.cmd("bdelete! " .. term_buf)
		term_buf = nil
	end
end, { desc = "Close terminal" })
