return {
  "nvim-telescope/telescope.nvim",
  -- No tag, lazy.nvim will get a recent version
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local telescope = require("telescope")
    local builtin = require("telescope.builtin")
    local actions = require("telescope.actions") -- Require actions here for general use

    -- General Telescope keymaps
    vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })
    vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live Grep" })
    vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find Buffers" })
    vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help Tags" })

    telescope.setup({
      defaults = {
        -- It's good practice to ensure Esc in insert mode goes to normal mode
        -- and Esc in normal mode closes the picker.
        mappings = {
          i = {
            ["<C-c>"] = actions.close, -- Close picker
            -- You might want to add <C-j>, <C-k> for navigation in insert mode
            -- ["<C-j>"] = actions.move_selection_next,
            -- ["<C-k>"] = actions.move_selection_previous,
          },
          n = {
            ["<Esc>"] = actions.close, -- Close picker
            ["q"] = actions.close,     -- Close picker
          },
        },
      },
      pickers = {
        -- Configure pickers if needed
      },
      extensions = {
        file_browser = {
          hijack_netrw = true,
          -- path = "%:p:h", -- Consider setting a default path if desired
          -- hidden = true,
          mappings = {
            ["n"] = { -- Mappings for file_browser NORMAL mode
              ["n"] = function(prompt_bufnr)
                -- Use a distinct local variable for actions if preferred,
                -- or rely on the 'actions' from the outer scope.
                local fb_actions = require("telescope.actions")
                local current_picker =
                    require("telescope.actions.state").get_current_picker(
                      prompt_bufnr
                    )
                local current_dir = current_picker.cwd
                if current_dir == nil or current_dir == "" then
                  current_dir = vim.fn.getcwd()
                end

                fb_actions.close(prompt_bufnr) -- Close telescope

                vim.ui.input({ prompt = "New file name: " }, function(
                    filename
                )
                  if filename == nil or filename == "" then
                    vim.notify("File creation cancelled.", vim.log.levels.INFO)
                    return
                  end
                  local new_file_path = vim.fs.joinpath(current_dir, filename)
                  if vim.fn.filereadable(new_file_path) == 1 then
                    vim.notify(
                      "File already exists: " .. new_file_path,
                      vim.log.levels.WARN
                    )
                    vim.cmd("edit " .. vim.fn.fnameescape(new_file_path))
                  else
                    vim.cmd("edit " .. vim.fn.fnameescape(new_file_path))
                    vim.notify(
                      "Opened new file: " .. new_file_path,
                      vim.log.levels.INFO
                    )
                  end
                end)
              end,
              -- Add other file_browser normal mode mappings here if needed
            },
            ["i"] = {
              -- Add file_browser insert mode mappings here if needed
            },
          },
        },
      },
    })

    -- IMPORTANT: Load extensions AFTER telescope.setup() has run.
    -- This ensures that any default configurations for the extension
    -- (like the mappings we defined above) are registered with Telescope
    -- before the extension itself is fully loaded.
    pcall(telescope.load_extension, "file_browser")
  end,
}
