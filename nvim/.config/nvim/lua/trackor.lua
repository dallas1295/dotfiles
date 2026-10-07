-- Trackor: `trackor grep` → quickfix menu
--
-- Expects grep-compliant output from trackor:
--   .trackor/20260908-64459876.md:3:OPEN:HIGH  :Search feature
--
-- <leader>ii (or :Trackor [args]) fills the quickfix with status,
-- priority, and description. <Enter> opens the issue file and closes
-- the menu.

local function center(s, width)
	local pad = width - #s
	if pad <= 0 then
		return s
	end
	local left = math.floor(pad / 2)
	return string.rep(" ", left) .. s .. string.rep(" ", pad - left)
end

local function grep(args)
	local out = vim.fn.system(vim.list_extend({ "trackor", "grep" }, args))

	if vim.v.shell_error ~= 0 then
		vim.notify("trackor grep failed — is the binary on PATH?", vim.log.levels.WARN)
		return
	end

	local cwd = vim.fn.getcwd()
	local items = {}

	for line in vim.gsplit(out, "\n", { trimempty = true }) do
		local path, status, prio, desc = line:match("^(.-):%d+:([^:]+):([^:]*):(.*)$")
		if path then
			prio = prio:gsub("^%s+", ""):gsub("%s+$", "")
			table.insert(items, {
				filename = vim.fs.normalize(cwd .. "/" .. path),
				text = center(status, 6) .. " | " .. center(prio, 6) .. " | " .. desc,
			})
		end
	end

	if #items == 0 then
		vim.notify("trackor: no issues", vim.log.levels.INFO)
		return
	end

	vim.fn.setqflist({}, " ", { title = "trackor grep", items = items })
	vim.cmd("copen")
end

vim.api.nvim_create_user_command("Trackor", function(opts)
	local args = opts.args ~= "" and vim.split(opts.args, "%s+") or {}
	grep(args)
end, { nargs = "*", desc = "trackor grep → quickfix" })

-- (other quickfixes — e.g. compiler output — keep the default behavior)
vim.api.nvim_create_autocmd("FileType", {
	pattern = "qf",
	group = vim.api.nvim_create_augroup("trackor-qf", { clear = true }),
	callback = function(args)
		if vim.fn.getqflist({ title = 0 }).title ~= "trackor grep" then
			return
		end
		vim.keymap.set("n", "<CR>", "<CR><cmd>silent! cclose<CR>", {
			buffer = args.buf,
			desc = "Open issue and close menu",
		})
	end,
})
