local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Disable 'q' from starting macro recording in Normal mode
map("n", "q", "<Nop>", { silent = true, desc = "Disable q for macro recording" })
map("n", "qq", "<Nop>", { silent = true, desc = "Disable qq recording" })
map("n","<leader>q",":qa<CR>", { desc = "Quit All"})

-- jlw to <Esc>:wa<CR> (Escape, Write All)
map("i", "jl", "<Esc>", { noremap = true, desc = "Exit insert mode" })
map("i", "jlw", "<Esc>:wall<CR>", { noremap = true, desc = "Save All (Insert Mode)" })
map("n", "<leader>jlw", ":wall<CR>", { noremap = true, silent = true, desc = "Save All (Normal Mode)" })

vim.keymap.set('n', '<M-h>', '<C-w>h', { desc = 'Move focus to left window' })
vim.keymap.set('n', '<M-l>', '<C-w>l', { desc = 'Move focus to right window' })
vim.keymap.set('n', '<M-j>', '<C-w>j', { desc = 'Move focus to lower window' })
vim.keymap.set('n', '<M-k>', '<C-w>k', { desc = 'Move focus to upper window' })

-- Or using leader for window splits (some users prefer this)
vim.keymap.set('n', '<leader>wh', '<C-w>h', { desc = 'Move focus to left window' })
vim.keymap.set('n', '<leader>wl', '<C-w>l', { desc = 'Move focus to right window' })

map("n", "<leader>ttn",':colorscheme nightfox<CR>', { desc = "Set Nightfox Theme" })
map("n", "<leader>ttd",':colorscheme dayfox<CR>', { desc = "Set Dayfox Theme" })
map("n", "<leader>tta",':colorscheme dawnfox<CR>', { desc = "Set Dawnfox Theme" })
map("n", "<leader>ttu",':colorscheme duskfox<CR>', { desc = "Set Duskfox Theme" })
map("n", "<leader>tto",':colorscheme nordfox<CR>', { desc = "Set Nordfox Theme" })
map("n", "<leader>ttc",':colorscheme carbonfox<CR>', { desc = "Set Carbonfox Theme" })
map("n", "<leader>ttt",':colorscheme terafox<CR>', { desc = "Set Terafox Theme" })
map("n", "<leader>ttl",':colorscheme alphafox<CR>', { desc = "Set Alphafox Theme" })

