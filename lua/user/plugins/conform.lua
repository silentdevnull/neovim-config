-- ~/.config/nvim/lua/user/plugins/conform.lua

return {
  "stevearc/conform.nvim",
  lazy = false, -- As per your previous request
  keys = {
    {
      "<leader>cf",
      function()
        require("conform").format({ async = true, lsp_fallback = true })
      end,
      mode = { "n", "v" },
      desc = "Format buffer (Conform)",
    },
  },
  config = function()
    local conform = require("conform")

    local desired_formatters_list = {
      { name = "stylua",       exe = "stylua",           ft = { "lua" } },
      { name = "prettier",     exe = "prettier",         ft = { "javascript", "typescript", "javascriptreact", "typescriptreact", "vue", "css", "scss", "less", "html", "json", "jsonc", "yaml", "markdown", "graphql", "toml" } },
      { name = "shfmt",        exe = "shfmt",            ft = { "sh", "bash", "zsh" } },
      { name = "ruff_format",  exe = "ruff",             ft = { "python" } },
      { name = "black",        exe = "black",            ft = { "python" } },
      { name = "isort",        exe = "isort",            ft = { "python" } }, -- Primarily for imports
      { name = "goimports",    exe = "goimports",        ft = { "go" } },     -- gofmt is usually covered
      { name = "clang_format", exe = "clang-format",     ft = { "c", "cpp", "objc", "objcpp", "cuda", "proto" } },
      { name = "rustfmt",      exe = "rustfmt",          ft = { "rust" } },
      { name = "zigfmt",       exe = "zig",              ft = { "zig" } }, -- Added zigfmt from your log
      { name = "csharpier",    exe = "dotnet-csharpier", ft = { "cs" } },  -- Added csharpier
      { name = "sqlfluff",     exe = "sqlfluff",         ft = { "sql" } },
    }

    local formatters_by_ft = {}
    local successfully_loaded_formatters_names = {}
    local missing_formatters_names = {}

    for _, formatter_config in ipairs(desired_formatters_list) do
      local formatter_name = formatter_config.name
      local executable_name = formatter_config.exe
      local filetypes = formatter_config.ft

      if vim.fn.executable(executable_name) == 1 then
        for _, ft_name in ipairs(filetypes) do
          formatters_by_ft[ft_name] = formatters_by_ft[ft_name] or {}
          table.insert(formatters_by_ft[ft_name], formatter_name)
        end
        if not vim.tbl_contains(successfully_loaded_formatters_names, formatter_name) then
          table.insert(successfully_loaded_formatters_names, formatter_name)
        end
      else
        local missing_entry = formatter_name .. " (needs '" .. executable_name .. "')"
        if not vim.tbl_contains(missing_formatters_names, missing_entry) then
          table.insert(missing_formatters_names, missing_entry)
        end
      end
    end

    conform.setup({
      formatters_by_ft = formatters_by_ft,
      format_on_save = {
        timeout_ms = 1000,
        lsp_fallback = true,
      },
      -- Define arguments for specific formatters to control indentation
      formatters = {
        prettier = {
          prepend_args = { "--tab-width", "2", "--use-tabs", "false" },
        },
        stylua = {
          prepend_args = { "--indent-type", "Spaces", "--indent-width", "2" },
        },
        shfmt = {
          prepend_args = { "-i", "2" }, -- Indent with 2 spaces
        },
        clang_format = {
          -- clang-format usually relies on a .clang-format file.
          -- To pass style options directly (less common for complex styles):
          -- prepend_args = {"-style={IndentWidth: 2, UseTab: Never}"},
          -- It's better to use a .clang-format file in your project.
        },
        rustfmt = {
          prepend_args = { "--config", "tab_spaces=2,use_tabs=Never" },
        },
        zigfmt = {
          -- zig fmt uses --stdin and outputs to stdout.
          -- Indentation is usually fixed (4 spaces) and not configurable via CLI.
          -- Ensure your editor settings match if you want visual consistency.
        },
        csharpier = {
          -- CSharpier is highly opinionated. Indent size is typically not configurable via CLI.
          -- It might respect .editorconfig `indent_size`.
        },
        sqlfluff = {
          prepend_args = { "format", "--dialect", "ansi" }, -- Specify dialect or let it auto-detect
          -- Or use a .sqlfluff config file in your project
        },
        -- Black and Ruff (format) are highly opinionated and usually enforce 4 spaces.
        -- Their configuration for this is typically done via pyproject.toml.
      },
      log_level = vim.log.levels.ERROR,
    })

    -- Notification logic (same as before)
    if #successfully_loaded_formatters_names > 0 then
      vim.notify(
        "Conform: Configured: " .. table.concat(successfully_loaded_formatters_names, ", ") .. ".",
        vim.log.levels.INFO, { title = "Conform Setup" })
      if #missing_formatters_names > 0 then
        vim.notify(
          "Conform: (Note: Missing: " .. table.concat(missing_formatters_names, ", ") .. ")",
          vim.log.levels.DEBUG, { title = "Conform Setup" })
      end
    else
      local checked_for_message = ""
      if #missing_formatters_names > 0 then
        checked_for_message = " (Checked for: " ..
            table.concat(missing_formatters_names, ", ") .. ")"
      end
      vim.notify("Conform: No desired formatters found." .. checked_for_message, vim.log.levels.WARN,
        { title = "Conform Setup" })
    end
    vim.notify("Conform.nvim setup complete (loaded at startup).", vim.log.levels.INFO,
      { title = "Conform Setup" })
  end,
}
