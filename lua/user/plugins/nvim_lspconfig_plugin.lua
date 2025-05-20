-- ~/.config/nvim/lua/user/plugins/nvim_lspconfig_plugin.lua

return {
  "neovim/nvim-lspconfig",
  lazy = false,
  priority = 995, -- Load this very early so its 'lspconfig' module is available
  dependencies = {
    "hrsh7th/nvim-cmp",
  },
  config = function()
    vim.notify("nvim-lspconfig plugin module is now available.", vim.log.levels.INFO, { title = "LSP" })
  end,
}
