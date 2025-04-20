-- ~/.config/nvim/lua/plugins/completions.lua
return {

  -- Dependency: Provides LSP completion source for nvim-cmp
  {
    "hrsh7th/cmp-nvim-lsp",
    -- ADD THIS DEPENDENCY:
    dependencies = { "hrsh7th/nvim-cmp" },
  },

  -- Snippet Engine: LuaSnip
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
      -- LuaSnip itself doesn't directly depend on nvim-cmp
    },
    -- ... rest of LuaSnip config ...
    config = function()
      -- ... (LuaSnip setup) ...
    end,
  },

  -- Autocompletion Engine: nvim-cmp
  {
    "hrsh7th/nvim-cmp",
    -- This dependencies list should already be correct from before
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",     -- Depends on the LSP source
      "L3MON4D3/LuaSnip",         -- Depends on the snippet engine
      "saadparwaiz1/cmp_luasnip", -- Depends on the snippet source
    },
    config = function()
      -- ... (nvim-cmp setup) ...
    end,
  },

}
