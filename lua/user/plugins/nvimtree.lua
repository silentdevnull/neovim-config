-- File: ~/.config/nvim/lua/plugins/nvimtree.lua

return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("nvim-tree").setup {
      disable_netrw = true,
      hijack_netrw = true,
      sort_by = "case_sensitive",
      view = {
        width = 30,
        side = 'left', -- Ensure it opens on the left by default
      },
      renderer = {
        group_empty = true,
        icons = {
          git = {
            unstaged = "✗",
            staged = "✓",
            unmerged = "",
            renamed = "➜",
            untracked = "★",
            deleted = "🗑",
            ignored = "◌",
          },
        },
      },
      filters = {
        dotfiles = true,
      },
      actions = {
        open_file = {
          quit_on_open = false, -- Keep NvimTree open after selecting a file
          resize_window = true,
          window_picker = {
            enable = true,
          },
        },
      },
      -- If you want NvimTree to auto-open when you enter a directory with Git,
      -- or when diagnostics are present, you might use 'auto_open' related options:
      -- auto_reload_on_session_restore = true, -- If using session management
      -- auto_close = true, -- Automatically close if last window
      -- auto_open = {
      --   enable = true,
      --   -- Set this to true to open on Neovim startup if no files are opened,
      --   -- but the VimEnter autocmd handles this more explicitly below.
      --   -- open_on_setup = true,
      --   -- When to auto-open (e.g., if you only want it on specific conditions)
      --   -- current_project = true,
      --   -- git_open_on_setup = false, -- Open if a git project is found
      --   -- git_open_on_remote = false,
      --   -- git_open_no_arguments = true,
      --   -- diagnostis_open_on_setup = false,
      --   -- diagnostis_open_no_arguments = false,
      -- },
    }

    vim.keymap.set("n", "<leader>fe", ":NvimTreeToggle<CR>", { desc = "Toggle NvimTree" })

    vim.api.nvim_create_autocmd("VimEnter", {
      callback = function()
        if #vim.api.nvim_list_bufs() == 1 and vim.bo.buftype == "" and vim.fn.argc() == 0 then
          vim.cmd("NvimTreeOpen")
        end
      end,
      group = vim.api.nvim_create_augroup("NvimTreeAutoOpen", { clear = true }),
    })
  end,
}
