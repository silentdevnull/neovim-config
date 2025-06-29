return {
  -- nvim-dap is a debugger UI for Neovim, and a dependency for nvim-dap-go
  {
    "mfussenegger/nvim-dap",
    -- You can add configurations for nvim-dap here if needed.
    -- For example, setting up keymaps or UI options.
    -- opts = {
    --   -- Keymaps example (uncomment and modify as needed):
    --   -- signs = {
    --   --   DapStopped = { text = "󰁕", hl = "DapStopped", texthl = "DapStopped" },
    --   --   DapBreakpoint = { text = "●", hl = "DapBreakpoint", texthl = "DapBreakpoint" },
    --   --   DapBreakpointCondition = { text = "C", hl = "DapBreakpointCondition", texthl = "DapBreakpointCondition" },
    --   --   DapLogPoint = { text = "L", hl = "DapLogPoint", texthl = "DapLogPoint" },
    --   -- },
    --   -- float_win = {
    --   --   border = "single",
    --   --   width = 80,
    --   --   height = 20,
    --   -- },
    -- },
  },
  -- nvim-dap-go provides Go-specific configurations and
  -- integrations for nvim-dap
  {
    "leoluz/nvim-dap-go",
    ft = "go", -- Only load this plugin for Go file types
    dependencies = {
      "mfussenegger/nvim-dap", -- Ensure nvim-dap is loaded before nvim-dap-go
    },
    opts = {}, -- You can add specific configurations for nvim-dap-go here if needed.
    -- For example, setting up a specific `dap-go` configuration.
    config = function()
      require("dap-go").setup({
        -- For example, you might want to specify the path to your delve
        -- executable if it's not in your PATH.
        -- delve_path = vim.fn.expand("$GOPATH/bin/dlv"),

        -- To automatically add a `launch.json` configuration when starting a debug session.
        -- This can be useful for quick debugging without manual configuration.
        -- If set to true, it will prompt you to create a default configuration
        -- if one doesn't exist.
        -- make_configs_on_create = true,
      })

      -- Optional: Set up some basic keymaps for dap if you haven't already
      -- This section is for nvim-dap, not specifically nvim-dap-go,
      -- but it's crucial for a usable debugging experience.
      local dap = require("dap")
      vim.keymap.set("n", "<F5>", dap.continue, { desc = "DAP: Continue" })
      vim.keymap.set("n", "<F10>", dap.step_over, { desc = "DAP: Step Over" })
      vim.keymap.set("n", "<F11>", dap.step_into, { desc = "DAP: Step Into" })
      vim.keymap.set("n", "<F12>", dap.step_out, { desc = "DAP: Step Out" })
      vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "DAP: Toggle Breakpoint" })
      vim.keymap.set("n", "<leader>B", function()
        dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
      end, { desc = "DAP: Set Breakpoint with Condition" })
      vim.keymap.set("n", "<leader>lp", function()
        dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
      end, { desc = "DAP: Set Log Point" })
      vim.keymap.set("n", "<leader>dr", dap.repl.toggle, { desc = "DAP: Toggle REPL" })
      vim.keymap.set("n", "<leader>dl", dap.run_last, { desc = "DAP: Run Last" })
      vim.keymap.set({ "n", "v" }, "<leader>dp", function()
        dap.repl.open({
          expressions = {
            dap.util.get_range_text(vim.fn.mode()),
          },
        })
      end, { desc = "DAP: Print expression" })
    end,
  },
}
