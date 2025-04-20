return {
  "neovim/nvim-lspconfig",
  event = "VeryLazy",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",             -- For capabilities
    { "folke/neodev.nvim", opts = {} }, -- Neovim Lua dev helper
  },
  config = function()
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    -- == Global LSP Settings ==
    vim.diagnostic.config({
      virtual_text = true,
      signs = true,
      underline = true,
      update_in_insert = false,
      severity_sort = true,
    })
    local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    end

    -- == Keymaps (applied in on_attach) ==
    local on_attach = function(client, bufnr)
      local map = function(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, desc = "LSP: " .. desc })
      end
      map("n", "K", vim.lsp.buf.hover, "Hover Documentation")
      map("n", "gd", vim.lsp.buf.definition, "Go to Definition")
      map("n", "gD", vim.lsp.buf.declaration, "Go to Declaration")
      map("n", "gi", vim.lsp.buf.implementation, "Go to Implementation")
      map("n", "gr", vim.lsp.buf.references, "Go to References")
      map("n", "gt", vim.lsp.buf.type_definition, "Go to Type Definition")
      map("n", "<leader>ca", vim.lsp.buf.code_action, "Code Action")
      map("n", "<leader>rn", vim.lsp.buf.rename, "Rename")
      map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code Action (Visual)")

      -- Example: Add signature help mapping
      map("i", "<C-s>", vim.lsp.buf.signature_help, "Signature Help")

      -- Formatting handled by conform.nvim, but you could add LSP format keymap as fallback
      -- if client.supports_method("textDocument/formatting") then
      --   map('n', '<leader>fml', function() vim.lsp.buf.format { async = true } end, "Format (LSP)")
      -- end
    end

    -- == Server Setup ==
    -- mason-lspconfig automatically sets up servers listed in mason's ensure_installed
    -- Use the 'handlers' section in mason-lspconfig OR explicit setup below
    -- ONLY if you need to override default settings.

    local lspconfig = require("lspconfig")

    -- Example: Customize lua_ls settings
    lspconfig.lua_ls.setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        Lua = {
          runtime = { version = "LuaJIT" }, -- Adjust if needed
          diagnostics = { globals = { "vim" } },
          workspace = { library = vim.api.nvim_get_runtime_file("", true) },
          telemetry = { enable = false },
        },
      },
    })

    -- Example: Basic setup for other servers (handled by mason-lspconfig by default)
    -- You generally DON'T need these lines if using automatic_installation = true
    -- local servers = { "tsserver", "pyright", "gopls", "rust_analyzer", "jdtls", ... }
    -- for _, server_name in ipairs(servers) do
    --   lspconfig[server_name].setup({
    --     capabilities = capabilities,
    --     on_attach = on_attach,
    --   })
    -- end

    -- == Global Keymaps ==
    vim.keymap.set("n", "<leader>ld", vim.diagnostic.open_float, { desc = "LSP: Line Diagnostics" })
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "LSP: Previous Diagnostic" })
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "LSP: Next Diagnostic" })

    print("LSP configuration loaded. Defaults applied via mason-lspconfig.")
  end,
}
