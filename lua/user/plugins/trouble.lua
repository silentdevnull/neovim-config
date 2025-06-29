return {
  "folke/trouble.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons", -- Optional, for icons
  },
  cmd = { "TroubleToggle", "Trouble" }, -- Lazy load on commands
  keys = {
    {
      "<leader>xx",
      function()
        require("trouble").toggle()
      end,
      desc = "Toggle Trouble (Diagnostics)",
    },
    {
      "<leader>xw",
      function()
        require("trouble").toggle("workspace_diagnostics")
      end,
      desc = "Workspace Diagnostics (Trouble)",
    },
    {
      "<leader>xd",
      function()
        require("trouble").toggle("document_diagnostics")
      end,
      desc = "Document Diagnostics (Trouble)",
    },
    {
      "<leader>xl",
      function()
        require("trouble").toggle("loclist")
      end,
      desc = "Location List (Trouble)",
    },
    {
      "<leader>xq",
      function()
        require("trouble").toggle("quickfix")
      end,
      desc = "Quickfix List (Trouble)",
    },
    {
      "gR", -- Note: uses 'R' not 'r' to avoid conflict with neo-tree rename
      function()
        require("trouble").toggle("lsp_references")
      end,
      desc = "LSP References (Trouble)",
    },
    -- You can add more specific keymaps if needed, e.g., for next/prev item
    -- {
    --   "]t",
    --   function()
    --     require("trouble").next({ skip_groups = true, jump = true })
    --   end,
    --   desc = "Next Trouble Item",
    -- },
    -- {
    --   "[t",
    --   function()
    --     require("trouble").previous({ skip_groups = true, jump = true })
    --   end,
    --   desc = "Previous Trouble Item",
    -- },
  },
  config = function()
    require("trouble").setup({
      -- Your custom configuration goes here
      -- signs = {
      --   -- icons / text used for a diagnostic
      --   error = "", -- Nerd Font Error Icon
      --   warning = "", -- Nerd Font Warning Icon
      --   hint = "", -- Nerd Font Hint Icon
      --   information = "", -- Nerd Font Info Icon
      -- },
      -- use_diagnostic_signs = true, -- enabling this will use the signs defined in your lsp client
      auto_close = false, -- automatically close when the last diagnostic is fixed
      auto_preview = true, -- automatically preview the location of the diagnostic. <esc> to close preview
      -- Other options...
    })
    vim.notify("Trouble plugin configured", vim.log.levels.INFO)
  end,
}

