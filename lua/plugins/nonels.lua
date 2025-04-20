return {
  "nvimtools/none-ls.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    -- Your none-ls setup here
    require("null-ls").setup({
      -- sources = ...
    })
  end,
}


