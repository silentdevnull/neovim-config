return {
  "EdenEast/nightfox.nvim",
  lazy = false, 
  priority = 1000, 
  config = function()
    local default_theme = "nightfox" 
    vim.cmd("colorscheme " .. default_theme)
    vim.notify(
      "Nightfox colorscheme plugin loaded. Default theme: " .. default_theme,
      vim.log.levels.DEBUG, { title = "Nightfox" }
    )
  end,
}


