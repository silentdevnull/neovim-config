return {
  "numToStr/Comment.nvim",
  event = "VeryLazy", -- Or load on specific filetypes or BufRead
  config = function()
    require("Comment").setup({
      -- Add any custom configuration here
      -- For example, to add custom comment strings for a filetype:
      -- pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
      -- If you use 'JoosepAlviste/nvim-ts-context-commentstring' for better context comments
    })
    vim.notify("Comment.nvim configured", vim.log.levels.INFO, { title = "Comment" })

    -- Default keymaps are usually gcc for line comment and gc + motion for block.
    -- You can set them explicitly if you prefer:
    -- local map = vim.keymap.set
    -- map("n", "<leader>/", function() require("Comment.api").toggle.linewise.current() end, { desc = "Toggle Comment Line" })
    -- map("v", "<leader>/", function() require("Comment.api").toggle.linewise(vim.fn.visualmode()) end, { desc = "Toggle Comment Selection" })
  end,
}
