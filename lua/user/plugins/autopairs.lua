-- ~/.config/nvim/lua/user/plugins/autopairs.lua
return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  config = function()
    require("nvim-autopairs").setup({
      check_ts = true,      -- Use treesitter to check for pair completion
      ts_config = {
        lua = { "string" }, -- Don't add pairs inside lua strings
        javascript = { "template_string" },
        java = false,       -- Disable for java
      },
      -- You can add custom rules here if needed
    })
    vim.notify("nvim-autopairs configured", vim.log.levels.INFO, { title = "Autopairs" })
  end,
}
