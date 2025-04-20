local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- General Keymaps
keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlights" })

-- Insert Mode Keymaps (User specified)
keymap.set("i", "jl", "<Esc>", { desc = "Exit insert mode" })
keymap.set("i", "jlw", "<Esc>:w<CR>", { desc = "Save file" })
keymap.set("i", "jlwq", "<Esc>:wq<CR>", { desc = "Save and quit" })

-- Normal Mode
-- Better window navigation
keymap.set("n", "<C-h>", "<C-w>h", { desc = "Navigate window left" })
keymap.set("n", "<C-j>", "<C-w>j", { desc = "Navigate window down" })
keymap.set("n", "<C-k>", "<C-w>k", { desc = "Navigate window up" })
keymap.set("n", "<C-l>", "<C-w>l", { desc = "Navigate window right" })

-- Resize with arrows
keymap.set("n", "<C-Up>", ":resize -2<CR>", opts)
keymap.set("n", "<C-Down>", ":resize +2<CR>", opts)
keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Window Management (using leader)
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })

-- Tab Management
keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" })
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" })
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" })
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" })

-- Diagnostic keymaps (will be enhanced by LSP config)
keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
keymap.set("n", "<leader>de", vim.diagnostic.open_float, { desc = "Show diagnostic error messages" }) -- Changed keymap
keymap.set("n", "<leader>dq", vim.diagnostic.setloclist, { desc = "Open diagnostics list" }) -- Changed keymap

-- Move Lines
keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected line down" })
keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selected line up" })

-- Stay in indent mode
keymap.set("v", "<", "<gv", opts)
keymap.set("v", ">", ">gv", opts)

-- Paste without losing yanked item
keymap.set("x", "<leader>p", [["_dP]], { desc = "Paste without losing yank" })

-- Placeholders for plugin keymaps (defined in plugin files)
-- NeoTree: <leader>e, <leader>be, <leader>bf
-- Telescope: <leader>ff, <leader>fg, <leader>fb, <leader>fh, <leader>fo, <leader>gc, <leader>gs
-- Undotree: <leader>u
-- Conform: <leader>cf
