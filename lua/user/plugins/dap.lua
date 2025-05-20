-- ~/.config/nvim/lua/user/plugins/dap.lua

return {
  "mfussenegger/nvim-dap",
  lazy = false, -- Load DAP early as other components depend on it
  priority = 1000, -- High priority
  dependencies = {
    {
      "rcarriga/nvim-dap-ui",
      dependencies = { "nvim-neotest/nvim-nio" },
    },
    -- "theHamsta/nvim-dap-virtual-text",
  },
  config = function()
    vim.notify("nvim-dap plugin config started. Triggering dap_manager setup.", vim.log.levels.DEBUG, {title = "DAP"})
    -- Defer to ensure all dependencies (like dapui) might also be processed by lazy.nvim
    -- and that the dap_manager module itself is definitely on the path.
    vim.defer_fn(function()
        local dap_manager_ok, dap_manager = pcall(require, "user.core.dap_manager")
        if dap_manager_ok and dap_manager and dap_manager.setup then
            vim.notify("dap.lua: Calling dap_manager.setup()", vim.log.levels.DEBUG, {title="DAP"})
            local setup_ok, setup_err = pcall(dap_manager.setup)
            if not setup_ok then
                vim.notify("dap.lua: ERROR during dap_manager.setup(): " .. tostring(setup_err), vim.log.levels.ERROR, {title="DAP ERROR"})
            end
        else
            vim.notify("dap.lua: Failed to load 'user.core.dap_manager' or its setup function. Error: " .. tostring(dap_manager), vim.log.levels.ERROR, {title="DAP ERROR"})
        end
    end, 50) -- Small delay
  end,
}

