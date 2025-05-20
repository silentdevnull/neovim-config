-- ~/.config/nvim/lua/user/plugins/gitsigns.lua

return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" }, -- Load when opening a file in a git repo
  config = function()
    local gitsigns = require("gitsigns")

    gitsigns.setup({
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" }, -- Nerd Font icon
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
      signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
      numhl = false,     -- Toggle with `:Gitsigns toggle_numhl`
      linehl = false,    -- Toggle with `:Gitsigns toggle_linehl`
      word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
      watch_gitdir = {
        follow_files = true,
      },
      auto_attach = true,
      attach_to_untracked = true,
      current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
        delay = 1000,
        ignore_whitespace = false,
        virt_text_priority = 100,
      },
      current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
      sign_priority = 6,
      update_debounce = 100,
      status_formatter = nil,  -- Use default
      max_file_length = 40000, -- Disable if file is longer than this (in lines)
      preview_config = {
        border = "rounded",
        style = "minimal",
        relative = "cursor",
        row = 0,
        col = 1,
      },
      -- Keymaps are often set in the on_attach function or globally
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map("n", "]h", function() gs.next_hunk() end, { desc = "Next Hunk (Gitsigns)" })
        map("n", "[h", function() gs.prev_hunk() end, { desc = "Prev Hunk (Gitsigns)" })

        -- Actions
        map({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>", { desc = "Stage Hunk (Gitsigns)" })
        map({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>", { desc = "Reset Hunk (Gitsigns)" })
        map("n", "<leader>hS", gs.stage_buffer, { desc = "Stage Buffer (Gitsigns)" })
        map("n", "<leader>hu", gs.undo_stage_hunk, { desc = "Undo Stage Hunk (Gitsigns)" })
        map("n", "<leader>hR", gs.reset_buffer, { desc = "Reset Buffer (Gitsigns)" })
        map("n", "<leader>hp", gs.preview_hunk, { desc = "Preview Hunk (Gitsigns)" })
        map("n", "<leader>hb", function() gs.blame_line({ full = true }) end, { desc = "Blame Line (Gitsigns)" })
        map("n", "<leader>htb", gs.toggle_current_line_blame, { desc = "Toggle Blame (Gitsigns)" })
        map("n", "<leader>hd", gs.diffthis, { desc = "Diff This (Gitsigns)" })
        map("n", "<leader>hD", function() gs.diffthis("~") end, { desc = "Diff This ~ (Gitsigns)" })
        map("n", "<leader>htd", gs.toggle_deleted, { desc = "Toggle Deleted (Gitsigns)" })

        -- Text object
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Select Hunk (Gitsigns)" })
      end,
    })
    vim.notify("Gitsigns configured", vim.log.levels.INFO, { title = "Gitsigns" })
  end,
}
