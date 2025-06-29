-- lua/user/lspconfig.lua (example file path for your lazy.nvim config)

return {
  "neovim/nvim-lspconfig",
  -- This 'opts' table will be passed directly to `require('lspconfig').setup({...})`
  opts = {
    -- Servers defined here will be set up by nvim-lspconfig.
    -- Each server can have its own settings and 'on_attach' function.
    servers = {
      -- Configuration for the Go Language Server (gopls)
      gopls = {
        settings = {
          gopls = {
            gofumpt = true,
            codelenses = {
              gc_details = false,
              generate = true,
              regenerate_cgo = true,
              run_govulncheck = true,
              test = true,
              tidy = true,
              upgrade_dependency = true,
              vendor = true,
            },
            hints = {
              assignVariableTypes = true,
              compositeLiteralFields = true,
              compositeLiteralTypes = true,
              constantValues = true,
              functionTypeParameters = true,
              parameterNames = true,
              rangeVariableTypes = true,
            },
            analyses = {
              nilness = true,
              unusedparams = true,
              unusedwrite = true,
              useany = true,
            },
            usePlaceholders = true,
            completeUnimported = true,
            staticcheck = true,
            directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
            semanticTokens = true,
          },
        },
        -- This 'on_attach' function is specific to the 'gopls' server.
        -- It will be called when gopls attaches to a buffer.
        on_attach = function(client, bufnr)
          -- workaround for gopls not supporting semanticTokensProvider
          -- https://github.com/golang/go/issues/54531#issuecomment-1464982242
          if not client.server_capabilities.semanticTokensProvider then
            local semantic = client.config.capabilities.textDocument.semanticTokens
            client.server_capabilities.semanticTokensProvider = {
              full = true,
              legend = {
                tokenTypes = semantic.tokenTypes,
                tokenModifiers = semantic.tokenModifiers,
              },
              range = true,
            }
          end

          -- You can also add common keymaps or autocmds here that are
          -- specific to LSP, or even to 'gopls' itself.
          -- Example of basic LSP keymaps:
          local function buf_set_keymap(...)
            vim.api.nvim_buf_set_keymap(bufnr, ...)
          end

          local opts = { noremap = true, silent = true }

          buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
          buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
          buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
          buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
          buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
          buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
          buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
          buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
          buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
          buf_set_keymap('n', '<leader>f', '<cmd>lua vim.lsp.buf.format({ async = true })<CR>', opts)

          -- Optional: Set up omnifunc for older completion methods
          vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
        end,
      },

      -- Example for another server (you would add more here as needed)
      -- lua_ls = {
      --   settings = {
      --     Lua = {
      --       workspace = {
      --         checkThirdParty = false,
      --       },
      --       telemetry = {
      --         enable = false,
      --       },
      --     },
      --   },
      --   on_attach = function(client, bufnr)
      --     -- Common LSP setup here for lua_ls
      --   end,
      -- },
    },
    -- This 'on_attach' function (at the global 'opts' level) applies to ALL servers
    -- unless overridden by a server-specific 'on_attach'.
    -- If you are using LazyVim's global on_attach, you might not need this.
    -- on_attach = function(client, bufnr)
    --   print("LSP attached: " .. client.name)
    --   -- Add common LSP keymaps here that apply to all servers
    -- end,
  },

  -- 'config' function runs after the plugin is loaded and `opts` are processed
  -- (i.e., after `lspconfig.setup(opts)` has been called by lazy.nvim).
  -- This is a good place for global LSP configurations that don't fit into 'opts'.
  config = function(_, opts)
    -- This block is largely for global LSP customization that isn't part of the
    -- 'lspconfig.setup' call directly. For example, if you're not using
    -- LazyVim and want to set up common on_attach logic globally.
    --
    -- If you are using LazyVim, it likely has its own global `on_attach`
    -- mechanism that calls `LazyVim.lsp.on_attach`. You would typically
    -- let LazyVim handle that global part.
    --
    -- Example for setting up global `on_attach` if you're NOT using LazyVim's system:
    -- require('lspconfig.ui.windows').default_options.border = 'rounded'
    -- vim.diagnostic.config({
    --   -- Your diagnostic settings here
    -- })
    --
    -- You passed opts to the config function in your question.
    -- The second argument `opts` here refers to the actual `opts` table defined above.
    -- This is generally not needed if your 'opts' are directly passed to lspconfig.setup.
  end,
}
