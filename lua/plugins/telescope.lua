return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = {
      "nvim-lua/plenary.nvim",
      -- Optional but recommended for performance
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      -- Icons
      { "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
    },
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")

      telescope.setup({
        defaults = {
          path_display = { "truncate" },
          mappings = {
            i = {
              ["<C-k>"] = actions.move_selection_previous, -- move to prev result
              ["<C-j>"] = actions.move_selection_next, -- move to next result
              ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
              ["<esc>"] = actions.close,
            },
            n = {
              ["<C-k>"] = actions.move_selection_previous,
              ["<C-j>"] = actions.move_selection_next,
              ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
              ["<esc>"] = actions.close,
            }
          },
          layout_strategy = "horizontal",
          layout_config = {
             horizontal = {
                prompt_position = "top",
                preview_width = 0.55,
             },
             vertical = { mirror = false },
             width = 0.87,
             height = 0.80,
             preview_cutoff = 120,
          },
          sorting_strategy = "ascending",
          winblend = 0,
          border = {},
          borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
          color_devicons = true,
          use_less = true,
          set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
          file_previewer = require("telescope.previewers").vim_buffer_cat.new,
          grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
          qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
        },
        pickers = {
          find_files = {
             -- find_command = { "fd", "--type", "f", "--hidden", "--exclude", ".git" }, -- Requires fd
          },
          live_grep = {
             -- Additional grep configuration if needed
          },
          buffers = {
             sort_mru = true,
             ignore_current_buffer = true,
          },
        },
        extensions = {
          fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = "smart_case", -- or "ignore_case" or "respect_case"
          },
          -- Add other extensions here if you install them (e.g., themes, projects)
        },
      })

      -- Load extensions
      pcall(telescope.load_extension, "fzf")

      -- Keymaps (using leader)
      local keymap_tele = vim.keymap
      keymap_tele.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
      keymap_tele.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Live grep" })
      keymap_tele.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Find buffers" })
      keymap_tele.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Find help tags" })
      keymap_tele.set("n", "<leader>fo", "<cmd>Telescope oldfiles<cr>", { desc = "Find recent files" })
      keymap_tele.set("n", "<leader>gc", "<cmd>Telescope git_commits<cr>", { desc = "Search Git commits" })
      keymap_tele.set("n", "<leader>gs", "<cmd>Telescope git_status<cr>", { desc = "Git status" })
      keymap_tele.set("n", "<leader>fc", "<cmd>Telescope commands<cr>", { desc = "Find commands" })
      keymap_tele.set("n", "<leader>fk", "<cmd>Telescope keymaps<cr>", { desc = "Find keymaps" })
    end,
  },
}
