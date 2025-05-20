-- ~/.config/nvim/lua/user/plugins/ts_autotag.lua
return {
  "windwp/nvim-ts-autotag",
  ft = { "html", "xml", "javascriptreact", "typescriptreact", "vue", "svelte", "php" }, -- Add relevant filetypes
  config = function()
    require("nvim-ts-autotag").setup({
      -- Default options are usually fine
      -- enable_rename = true,
      -- enable_close = true,
      -- enable_close_on_slash = true,
    })
    vim.notify("nvim-ts-autotag configured", vim.log.levels.INFO, { title = "TS Autotag" })
  end,
}
