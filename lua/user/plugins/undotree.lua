return {
  "mbbill/undotree",
  lazy = false, -- Uncomment if you want it to load on startup
  -- event = "BufReadPre",
  keys = {
    {
      "<leader>u",
      function()
        vim.cmd("UndotreeToggle")
      end,
      desc = "Toggle Undotree",
    },
  },
  config = function()
    vim.notify("Undotree plugin loaded and configured", vim.log.levels.DEBUG)
  end,
}

