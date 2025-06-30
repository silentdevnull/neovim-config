return {
  "mfussenegger/nvim-lint",
  opts = {
    linters_by_ft = {
      go = { "golangci-lint" },
      typescript = { "eslint_d" },
      typescriptreact = { "eslint_d" },
      javascript = { "eslint_d" },
      javascriptreact = { "eslint_d" },
    },
  },
  config = function(_, opts)
    require("lint").setup(opts)
    vim.api.nvim_create_autocmd({ "BufWritePost" }, {
      callback = function()
        require("lint").try_lint()
      end,
    })
  end,
}
