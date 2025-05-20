-- ~/.config/nvim/lua/user/plugins/surround.lua

return {
  "kylechui/nvim-surround",
  version = "*", -- Use latest version
  event = "VeryLazy",
  config = function()
    require("nvim-surround").setup({
      -- Configuration options, if any, go here.
      -- Defaults are usually very good.
    })
    vim.notify("nvim-surround configured", vim.log.levels.INFO, { title = "Surround" })
  end,
}
