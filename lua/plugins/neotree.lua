return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    },
    cmd = "Neotree",
    keys = {
      { "<leader>e", function() require("neo-tree.command").execute({ toggle = true }) end, desc = "Explorer NeoTree" },
      { "<leader>be", function() require("neo-tree.command").execute({ source = "filesystem", focus = true }) end, desc = "Focus NeoTree Filesystem" },
      { "<leader>bf", function() require("neo-tree.command").execute({ reveal = true }) end, desc = "Reveal current file in NeoTree" },
      { "<leader>bg", function() require("neo-tree.command").execute({ source = "git_status", toggle = true }) end, desc = "Toggle NeoTree Git Status" },
      { "<leader>bb", function() require("neo-tree.command").execute({ source = "buffers", toggle = true }) end, desc = "Toggle NeoTree Buffers" },
    },
    opts = {
      close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
      popup_border_style = "rounded",
      enable_git_status = true,
      enable_diagnostics = true,
      open_files_do_not_replace_types = { "terminal", "trouble", "qf" },
      sort_case_insensitive = false,
      default_component_configs = {
        container = { enable_character_fade = true },
        indent = { indent_size = 2, padding = 1, with_markers = true, indent_marker = "│", last_indent_marker = "└", highlight = "NeoTreeIndentMarker", with_expanders = true, expander_collapsed = "", expander_expanded = "", expander_highlight = "NeoTreeExpander" },
        icon = { folder_closed = "", folder_open = "", folder_empty = "󰜌", default = "󰈔", highlight = "NeoTreeFileIcon" },
        modified = { symbol = "[+]", highlight = "NeoTreeModified" },
        name = { trailing_slash = false, use_git_status_colors = true, highlight = "NeoTreeFileName" },
        git_status = { symbols = { added = "✚", modified = "", deleted = "✖", renamed = "󰁕", untracked = "", ignored = "", unstaged = "󰄱", staged = "", conflict = "" } },
      },
      window = {
        position = "left",
        width = 30,
        mapping_options = {noremap = true, nowait = true},
        mappings = {
          ["<space>"] = false, -- Disable space for open files
          ["<cr>"] = "open",
          ["o"] = "open",
          ["<esc>"] = "cancel", -- close preview or floating neo-tree window
          ["P"] = { "toggle_preview", config = { use_float = true } }, -- Use floating preview
          ["l"] = "focus_preview",
          ["S"] = "open_split",
          ["s"] = "open_vsplit",
          -- ["S"] = "split_with_window_picker", -- Use if you prefer picker
          -- ["s"] = "vsplit_with_window_picker",
          ["t"] = "open_tabnew",
          ["w"] = "open_with_window_picker",
          ["C"] = "close_node",
          ["z"] = "close_all_nodes",
          ["Z"] = "expand_all_nodes",
          ["a"] = { "add", config = { show_path = "relative" } }, -- Add file relative to node
          ["A"] = "add_directory", -- Add directory relative to node
          ["d"] = "delete",
          ["r"] = "rename",
          ["y"] = "copy_to_clipboard",
          ["x"] = "cut_to_clipboard",
          ["p"] = "paste_from_clipboard",
          ["c"] = "copy", -- copy file/folder
          ["m"] = "move",
          ["q"] = "close_window",
          ["R"] = "refresh",
          ["?"] = "show_help",
          ["<"] = "prev_source",
          [">"] = "next_source",
          ["i"] = "show_file_details",
          ["H"] = "toggle_hidden", -- Toggle hidden files
          ["/"] = "fuzzy_finder", -- Fuzzy find within Neo-tree
          ["f"] = "filter_on_submit",
          ["<c-x>"] = "clear_filter",
          ["[g"] = "prev_git_modified",
          ["]g"] = "next_git_modified",
        },
      },
      nesting_rules = {},
      filesystem = {
        filtered_items = {
          visible = false, -- when true, they will just be displayed differently than normal items
          hide_dotfiles = false, -- Show dotfiles by default
          hide_gitignored = true,
          hide_hidden = true, -- only works on Windows for hidden files/directories
          hide_by_name = { "node_modules" },
          hide_by_pattern = { "*.meta", "*/src/*/tsconfig.json", ".git" },
          never_show = { ".DS_Store", "Thumbs.db" },
        },
        follow_current_file = { enabled = true, leave_dirs_open = false },
        group_empty_dirs = false,
        hijack_netrw_behavior = "open_default", -- or "disabled"
        use_libuv_file_watcher = true, -- Recommended for performance
      },
      buffers = {
        follow_current_file = { enabled = true, leave_dirs_open = false },
        group_empty_dirs = true,
        show_unloaded = true,
        window = { mappings = { ["bd"] = "buffer_delete", ["<bs>"] = "navigate_up", ["."] = "set_root" } },
      },
      git_status = {
        window = {
          position = "float", -- Show git status in a float window
          mappings = {
            ["A"] = "git_add_all", ["gu"] = "git_unstage_file", ["ga"] = "git_add_file",
            ["gr"] = "git_revert_file", ["gc"] = "git_commit", ["gp"] = "git_push",
            ["gg"] = "git_commit_and_push",
          },
        },
      },
    },
  },
}
