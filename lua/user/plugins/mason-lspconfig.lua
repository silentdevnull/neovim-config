return {
  "mason-org/mason-lspconfig.nvim",
  opts = {
    ensure_installed = {
      "lua_ls",
      "vimls",
      "gopls",
    },
    -- automatic_enable should likely be inside the lspconfig options if it's meant to enable specific servers.
    -- If it's a global setting for mason-lspconfig, it should be structured differently.
    -- Assuming `automatic_enable` is meant to control whether servers are automatically enabled by default,
    -- this might be a more appropriate place for it within the `opts` table for `mason-lspconfig`.
    automatic_enable = true, -- Or false, depending on your preference.
  },
  dependencies = {
    { "mason-org/mason.nvim", opts = {} }, -- Options for mason.nvim would go here
    "neovim/nvim-lspconfig",
  },
  -- The `DEFAULT_SETTINGS` table was placed incorrectly within the plugin specification.
  -- If `DEFAULT_SETTINGS` is meant to be a configuration table for this plugin,
  -- its contents should be integrated into the `opts` table, as I've done with `ensure_installed`
  -- and `automatic_enable`. If it's a separate utility table, it should be defined outside
  -- the plugin return statement, or inside `opts` if it's directly consumed by the plugin.
  -- I've removed the `local DEFAULT_SETTINGS = {}` block from here and integrated its
  -- relevant parts into the `opts` table above.
}
