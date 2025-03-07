return {
  "neovim/nvim-lspconfig",
  config = function()
    local lspconfig = require("lspconfig")
    lspconfig.vtsls.setup{
      --empty setup will prevent it from attaching.
    }
  end,
}
