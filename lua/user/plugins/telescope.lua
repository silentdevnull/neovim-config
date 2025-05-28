-- In your plugins.lua or similar file
return {
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons', -- For file icons
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
      'nvim-telescope/telescope-file-browser.nvim',
    },
    config = function()
      local telescope = require('telescope')
      local actions = require('telescope.actions')

      telescope.setup({
        defaults = {
          -- Your general Telescope defaults (can be omitted if already global)
          -- ... (e.g., prompt_prefix, selection_caret, etc. from previous answer)
          mappings = {
            i = {
              -- ... common Telescope mappings
            },
            n = {
              -- ... common Telescope mappings
            },
          },
        },
        pickers = {
          -- Your specific picker configurations (e.g., find_files)
        },
        extensions = {
          file_browser = {
            -- Key for a more "tree-like" experience:
            theme = "dropdown",  -- "ivy" or "dropdown" can work well for this
            hijack_netrw = true,
            hidden = true,       -- Show hidden files by default
            grouped = true,      -- Group directories and files
            files_on_top = true, -- Show files above directories
            -- This function allows you to customize commands for file_browser
            -- This is where you can add things like "create file/dir" or "delete"
            -- for the file_browser
            on_attach = function(bufnr)
              -- Common mappings for file_browser when it's open
              vim.keymap.set('n', 'h', actions.goto_parent_dir, { buffer = bufnr })
              vim.keymap.set('n', 'l', actions.change_working_dir, { buffer = bufnr })
              vim.keymap.set('n', '.', actions.toggle_hidden, { buffer = bufnr, desc = "Toggle hidden files" })
              vim.keymap.set('n', '-', actions.goto_parent_dir, { buffer = bufnr })
              vim.keymap.set('n', 'q', actions.close, { buffer = bufnr })
              vim.keymap.set('i', '<C-c>', actions.close, { buffer = bufnr })

              -- Custom actions for file_browser
              vim.keymap.set('n', 'a', function()
                -- Example: Create a new file
                vim.fn.input("New file name: ")
                -- You'd need to expand this to actually create the file
                -- based on the current directory.
                -- For a real file system operation, you'd call out to Lua's io.open or vim.fn.mkdir/writefile
              end, { buffer = bufnr, desc = "Create new file" })

              vim.keymap.set('n', 'A', function()
                -- Example: Create a new directory
                vim.fn.input("New directory name: ")
              end, { buffer = bufnr, desc = "Create new directory" })

              -- To delete files, you'd typically select them and then have a delete action
              -- e.g., 'd' to delete selected file/directory after confirmation
              -- This requires a bit more logic than a simple keymap.
            end,
          },
        },
      })

      -- Load extensions
      telescope.load_extension('fzf')
      telescope.load_extension('file_browser')

      -- Keymaps for Telescope File Browser
      local keymap = vim.keymap.set
      local opts = { noremap = true, silent = true }

      -- Open file browser in current directory
      keymap("n", "<leader>fe", function()
        telescope.extensions.file_browser.file_browser({
          path = vim.fn.expand("%:p:h"), -- Start in current file's directory
          -- Set to 'true' to jump to selected file after opening file browser
          -- Also, you might want a different 'initial_mode' ('normal' or 'insert')
          initial_mode = "normal",
        })
      end, opts)

      -- Open file browser from root of project
      keymap("n", "<leader>fr", function()
        telescope.extensions.file_browser.file_browser({
          path = vim.fn.getcwd(), -- Start in current working directory
          initial_mode = "normal",
        })
      end, opts)

      -- Open file browser, specifically targeting a directory
      keymap("n", "<leader>fd", function()
        telescope.extensions.file_browser.file_browser({
          path = "%:p:h",
          select_buffer = true -- Highlight current file if it's in the list
        })
      end, opts)

      -- You can also bind directly to the command:
      -- keymap("n", "<leader>fb", "<cmd>Telescope file_browser<CR>", opts)
    end,
  },
}
