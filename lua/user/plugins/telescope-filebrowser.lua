return {
  "nvim-telescope/telescope-file-browser.nvim",
  dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")


    vim.keymap.set("n", "<leader>fe", function()
      telescope.extensions.file_browser.file_browser({
        attach_mappings = function(prompt_bufnr, map)
          -- The error occurs on the next line if to_normal_mode is missing
          actions.to_normal_mode(prompt_bufnr)
          return true
        end,
      })
    end, { desc = "File Browser (Telescope) [Normal Mode]" })
  end,
}
