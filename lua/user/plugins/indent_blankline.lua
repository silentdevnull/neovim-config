-- ~/:config/nvim/lua/user/plugins/indent_blankline.lua

return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl", -- If the plugin specifies a main module
  event = { "BufReadPre", "BufNewFile" },
  -- Or lazy = false if you want it always active immediately
  config = function()
    local ibl = require("ibl")
    ibl.setup({
      indent = {
        char = "▏", -- You can use other characters like '│', '┆', '┊'
        tab_char = "▏",
      },
      scope = {
        enabled = true,
        show_start = true,
        show_end = true,
        -- char = "─", -- Character for the scope line
        -- highlight = "IblScope", -- Custom highlight group for scope lines
      },
      exclude = {
        filetypes = {
          "help",
          "alpha",
          "dashboard",
          "neo-tree",
          "NvimTree",
          "Trouble",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
          "lazyterm",
        },
        buftypes = { "terminal" },
      },
    })
    vim.notify("Indent-Blankline configured", vim.log.levels.INFO, { title = "IndentBlankline" })
  end,
}
