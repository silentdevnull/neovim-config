return {
  "williamboman/mason-lspconfig.nvim",
  lazy = false,
  priority = 990, -- Load after nvim-lspconfig (995) but before other things
  dependencies = {
    "williamboman/mason.nvim",
    "neovim/nvim-lspconfig", -- Ensures the 'lspconfig' module is available for lspconfig_manager
  },
  config = function()
    local m_lspc = require("mason-lspconfig")
    -- CORRECTED REQUIRE PATH:
    local lsp_setup_manager = require("user.utils.lspconfig_manager")

    if not lsp_setup_manager then
      vim.notify("MasonLSPC: Failed to load user.utils.lspconfig_manager!", vim.log.levels.ERROR, { title = "LSP ERROR" })
      return
    end

    local servers_to_setup = {
      "lua_ls",
      "rust_analyzer",
      "ts_ls",
      "eslint",
      "html",
      "cssls",
      "jsonls",
      "yamlls",
      "bashls",
      "pylsp",
      "gopls",
      "clangd",
      "sqlls",
      "lemminx", -- XML
      "taplo",   -- TOML
      "tailwindcss_language_server",
    }

    m_lspc.setup({
      ensure_installed = servers_to_setup,
      automatic_installation = true,
      handlers = {
        function(server_name)
          if lsp_setup_manager.setup_server then
            lsp_setup_manager.setup_server(server_name)
          else
            vim.notify("MasonLSPC: setup_server function not found in lspconfig_manager for " .. server_name,
              vim.log.levels.ERROR, { title = "LSP ERROR" })
          end
        end,
      },
    })

    vim.notify(
      "Mason-LSPConfig setup complete. Will attempt to manage: "
      .. table.concat(servers_to_setup, ", "),
      vim.log.levels.INFO,
      { title = "Mason-LSPConfig" }
    )

    -- Defer the final notification and diagnostic setup
    vim.defer_fn(function()
      if lsp_setup_manager and lsp_setup_manager.finalize_setup_and_notify then
        lsp_setup_manager.finalize_setup_and_notify()
      else
        vim.notify("MasonLSPC: lsp_setup_manager or finalize_setup_and_notify not found for final call!",
          vim.log.levels.ERROR, { title = "LSP ERROR" })
      end
    end, 250)
  end,
}
