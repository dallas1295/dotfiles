-- First enable the LSPs
vim.lsp.enable {
  'gopls',
  'lua_ls',
  'ts_ls',
  'denols'
}


-- Diagnostic formatting: prefix with LSP name
local function diagnostic_virtual_text_format(diagnostic)
  local client = vim.lsp.get_client_by_id(diagnostic.source)
  local prefix = ""
  if client and client.name then
    prefix = client.name .. ": "
  elseif diagnostic.source then
    prefix = diagnostic.source .. ": "
  end
  return prefix .. diagnostic.message
end

-- Automatic toggle between virtual_text and virtual_lines
local function update_virtual_diagnostics()
  local bufnr = vim.api.nvim_get_current_buf()
  local line = vim.api.nvim_win_get_cursor(0)[1] - 1
  local diags = vim.diagnostic.get(bufnr, { lnum = line })
  if #diags > 0 then
    vim.diagnostic.config({
      virtual_text = false,
      virtual_lines = { current_line = true },
    })
  else
    vim.diagnostic.config({
      virtual_text = {
        format = diagnostic_virtual_text_format,
      },
      virtual_lines = false,
    })
  end
end

vim.api.nvim_create_autocmd("CursorMoved", {
  callback = update_virtual_diagnostics,
})



-- Initial diagnostic config (virtual_text on, virtual_lines off)
vim.diagnostic.config({
  virtual_text = {
    format = diagnostic_virtual_text_format,
  },
  virtual_lines = false,
  underline = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "󰅚 ",
      [vim.diagnostic.severity.WARN] = "󰀪 ",
      [vim.diagnostic.severity.INFO] = "󰋽 ",
      [vim.diagnostic.severity.HINT] = "󰌶 ",
    },
    numhl = {
      [vim.diagnostic.severity.ERROR] = "ErrorMsg",
      [vim.diagnostic.severity.WARN] = "WarningMsg",
    },
  },
  update_in_insert = false,
  severity_sort = true,
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "typescript",
    "typescriptreact",
    "typescript.tsx",
    "javascript",
    "javascriptreact",
    "javascript.jsx",
  },
  callback = function(args)
    local buf = args.buf
    local bufname = vim.api.nvim_buf_get_name(buf)

    -- Check for Deno
    local deno_root = vim.fs.find({ "deno.json", "deno.jsonc" }, { upward = true, path = bufname })[1]
    if deno_root then
      vim.lsp.enable("denols", { bufnr = buf })
      return
    end

    -- Check for Node/TS
    local node_root = vim.fs.find({ "package.json", "tsconfig.json", "jsconfig.json" }, { upward = true, path = bufname })
        [1]
    if node_root then
      vim.lsp.enable("ts_ls", { bufnr = buf })
      return
    end
  end,
})
