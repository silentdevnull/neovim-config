return {
  "akinsho/toggleterm.nvim",
  version = "*", -- or a specific tag
  config = function()
    require("toggleterm").setup({
      size = function(term)
        if term.direction == "horizontal" then
          return 15
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.4
        end
        return 20               -- Default for float
      end,
      open_mapping = [[<c-\>]], -- Or <c-t> or whatever you prefer
      hide_numbers = true,
      shade_filetypes = {},
      shade_terminals = true,
      shading_factor = 2,
      start_in_insert = true,
      insert_mappings = true,
      persist_size = true,
      direction = "float", -- 'float', 'vertical', 'horizontal', 'tab'
      close_on_exit = true,
      shell = vim.o.shell,
      float_opts = {
        border = "rounded",
        winblend = 0,
        highlights = {
          border = "Normal",
          background = "Normal",
        },
      },
    })
    vim.notify("Toggleterm configured", vim.log.levels.INFO, { title = "Toggleterm" })

    -- Custom keymaps for specific terminals
    local map = vim.keymap.set
    function _G.set_terminal_keymaps()
      local opts = { buffer = 0 }
      map("t", "<esc>", [[<C-\><C-n>]], opts) -- Exit terminal mode
      map("t", "jk", [[<C-\><C-n>]], opts)    -- Example: jk to exit
      map("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
      map("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
      map("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
      map("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
    end

    -- Open a terminal on Ctrl+/ (or your open_mapping)
    -- vim.keymap.set("n", "<C-/>", "<cmd>ToggleTerm<CR>", {noremap = true, silent = true, desc = "Toggle Terminal"})

    -- Example: LazyGit terminal
    local Terminal = require("toggleterm.terminal").Terminal
    local lazygit = Terminal:new({ cmd = "lazygit", hidden = true, direction = "float" })
    function _LAZYGIT_TOGGLE() lazygit:toggle() end

    map("n", "<leader>gg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", { desc = "Toggle LazyGit" })

    -- Example: Wrangler Dev
    local wrangler_dev = Terminal:new({ cmd = "wrangler dev", hidden = true, direction = "float", close_on_exit = false })
    function _WRANGLER_DEV_TOGGLE() wrangler_dev:toggle() end

    map("n", "<leader>wd", "<cmd>lua _WRANGLER_DEV_TOGGLE()<CR>", { desc = "Toggle Wrangler Dev" })

    -- Example: Wrangler Publish
    local wrangler_pub = Terminal:new({
      cmd = "wrangler publish",
      hidden = true,
      direction = "float",
      on_close = function(term)
        vim.cmd("echo 'Wrangler publish finished. Exit code: " .. term.exit_code .. "'")
      end
    })
    function _WRANGLER_PUB() wrangler_pub:spawn() end -- Use spawn to run once

    map("n", "<leader>wp", "<cmd>lua _WRANGLER_PUB()<CR>", { desc = "Wrangler Publish" })
  end,
}
