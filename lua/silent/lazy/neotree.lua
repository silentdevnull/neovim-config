return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- Optional, for file icons
      "MunifTanjim/nui.nvim",
      -- You might need other dependencies depending on the features you enable
      -- "3rd/image.nvim", -- Optional, for image previews
    },
    cmd = "Neotree", -- Load when running the Neotree command
    keys = {
      -- Define keymaps to interact with Neo-tree
      -- Toggle file explorer
      {
        "<leader>e", -- Or use "<C-n>" or your preferred keymap
        function()
          require("neo-tree.command").execute({ toggle = true, dir = vim.uv.cwd() })
        end,
        desc = "Explorer NeoTree (Current Dir)",
      },
      -- Reveal current file in Neo-tree
      {
        "<leader>E", -- Or use <leader>fe
        function()
          require("neo-tree.command").execute({ reveal = true })
        end,
        desc = "Explorer NeoTree (Reveal File)",
      },
      -- Open Neo-tree focusing on the git status source
      -- {
      --   "<leader>gs", -- Example keymap
      --   function()
      --     require("neo-tree.command").execute({ source = "git_status", toggle = true })
      --   end,
      --   desc = "Explorer NeoTree (Git Status)",
      -- },
      -- Open Neo-tree focusing on the buffers source
      -- {
      --   "<leader>gb", -- Example keymap
      --   function()
      --     require("neo-tree.command").execute({ source = "buffers", toggle = true })
      --   end,
      --   desc = "Explorer NeoTree (Buffers)",
      -- },
    },
    opts = {
      -- === Configuration Options ===
      close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
      popup_border_style = "rounded", -- Border style: "rounded", "sharp", "double", "single"
      enable_git_status = true, -- Show git status indicators
      enable_diagnostics = true, -- Show diagnostic indicators (errors, warnings)
      enable_modified_markers = true, -- Show markers for modified files

      -- Sort order for files and directories
      sort_case_insensitive = true,
      sort_function = nil, -- Use default sorting

      -- Default component configurations (icons, indentation, etc.)
      default_component_configs = {
        container = {
          enable_character_fade = true,
        },
        indent = {
          indent_size = 2,
          padding = 1, -- Padding left of the tree items
          -- indent_marker = "│",
          -- last_indent_marker = "└",
          -- with_markers = true, -- Show indentation markers
          -- with_expanders = true, -- Show expanders icons (requires Nerd Font)
          -- expander_collapsed = "▶",
          -- expander_expanded = "▼",
          -- expander_highlight = "NeoTreeExpander",
        },
        icon = {
          folder_closed = "", -- Requires Nerd Font
          folder_open = "", -- Requires Nerd Font
          folder_empty = "󰜌", -- Requires Nerd Font
          -- Set default_icon = "…" if you don't want icons for unrecognized files
          default_icon = "󰈚", -- Requires Nerd Font
        },
        modified = {
          symbol = "●", -- Marker for modified files
          highlight = "NeoTreeModified",
        },
        name = {
          trailing_slash = false,
          use_git_status_colors = true,
          highlight = "NeoTreeFileName",
        },
        git_status = {
          symbols = {
            -- Requires Nerd Font
            added = "✚",
            deleted = "✖",
            modified = "",
            renamed = "➜",
            untracked = "★",
            ignored = "◌",
            unstaged = "✗",
            staged = "✓",
            conflict = "",
          },
        },
        -- diagnostics = { ... } -- Configure diagnostic symbols if needed
      },

      -- Window settings (position, width, etc.)
      window = {
        position = "left", -- "left", "right", "float", "current"
        width = 35,
        mapping_options = {
          noremap = true,
          nowait = true,
        },
        -- For float position
        -- float = {
        --   relative = "window", -- "editor" or "window"
        --   position = "50%", -- Adjust as needed
        --   size = {
        --     width = "80%",
        --     height = "70%",
        --   },
        -- },
      },

      -- Filesystem source specific settings
      filesystem = {
        filtered_items = {
          visible = false, -- Show hidden files by default?
          hide_dotfiles = false, -- If visible is false, hide files starting with '.'
          hide_gitignored = true, -- Hide files listed in .gitignore
          hide_hidden = true, -- Hide system hidden files (requires fd command)
          hide_by_name = {
            ".git",
            ".DS_Store",
            "thumbs.db",
            --"node_modules", -- Often useful to uncomment this
          },
          never_show = { -- Remains hidden even if visible is toggled to true
            -- ".DS_Store",
            -- "thumbs.db"
          },
          never_show_by_pattern = { -- Uses Lua patterns
            -- ".null-ls.*"
          },
        },
        follow_current_file = {
          enabled = true, -- Reveal the buffer's file in the tree when switching buffers
          leave_dirs_open = false, -- Keep dirs open that were opened by follow_current_file
        },
        group_empty_dirs = false, -- Group empty directories when sorting
        hijack_netrw_behavior = "open_current", -- "open_default", "open_current", "disabled"
        use_libuv_file_watcher = true, -- Use faster libuv watcher if available
      },

      -- Other sources (uncomment and configure if needed)
      -- buffers = {
      --   follow_current_file = { enabled = true },
      --   group_empty_dirs = true,
      -- },
      -- git_status = {
      --   symbols = { ... } -- Same symbols as default_component_configs.git_status
      -- },

      -- Add event handlers if needed
      -- event_handlers = {
      --   {
      --     event = "file_opened",
      --     handler = function(file_path)
      --       -- Automatically close Neo-tree after opening a file
      --       require("neo-tree.command").execute({ action = "close" })
      --     end
      --   },
      -- },
    },
  },
}

