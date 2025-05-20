-- ~/.config/nvim/lua/user/plugins/mason.lua

return {
  "williamboman/mason.nvim",
  cmd = { "Mason", "MasonInstall", "MasonUpdate" }, -- Lazy load Mason
  config = function()
    local mason = require("mason")

    local ensure_installed_tools = {
      -- LSPs
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
      "csharpier",

      "sqlls",
      "lemmix",
      "toplo",
      "tailwindcss-language-server",

      -- Formatters (Conform will use these, Mason can manage their installation)
      "stylua",
      "prettier",
      "shfmt",
      "black",
      "isort",
      "goimports",
      "clang-format",
      "ruff",
      "csharpier",
      "sqlfluff",
      -- Linters
      -- "shellcheck",
    }

    mason.setup({
      ui = {
        border = "rounded",
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
      ensure_installed = ensure_installed_tools,
    })

    vim.notify(
      "Mason setup complete. Ensure installed: "
      .. table.concat(ensure_installed_tools, ", "),
      vim.log.levels.INFO,
      { title = "Mason" }
    )
  end,
}
