-- ~/.config/nvim/lua/user/plugins/todo_comments.lua
return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  event = "BufReadPost", -- Load after a buffer is read
  config = function()
    require("todo-comments").setup({
      -- signs = true, -- show icons in the signs column
      -- sign_priority = 8, -- sign priority
      -- keywords = { ... } -- customize keywords
      -- highlight = { ... } -- customize highlight groups
      -- search = { ... } -- customize search behavior
    })
    vim.notify("todo-comments.nvim configured", vim.log.levels.INFO, { title = "TodoComments" })

    -- Optional: Keymaps for Telescope integration (if you want to search todos)
    local map = vim.keymap.set
    map("n", "<leader>ft", "<cmd>TodoTelescope<CR>", { desc = "Find Todos (Telescope)" })
    map("n", "<leader>fT", "<cmd>TodoTelescope keywords=TODO,FIX,HACK<CR>", { desc = "Find Specific Todos" })
  end,
}
