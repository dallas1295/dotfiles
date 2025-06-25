return {
  "github/copilot.vim",
  event = "InsertEnter",
  config = function()
    -- Remap accept to <S-Tab>
    vim.g.copilot_no_tab_map = true
    vim.api.nvim_set_keymap(
      "i",
      "<S-Tab>",
      'copilot#Accept("<CR>")',
      { expr = true, silent = true, noremap = true, replace_keycodes = false }
    )
  end,
}
