local opt = vim.opt -- for conciseness

-- Appearance
opt.termguicolors = true -- Enable true color support
opt.nu = true -- Show line numbers
opt.relativenumber = true -- Show relative line numbers
opt.signcolumn = "yes" -- Always show the signcolumn

-- Behavior
opt.wrap = false -- Disable line wrapping
opt.clipboard = "unnamedplus" -- Use system clipboard
opt.mouse = "a" -- Enable mouse support
opt.ignorecase = true -- Ignore case when searching
opt.smartcase = true -- Don't ignore case if search pattern contains uppercase letters
opt.hlsearch = true -- Highlight search results
opt.incsearch = true -- Show search results incrementally
opt.undofile = true -- Persist undo history
opt.timeoutlen = 500 -- Time in milliseconds to wait for a mapped sequence
opt.updatetime = 250 -- Time in milliseconds for CursorHold event (LSP, git signs)
opt.completeopt = "menu,menuone,noselect" -- Completion options

-- Indentation
opt.tabstop = 2 -- Number of spaces a <Tab> counts for
opt.softtabstop = 2 -- Number of spaces inserted when pressing <Tab>
opt.shiftwidth = 2 -- Number of spaces for autoindent
opt.expandtab = true -- Use spaces instead of tabs
opt.smartindent = true -- Enable smart autoindenting
opt.autoindent = true -- Copy indent from current line when starting new line

-- UI
opt.scrolloff = 8 -- Keep 8 lines visible above/below cursor when scrolling
opt.sidescrolloff = 8 -- Keep 8 columns visible left/right of cursor when scrolling
opt.splitbelow = true -- Horizontal splits will automatically be below
opt.splitright = true -- Vertical splits will automatically be to the right

-- Disable built-in providers for better performance with plugins
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Set leader keys (before loading keymaps)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Turn off the annoying cursor shape change in insert mode
opt.guicursor = ""
