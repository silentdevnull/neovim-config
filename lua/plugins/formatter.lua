return {
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" }, -- Format on save
    cmd = { "ConformInfo" },
    keys = {
      { "<leader>cf", function() require("conform").format({ async = true, lsp_fallback = true }) end, mode = { "n", "v" }, desc = "Format buffer/selection" },
    },
    opts = {
      -- Define formatters for each file type
      formatters_by_ft = {
        lua = { "stylua" },
        go = { "gofmt", "goimports" },
        javascript = { "prettier" }, typescript = { "prettier" },
        javascriptreact = { "prettier" }, typescriptreact = { "prettier" },
        css = { "prettier" }, scss = { "prettier" }, html = { "prettier" },
        json = { "prettier" }, yaml = { "prettier" }, markdown = { "prettier" },
        rust = { "rustfmt" }, php = { "php-cs-fixer" }, java = { "google-java-format" },
        cs = { "csharpier" }, ruby = { "rubocop" }, perl = { "perltidy" },
        kotlin = { "ktlint" }, swift = { "swiftformat" },
        terraform = { "terraform_fmt" }, toml = { "taplo" }, xml = { "xmlformat" },
        sql = { "sqlfluff" }, -- Requires project-specific .sqlfluff config or args
        sh = { "shfmt" },
        -- Add other filetypes and formatters as needed
        -- Example: python = { "black" }
      },
      -- Set up format-on-save
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true, -- Fallback to LSP formatting if conform formatter fails or is not found
      },
      -- Optional: Configure specific formatters
      formatters = {
        shfmt = {
          prepend_args = { "-i", "2" }, -- Indent by 2 spaces
        },
        sqlfluff = {
          -- Specify dialect via .sqlfluff config file in project is recommended
          -- Or uncomment and set args:
          -- args = { "--dialect", "postgres" },
        },
        -- Add custom configurations for other formatters if needed
        -- prettier = {
        --   prepend_args = { "--config", "/path/to/.prettierrc" }
        -- }
      },
    },
  },
}
