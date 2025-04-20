return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require("lint")
    lint.linters_by_ft = {
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      typescriptreact = { "eslint_d" },
      sh = { "shellcheck" },
      bash = { "shellcheck" },
      python = { "ruff" },
      lua = { "luacheck" },
      go = { "golangci-lint" },
      kotlin = { "ktlint" },
      yaml = { "yamllint" },
      terraform = { "tflint" },
      perl = { "perlcritic" },
    }

    local function safe_lint()
      local current_ft = vim.bo.filetype
      local linters = lint.linters_by_ft[current_ft] or {}
      local has_linters = false
      for _, linter_name in ipairs(linters) do
        local linter = lint.linters[linter_name]
        if linter and vim.fn.executable(linter.cmd) == 1 then
          has_linters = true
          break
        end
      end
      if has_linters then
        lint.try_lint(nil, { ignore_errors = true })
      end
    end

    local debounce_ms = 250
    local timer = vim.loop.new_timer()
    local function debounced_lint()
      if timer:is_active() then
        timer:stop()
      end
      timer:start(debounce_ms, 0, vim.schedule_wrap(function()
        safe_lint()
      end))
    end
    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
    vim.api.nvim_create_autocmd({ "BufWritePost", "TextChanged" }, {
      group = lint_augroup,
      callback = function()
        debounced_lint()
      end,
    })
    vim.api.nvim_create_user_command("Lint", function()
      safe_lint()
    end, { desc = "Run linters for current buffer" })
    vim.keymap.set("n", "<leader>ll", function()
      safe_lint()
    end, { desc = "Run Linters" })
    vim.schedule(function()
      safe_lint()
    end)
    print("nvim-lint configuration loaded with safety checks for missing linters.")
  end,
}
