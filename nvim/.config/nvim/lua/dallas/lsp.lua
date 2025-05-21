-- Helper: Get Mason binary path
local function mason_bin(bin)
  return vim.fn.stdpath("data") .. "/mason/bin/" .. bin
end

-- Helper: Start LSP with Mason binary
local function start_lsp(opts)
  opts.cmd[1] = mason_bin(opts.cmd[1])
  vim.lsp.start(opts)
end

-- Diagnostic formatting: prefix with LSP name
vim.diagnostic.config({
  virtual_text = {
    format = function(diagnostic)
      local client = vim.lsp.get_client_by_id(diagnostic.source)
      local prefix = ""
      if client and client.name then
        prefix = client.name .. ": "
      elseif diagnostic.source then
        prefix = diagnostic.source .. ": "
      end
      return prefix .. diagnostic.message
    end,
  },
  virtual_lines = { current_line = true, },
  underline = true,
  signs = true,
  update_in_insert = false,
  severity_sort = true,
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local opts = { buffer = args.buf, noremap = true, silent = true }

    vim.keymap.set('n', 'rt', vim.lsp.buf.type_definition,
      vim.tbl_extend("force", opts, { desc = "LSP: Go to type definition" }))
    vim.keymap.set('n', 'rd', vim.lsp.buf.declaration, vim.tbl_extend("force", opts, { desc = "LSP: Go to declaration" }))
    vim.keymap.set('n', 'rf', function()
      vim.lsp.buf.format({ async = true })
    end, vim.tbl_extend("force", opts, { desc = "LSP: Format buffer" }))
    vim.keymap.set('n', 'rd', vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "LSP: Go to definition" }))
    vim.keymap.set('n', 'ri', vim.lsp.buf.implementation,
      vim.tbl_extend("force", opts, { desc = "LSP: Go to implementation" }))
    vim.keymap.set('n', 'rr', vim.lsp.buf.references, vim.tbl_extend("force", opts, { desc = "LSP: Show references" }))
    vim.keymap.set('n', 'rk', vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "LSP: Hover documentation" }))
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help,
      vim.tbl_extend("force", opts, { desc = "LSP: Signature help" }))
    vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action,
      vim.tbl_extend("force", opts, { desc = "LSP: Code action" }))
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "LSP: Rename symbol" }))
    vim.keymap.set('n', '<leader>rs', function()
      local bufnr = vim.api.nvim_get_current_buf()
      for _, client in ipairs(vim.lsp.get_clients({ bufnr = bufnr })) do
        client:stop()
      end
      vim.cmd("edit")
    end, vim.tbl_extend("force", opts, { desc = "LSP: Restart server" }))
    vim.keymap.set('n', '<C-d>', function()
      vim.diagnostic.setqflist()
      vim.cmd("copen")
    end, vim.tbl_extend("force", opts, { desc = "LSP: Show diagnostics in quickfix" }))
    vim.keymap.set('n', '<leader>k', vim.diagnostic.open_float,
      vim.tbl_extend("force", opts, { desc = "LSP: Show diagnostics (float)" }))
  end,
})

-- Helper: Detach ts_ls from buffer
local function detach_ts_ls(bufnr)
  for _, client in ipairs(vim.lsp.get_clients({ bufnr = bufnr })) do
    if client.name == "ts_ls" then
      client:stop()
      print("Detached ts_ls from buffer " .. bufnr)
    end
  end
end

-- Helper: Detach denols from buffer
local function detach_denols(bufnr)
  for _, client in ipairs(vim.lsp.get_clients({ bufnr = bufnr })) do
    if client.name == "denols" then
      client:stop()
      print("Detached denols from buffer " .. bufnr)
    end
  end
end

-- Deno LSP (only for plain JS/TS, not React/JSX/TSX)
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'javascript', 'typescript' },
  callback = function(args)
    -- Only attach if in a Deno project
    local root = vim.fs.dirname(
      vim.fs.find({ 'deno.json', 'deno.jsonc' }, { upward = true, path = vim.api.nvim_buf_get_name(args.buf) })[1]
    )
    if not root then return end

    -- Detach ts_ls if running
    detach_ts_ls(args.buf)

    start_lsp({
      name = 'denols',
      cmd = { 'deno', 'lsp' },
      root_dir = root,
      settings = {
        deno = {
          enable = true,
          suggest = {
            imports = {
              hosts = {
                ['https://deno.land'] = true,
              },
            },
          },
        },
      },
      on_init = function()
        print('Deno enabled')
      end,
    })
  end,
})

-- TypeScript LSP (Node/React/JSX/TSX projects, not Deno)
vim.api.nvim_create_autocmd('FileType', {
  pattern = {
    'typescript', 'typescriptreact', 'typescript.tsx',
    'javascript', 'javascriptreact', 'javascript.jsx',
  },
  callback = function(args)
    local bufname = vim.api.nvim_buf_get_name(args.buf)
    local root = vim.fs.dirname(
      vim.fs.find({ 'package.json', 'tsconfig.json', 'jsconfig.json' }, { upward = true, path = bufname })[1]
    )
    if not root then return end

    -- Don't start ts_ls if this is a Deno project
    if vim.fs.find({ 'deno.json', 'deno.jsonc' }, { upward = true, path = root })[1] then
      return
    end

    -- Detach denols if running
    detach_denols(args.buf)

    start_lsp({
      name = 'ts_ls',
      cmd = { 'typescript-language-server', '--stdio' },
      root_dir = root,
      on_init = function()
        print('TypeScript enabled')
      end,
    })
  end,
})

-- Go LSP
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'go' },
  callback = function(args)
    local bufname = vim.api.nvim_buf_get_name(args.buf)
    local root = vim.fs.dirname(
      vim.fs.find({ 'go.mod' }, { upward = true, path = bufname })[1]
    )
    if not root then return end

    start_lsp({
      name = 'gopls',
      cmd = { 'gopls' },
      root_dir = root,
      on_init = function()
        print('Go enabled')
      end,
      settings = {
        gopls = {
          analyses = {
            unusedparams = true,
            shadow = true,
          },
          staticcheck = true,
        },
      },
    })
  end,
})

-- Lua LSP
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'lua' },
  callback = function(args)
    local bufname = vim.api.nvim_buf_get_name(args.buf)
    local root = vim.fs.dirname(
      vim.fs.find({ '.luarc.json', '.luarc.jsonc', '.git' }, { upward = true, path = bufname })[1]
    )
    if not root then return end

    start_lsp({
      name = 'lua_ls',
      cmd = { 'lua-language-server' },
      root_dir = root,
      settings = {
        Lua = {
          runtime = {
            version = 'LuaJIT',
            path = vim.split(package.path, ';'),
          },
          diagnostics = {
            globals = { 'vim' },
          },
          workspace = {
            library = {
              vim.env.VIMRUNTIME,
            },
            checkThirdParty = false,
          },
          telemetry = { enable = false },
        },
      },
      on_init = function()
        print('Lua enabled')
      end,
    })
  end,
})

-- Tailwind CSS LSP
vim.api.nvim_create_autocmd('FileType', {
  pattern = {
    'html', 'css', 'scss', 'javascript', 'javascriptreact',
    'typescript', 'typescriptreact', 'vue', 'svelte',
  },
  callback = function(args)
    local bufname = vim.api.nvim_buf_get_name(args.buf)
    local root = vim.fs.dirname(
      vim.fs.find(
        { 'tailwind.config.js', 'tailwind.config.cjs', 'tailwind.config.ts', 'tailwind.config.mjs', 'postcss.config.js',
          'package.json' }, { upward = true, path = bufname })[1]
    )
    if not root then return end

    start_lsp({
      name = 'tailwindcss',
      cmd = { 'tailwindcss-language-server', '--stdio' },
      root_dir = root,
      on_init = function()
        print('Tailwind enabled')
      end,
    })
  end,
})
