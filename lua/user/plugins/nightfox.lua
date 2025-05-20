-- ~/.config/nvim/lua/user/plugins/nightfox.lua

return {
  "EdenEast/nightfox.nvim",
  lazy = false, -- Load this colorscheme early
  priority = 1000, -- Ensure it loads before other UI elements
  config = function()
    local default_theme = "nightfox" -- Your preferred default Nightfox variant
    -- vim.g.nightfox_options = { -- Optional: customize nightfox
    --   transparent = true,
    --   styles = { comments = "italic", keywords = "bold" }
    -- }
    vim.cmd("colorscheme " .. default_theme)

    vim.notify(
      "Nightfox colorscheme plugin loaded. Default theme: " .. default_theme,
      vim.log.levels.INFO, { title = "Nightfox" }
    )
  end,
}

