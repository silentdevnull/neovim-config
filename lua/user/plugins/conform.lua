--return {
--  "stevearc/conform.nvim",
--  optional = true,
--  opts = {
--    formatters_by_ft = {
    --  go = { "goimports", "gofumpt" },
  --  },
--  },
--}
--
-- lua/plugins/conform.lua (or wherever you manage your plugins)
return {
  "stevearc/conform.nvim",
  optional = true,
  ---@param opts ConformOpts
  opts = function(_, opts)
    -- Initialize formatters_by_ft if it doesn't exist
    opts.formatters_by_ft = opts.formatters_by_ft or {}

    -- Existing Go formatters
    opts.formatters_by_ft.go = { "goimports", "gofumpt" }

    -- Define supported file types for Prettier
    local supported = {
      "html",
      "css",
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
      "json",
      "yaml",
      "markdown",
      "graphql",
      "vue",
      "svelte",
      "scss",
      "less",
      "jsonc",
    }

    -- Add Prettier to supported file types
    for _, ft in ipairs(supported) do
      opts.formatters_by_ft[ft] = opts.formatters_by_ft[ft] or {}
      table.insert(opts.formatters_by_ft[ft], "prettier")
    end

    -- Configure Prettier formatter
    opts.formatters = opts.formatters or {}
    opts.formatters.prettier = {
      condition = function(_, ctx)
        -- Assuming M is a module that provides has_parser and has_config functions.
        -- You'll need to define or import M based on your setup.
        -- For example, if these are helper functions within your conform setup:
        local M = {
          has_parser = function(ctx)
            -- Placeholder: Implement your logic to check if a parser exists for the filetype
            return true
          end,
          has_config = function(ctx)
            -- Placeholder: Implement your logic to check for a prettier config file
            return true
          end,
        }
        return M.has_parser(ctx) and (vim.g.lazyvim_prettier_needs_config ~= true or M.has_config(ctx))
      end,
    }
  end,
}
