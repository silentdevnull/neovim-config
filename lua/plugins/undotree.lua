return {
  {
    "mbbill/undotree",
    cmd = "UndotreeToggle",
    keys = {
      { "<leader>u", "<cmd>UndotreeToggle<CR>", desc = "Toggle Undotree" },
    },
    config = function()
      vim.g.undotree_DiffAutoOpen = 1       -- Auto open diff panel
      vim.g.undotree_SetFocusWhenToggle = 1 -- Focus undotree when opened
      vim.g.undotree_ShortIndicators = 1    -- Use shorter indicators
      vim.g.undotree_WindowLayout = 2       -- Layout 2: Left vertical split
      vim.g.undotree_DiffpanelHeight = 10   -- Set diff panel height
    end,
  },
}
