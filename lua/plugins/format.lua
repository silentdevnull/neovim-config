return {
  "stevearc/conform.nvim",
  event = "VeryLazy",
  opts = {
    formatters_by_ft = {
      javascript = { "prettierd" },
      typescript = { "prettierd" },
      javascriptreact = { "prettierd" },
      typescriptreact = { "prettierd" },
      css = { "prettierd" },
      html = { "prettierd" },
      json = { "prettierd" },
      yaml = { "prettierd" },
      markdown = { "prettierd" },
      lua = { "stylua" },
      python = { "ruff_format", "black", "isort" }, -- Try ruff first, then black, then isort
      sh = { "shfmt" },
      bash = { "shfmt" },
      go = { "goimports", "gofmt" }, -- goimports usually covers gofmt
      java = { "google-java-format" },
      kotlin = { "ktlint" },
      swift = { "swift-format" },
      toml = { "taplo" },
      perl = { "perltidy" },

    },

    format_on_save = {
      timeout_ms = 500,
      lsp_fallback = true,
    },
  },
  config = function(_, opts)
    require("conform").setup(opts)
    vim.keymap.set({ "n", "v" }, "<leader>fm", function()
      require("conform").format({ async = true, lsp_fallback = true })
    end, { desc = "Format buffer" })
    print("conform.nvim configuration loaded.")
  end,
}
