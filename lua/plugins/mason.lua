return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      ui = {
        border = "rounded",
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
      ensure_installed = {
        "lua-language-server",        -- Lua
        "ts-ls",                      -- TS/JS/React/React Native
        "css-lsp",                    -- CSS
        "html-lsp",                   -- HTML
        "json-lsp",                   -- JSON
        "yaml-language-server",       -- YAML
        "bash-language-server",       -- Bash/Shell
        "dockerfile-language-server", -- Dockerfile (consider docker-compose-language-server too)
        "gopls",                      -- Go
        "jdtls",                      -- Java
        "csharp-ls",                  -- C# (Omnisharp)
        "rust-analyzer",              -- Rust
        "intelephense",               -- PHP
        "kotlin-language-server",     -- Kotlin
        "sourcekit-lsp",              -- Swift (macOS/Linux with Swift toolchain)
        "terraform-ls",               -- Terraform
        "pyright",                    -- Python
        "taplo",                      -- TOML
        "marksman",                   -- Markdown
        "perl-language-server",       -- Perl

        -- Linters
        "eslint_d",      -- JS/TS/React...
        "shellcheck",    -- Bash/Shell
        "ruff",          -- Python (Fast, includes flake8 rules + more)
        "yamllint",      -- YAML
        "luacheck",      -- Lua
        "ktlint",        -- Kotlin
        "golangci-lint", -- Go (Meta-linter)
        "tflint",        -- Terraform
        "perlcritic",    -- Perl

        -- Formatters
        "prettierd",          -- JS/TS/React/JSON/YAML/HTML/CSS/MD... (Daemonized)
        "stylua",             -- Lua
        "shfmt",              -- Bash/Shell
        "black",              -- Python (Code style)
        "isort",              -- Python (Import sorting)
        "ruff",               -- Python (Can also format)
        "goimports",          -- Go (Handles imports and formatting)
        "gofmt",              -- Go (Basic formatting, often covered by goimports)
        "ktlint",             -- Kotlin (Can also format)
        "swift-format",       -- Swift
        "taplo",              -- TOML
        "google-java-format", -- Java
        "perltidy",           -- Perl
      },
    },
    config = function(_, opts)
      require("mason").setup(opts)
      -- leaving these for debug later
      -- print("Mason setup complete. Check :Mason for installation status.")
      --      print("Note: Ensure language runtimes (Node, Go, Python, Java, .NET, Rust, PHP, Perl etc.) are installed for Mason tools to work.")
    end,
  },

  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
    opts = {
      automatic_installation = true,
    },
  },
}
