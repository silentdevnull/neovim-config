return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "williamboman/mason.nvim", config = true }, -- NOTE: Must be loaded before dependants
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim", -- Optional: For auto-installing tools
      { "j-hui/fidget.nvim", opts = {} },
      { "folke/neodev.nvim", opts = {} },
    },
    config = function()
      local on_attach = function(_, bufnr)
        local nmap = function(keys, func, desc)
          if desc then
            desc = "LSP: " .. desc
          end
          vim.keymap.set("n", keys, func, { buffer = bufnr, noremap = true, silent = true, desc = desc })
        end

        nmap("gD", vim.lsp.buf.declaration, "Go To Declaration")
        nmap("gd", vim.lsp.buf.definition, "Go To Definition")
        nmap("K", vim.lsp.buf.hover, "Hover Documentation")
        nmap("gi", vim.lsp.buf.implementation, "Go To Implementation")
        nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")
        nmap("<leader>D", vim.lsp.buf.type_definition, "Type Definition")
        nmap("<leader>rn", vim.lsp.buf.rename, "Rename")
        nmap("<leader>ca", vim.lsp.buf.code_action, "Code Action")
        nmap("gr", vim.lsp.buf.references, "Go To References")
        nmap("[d", vim.diagnostic.goto_prev, "Go To Previous Diagnostic")
        nmap("]d", vim.diagnostic.goto_next, "Go To Next Diagnostic")
        nmap("<leader>e", vim.diagnostic.open_float, "Show Line Diagnostics")
        nmap("<leader>E", vim.diagnostic.setloclist, "Show Workspace Diagnostics")

        vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
          vim.lsp.buf.format({ async = true })
        end, { desc = "Format current buffer with LSP" })
      end

      local servers = {
        -- Web Dev
        html = {},
        cssls = {},
        ts_ls = {},

        -- C#
        csharp_ls = {}, -- lspconfig name

        -- Go
        gopls = {},

        -- Java
        jdtls = {},

        -- Rust
        rust_analyzer = {}, -- lspconfig name

        -- Ruby
        --        solargraph = {},

        -- Perl
        perlnavigator = {},

        -- Python
        pyright = {},

        -- Lua
        lua_ls = { -- lspconfig name
          settings = {
            Lua = {
              runtime = { version = "LuaJIT" },
              workspace = { checkThirdParty = false },
              diagnostics = { globals = { "vim" } },
            },
          },
        },

        -- Shell
        bashls = {}, -- lspconfig name

        -- PHP
        intelephense = {},
      }

      -- Get capabilities from nvim-cmp
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Setup neodev before lspconfig
      require("neodev").setup()

      -- Ensure the servers are installed by Mason.
      -- Pass the *lspconfig server names* (keys of the 'servers' table).
      -- mason-lspconfig will map these to the correct Mason package names.
      require("mason-lspconfig").setup({
        ensure_installed = vim.tbl_keys(servers), -- Use lspconfig names (keys from `servers` table)
      })

      -- Configure LSP servers using lspconfig
      require("mason-lspconfig").setup_handlers({
        -- Default handler: Sets up servers using settings from the `servers` table
        function(server_name) -- server_name is the lspconfig name (e.g., "tsserver")
          require("lspconfig")[server_name].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = servers[server_name], -- Fetch settings using the lspconfig name
          })
        end,

        -- Custom handler for lua_ls to ensure settings are applied correctly
        ["lua_ls"] = function()
          require("lspconfig").lua_ls.setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = servers.lua_ls.settings, -- Directly pass the settings table
          })
        end,
        -- Add other custom handlers here if needed for specific servers like jdtls
        -- ["jdtls"] = function() ... end,
      })
    end,
  },
}

