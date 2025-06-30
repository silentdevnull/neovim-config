return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      dockerls = {},
      docker_compose_language_service = {},
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
        on_attach = function(client, bufnr)
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

          local function buf_set_keymap(...)
            vim.api.nvim_buf_set_keymap(bufnr, ...)
          end

          local opts = { noremap = true, silent = true }

          buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
          buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
          buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
          buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
          buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
          buf_set_keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
          buf_set_keymap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
          buf_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
          buf_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
          buf_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", opts)

          vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
        end,
      },

      ts_ls = {
        init_options = {
          hostInfo = "neovim",
          preferences = {
            disableSuggestions = false,
            quoteStyle = "single", -- or "double"
            jsxAttributeCompletionStyle = "auto",
            completeFunctionCalls = true,
            includeCompletionsForModuleExports = true,
            includeCompletionsWithInsertText = true,
            includeInlayParameterNameHints = "literals", -- "none" | "literals" | "all"
            includeInlayVariableTypeHints = false,
            includeInlayPropertyDeclarationTypeHints = false,
            includeInlayFunctionParameterTypeHints = false,
            includeInlayFunctionLikeReturnTypeHints = false,
            includeInlayEnumMemberValueHints = false,
            allowRenameOfImportPath = true,
            allowTextChangesInNewFiles = true,
            allowEditorTriggers = true,
            provideRefactorNotApplicableHint = true,
            preferTypeOnlyAutoImports = true,
            interactiveInlayHints = true,
          },
        },
        settings = {
          typescript = {
            inlayHints = {
              includeInlayParameterNameHints = "literals",
              includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
            },
          },
          javascript = {
            inlayHints = {
              includeInlayParameterNameHints = "literals",
              includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
            },
          },
        },
        filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
        -- REMOVE root_dir from here:
        -- root_dir = require("lspconfig.util").find_git_ancestor,
        on_attach = function(client, bufnr)
          local function buf_set_keymap(...)
            vim.api.nvim_buf_set_keymap(bufnr, ...)
          end

          local opts = { noremap = true, silent = true }

          buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
          buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
          buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
          buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
          buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
          buf_set_keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
          buf_set_keymap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
          buf_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
          buf_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
          buf_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", opts)

          vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

          buf_set_keymap("n", "<leader>o", "<cmd>lua vim.lsp.buf.code_action({ context = { only = { 'source.organizeImports' } } })<CR>", { desc = "Organize Imports" })
          buf_set_keymap("n", "<leader>di", "<cmd>lua vim.lsp.inlay_hint(bufnr, true)<CR>", { desc = "Toggle Inlay Hints" })
        end,
      },
    },
  },
  -- Add a config function for nvim-lspconfig
  config = function(_, opts)
    -- Now that nvim-lspconfig is loaded, we can safely require its utilities
    local lspconfig_util = require("lspconfig.util")

    -- Set up root_dir for ts_ls (and any other servers that need it) here
    -- You can loop through servers in opts or set them individually
    if opts.servers and opts.servers.ts_ls then
      opts.servers.ts_ls.root_dir = lspconfig_util.find_git_ancestor
    end
    -- You might want a default root_dir for all servers if not specified
    -- opts.root_dir = lspconfig_util.find_git_ancestor -- This applies to all servers by default if not overridden

    -- Then, call the setup function for lspconfig.
    -- Lazy.nvim usually does this automatically if you provide 'opts' at the top level
    -- but if you have global settings or other setup that needs the 'util' module,
    -- this is the place.
    -- require("lspconfig").setup(opts) -- Lazy.nvim does this for you automatically
                                     -- if 'opts' is provided in the top-level spec.
                                     -- Only uncomment if you override the default Lazy.nvim behavior
                                     -- by setting `opts = false` in the plugin spec and call setup manually.

    -- General LSP configuration that uses lspconfig.util or other lspconfig features
    -- after the plugin has been loaded.
    require("lspconfig.ui.windows").default_options.border = 'rounded'
    vim.diagnostic.config({
      virtual_text = {
        spacing = 4,
        prefix = "●",
      },
      severity_sort = true,
      update_in_insert = false,
      float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
      },
    })
  end,
}
