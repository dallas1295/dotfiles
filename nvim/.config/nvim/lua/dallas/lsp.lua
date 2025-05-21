-- Keymaps for LSP
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local opts = { buffer = args.buf }
    vim.keymap.set({ "n", "x" }, "gq", function()
      vim.lsp.buf.format({ async = true })
    end, opts)
    vim.keymap.set("n", "grt", vim.lsp.buf.type_definition, opts)
    vim.keymap.set("n", "grd", vim.lsp.buf.declaration, opts)
  end,
})

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
  underline = true,
  signs = true,
  update_in_insert = false, -- only update diagnostics outside of insert mode
  severity_sort = true,     -- sort diagnostics by severity
})

vim.keymap.set('n', '<leader>k', vim.diagnostic.open_float)

-- TODO need to add other servers (and install them)
-- TODO is there a way for me to use my mason installs for ease of use???



-- HACK this will need to be sorted out eventually Deno only attaches to vanilla projects
-- HACK this will still breaks the interaction on vanilla files with both attaching (it ruins node projects in vanilla ts/js essentially)
-- TODO maybe the solution is to create a truthy/falsy response for enabling deno?
vim.api.nvim_create_autocmd('FileType', {
  pattern = {
    'javascript',
    'typescript',
  },
  callback = function()
    vim.lsp.start({
      name = 'denols',
      cmd = { 'deno', 'lsp' },
      root_dir = vim.fs.dirname(
        vim.fs.find({ 'deno.json', 'deno.jsonc' }, { upward = true })[1]
      ),
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

vim.api.nvim_create_autocmd('FileType', {
  pattern = {
    'typescript', 'typescriptreact', 'typescript.tsx',
    'javascript', 'javascriptreact', 'javascript.jsx',
  },
  callback = function(args)
    local bufname = vim.api.nvim_buf_get_name(args.buf)
    local root = vim.fs.dirname(
      vim.fs.find({ 'package.json', 'tsconfig.json', 'jsconfig.json', '.git' }, { upward = true, path = bufname })[1]
    )
    if not root then return end

    -- Don't start ts_ls if this is a Deno project
    if vim.fs.find({ 'deno.json', 'deno.jsonc' }, { upward = true, path = root })[1] then
      return
    end

    vim.lsp.start({
      name = 'ts_ls',
      cmd = { 'typescript-language-server', '--stdio' },
      root_dir = root,
      on_init = function()
        print('TypeScript LS enabled')
      end,
    })
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'lua' },
  callback = function()
    vim.lsp.start({
      name = 'lua_ls',
      cmd = { 'lua-language-server' },
      root_dir = vim.fs.dirname(
        vim.fs.find({ '.luarc.json', '.luarc.jsonc' }, { upward = true })[1]
      ),
      settings = {
        Lua = {
          runtime = {
            version = 'LuaJIT',
            path = vim.split(package.path, ';'),
          },
          diagnostics = {
            globals = { 'vim' }, -- Recognize the `vim` global
          },
          workspace = {
            library = {
              vim.env.VIMRUNTIME,
            },
            checkThirdParty = false, -- Remove prompt about third party
          },
          telemetry = { enable = false },
        },
      },
      on_init = function()
        print('Lua LS enabled')
      end,
    })
  end,
})
