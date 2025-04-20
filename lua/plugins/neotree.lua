-- ~/.config/nvim/lua/plugins/neo-tree.lua
return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  config = function()
    vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

    require("neo-tree").setup({
      -- ... other settings ...
      filesystem = {
        -- ... other filesystem settings ...
        follow_current_file = true,
        group_empty_dirs = true,
        -- CHANGE THIS LINE:
        hijack_netrw_behavior = "disabled", -- Set to disabled or remove the line entirely
        use_libuv_file_watcher = false,
        filtered_items = {
          visible = false,
          hide_dotfiles = false,
          hide_gitignored = true,
          hide_hidden = true,
          hide_by_name = {},
          hide_by_pattern = {},
          always_show = {},
          never_show = { ".DS_Store", "thumbs.db" },
          never_show_by_pattern = {},
        },
        -- ... other filesystem settings ...
      },
      -- ... other settings like window, buffers, git_status ...
    })

    -- Your keybindings (leader e, etc.) remain the same
    vim.keymap.set("n", "<leader>e", ":Neotree toggle<CR>", { desc = "Explorer NeoTree toggle" })
    vim.keymap.set("n", "<leader>f", ":Neotree focus<CR>", { desc = "Explorer NeoTree focus" })
    vim.keymap.set("n", "<leader>o", ":Neotree current<CR>", { desc = "Explorer NeoTree current" })
    vim.keymap.set("n", "<leader>b", ":Neotree buffers<CR>", { desc = "Explorer NeoTree buffers" })
    vim.keymap.set("n", "<leader>g", ":Neotree git_status<CR>", { desc = "Explorer NeoTree Git" })
  end,
}
