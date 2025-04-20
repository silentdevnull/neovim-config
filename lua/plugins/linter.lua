return {
  {
    "mfussenegger/nvim-lint",
    event = { "BufWritePost", "BufReadPost", "InsertLeave" },
    config = function()
      local lint = require("lint")

      lint.linters_by_ft = {
        golang = { "golangci-lint" },
        javascript = { "eslint_d" }, typescript = { "eslint_d" },
        javascriptreact = { "eslint_d" }, typescriptreact = { "eslint_d" },
        css = { "stylelint" }, scss = { "stylelint" },
        php = { "phpstan" }, -- Requires phpstan setup/config
        ruby = { "rubocop" },
        kotlin = { "ktlint" },
        terraform = { "tflint" },
        sql = { "sqlfluff" }, -- Requires project-specific .sqlfluff config or args
        sh = { "shellcheck" },
        lua = { "luacheck" }, -- Add linter for lua
        python = { "flake8" }, -- Example: Add python linter
        -- Other languages often rely on LSP diagnostics (Rust, C#, Java, Perl, Swift)
      }

      -- Add luacheck to mason-tool-installer ensure_installed if not already there
      -- Add flake8 etc. as needed

      -- Create autocommand which carries out the actual linting
      local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = lint_augroup,
        callback = function(args)
           -- Use a timer to debounce linting for performance
           local timer = vim.uv.new_timer()
           if timer then -- Ensure timer was created
               timer:start(
                 200, -- Delay in ms before linting
                 0, -- Repeat interval (0 means no repeat)
                 vim.schedule_wrap(function()
                    -- Check if buffer still exists before linting
                    if vim.api.nvim_buf_is_valid(args.buf) then
                       lint.try_lint(nil, { bufnr = args.buf })
                    end
                 end)
               )
           else
               -- Fallback if timer fails (less ideal)
               lint.try_lint(nil, { bufnr = args.buf })
           end
        end,
      })

      -- Optional: Configure specific linters
      -- lint.linters.sqlfluff.args = { "--dialect", "postgres" }
    end,
  },
}
