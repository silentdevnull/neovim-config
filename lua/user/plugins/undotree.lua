return {
  "mbbill/undotree",
  -- lazy = false, -- Uncomment if you want it to load on startup
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
    -- Optional: Configure undotree settings here if needed
    -- vim.g.undotree_WindowLayout = 2 -- Example: Set window layout
    -- vim.g.undotree_SetFocusWhenToggle = 1 -- Example: Focus undotree window when toggled
    vim.notify("Undotree plugin loaded and configured", vim.log.levels.INFO)
  end,
}
