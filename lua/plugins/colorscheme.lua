return {
  {
    "EdenEast/nightfox.nvim",
    priority = 1000, -- Make sure it loads before other plugins start highlighting
    config = function()
      require("nightfox").setup({
        options = {
          compile_path = vim.fn.stdpath("cache") .. "/nightfox",
          compile_sync = false,
          styles = { comments = "italic", keywords = "bold", functions = "italic,bold" },
          inverse = { match_paren = false },
          modules = {
             -- Enable integrations if needed, e.g.:
             -- telescope = true,
             -- nvimtree = true,
             -- whichkey = true,
          },
        },
      })
      -- Load the colorscheme
      vim.cmd.colorscheme("carbonfox")

      -- Optional: Set background transparency
      -- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
      -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    end,
  },
}
