-- ~/.config/nvim/lua/user/core/keymaps.lua

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Disable 'q' from starting macro recording in Normal mode
map("n", "q", "<Nop>", { silent = true, desc = "Disable q for macro recording" })
map("n", "qq", "<Nop>", { silent = true, desc = "Disable qq recording" })

-- jlw to <Esc>:wa<CR> (Escape, Write All)
map("i", "jl", "<Esc>", { noremap = true, desc = "Exit insert mode" })
map("i", "jlw", "<Esc>:wall<CR>", { noremap = true, desc = "Save All (Insert Mode)" })
map("n", "jlw", ":wall<CR>", { noremap = true, silent = true, desc = "Save All (Normal Mode)" })

-- jlwq to <Esc>:wqa<CR> (Escape, Write All & Quit All)
map("i", "jlwq", "<Esc>:wqall<CR>", { noremap = true, desc = "Save All & Quit All (Insert Mode)" })
map("n", "jlwq", ":wqall<CR>", { noremap = true, silent = true, desc = "Save All & Quit All (Normal Mode)" })

-- Better window navigation
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)

-- Resize windows with arrow keys
map("n", "<C-Up>", ":resize +2<CR>", opts)
map("n", "<C-Down>", ":resize -2<CR>", opts)
map("n", "<C-Left>", ":horizontal resize -2<CR>", opts)
map("n", "<C-Right>", ":horizontal resize +2<CR>", opts)

-- Navigate buffers
map("n", "<S-l>", ":bnext<CR>", opts)
map("n", "<S-h>", ":bprevious<CR>", opts)

-- Clear search highlights
map("n", "<leader>nh", ":nohl<CR>", opts)

-- Close buffer
map("n", "<leader>q", ":bdelete<CR>", opts)
map("n", "<leader>Q", ":bdelete!<CR>", opts) -- Force close

-- Basic file operations
map("n", "<leader>w", ":write<CR>", opts)
map("n", "<leader>wq", ":wq<CR>", opts)

-- Example for a specific mode (e.g., visual mode)
-- Move selected lines up/down
map("v", "J", ":m '>+1<CR>gv=gv", opts)
map("v", "K", ":m '<-2<CR>gv=gv", opts)

-- Keep cursor in middle when jumping
map("n", "<C-d>", "<C-d>zz", opts)
map("n", "<C-u>", "<C-u>zz", opts)
map("n", "n", "nzz", opts)
map("n", "N", "Nzz", opts)

-- Paste without yanking
map("x", "<leader>p", '"_dP', opts)

-- Yank to system clipboard
map({ "n", "v" }, "<leader>y", '"+y', opts)
map("n", "<leader>Y", '"+Y', opts)



local themes_ok, themes = pcall(require, "user.utils.themes")
if themes_ok and themes then
  map("n", "<leader>ttn", themes.set_nightfox, { desc = "Set Nightfox Theme" })
  map("n", "<leader>ttd", themes.set_dayfox, { desc = "Set Dayfox Theme" })
  map("n", "<leader>tta", themes.set_dawnfox, { desc = "Set Dawnfox Theme" })
  map("n", "<leader>ttu", themes.set_duskfox, { desc = "Set Duskfox Theme" })
  map("n", "<leader>tto", themes.set_nordfox, { desc = "Set Nordfox Theme" })
  map("n", "<leader>ttc", themes.set_carbonfox, { desc = "Set Carbonfox Theme" })
  map("n", "<leader>ttt", themes.set_terafox, { desc = "Set Terafox Theme" })
  map("n", "<leader>ttl", themes.set_alphafox, { desc = "Set Alphafox Theme" })
  map("n", "<leader>tt]", function() themes.cycle_nightfox_theme("next") end, { desc = "Next Nightfox Theme" })
  map("n", "<leader>tt[", function() themes.cycle_nightfox_theme("prev") end, { desc = "Previous Nightfox Theme" })
else
  vim.notify("Failed to load theme switcher keymaps.", vim.log.levels.WARN)
end
vim.notify("Core keymaps loaded", vim.log.levels.INFO)
