vim.opt.guicursor = ""
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.timeoutlen = 500
-- Remapping

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- keymap

-- vim.keymap.set("n", "<leader>fo", vim.cmd.Ex)
-- vim.keymap.set("i", "<C-w>", "<Esc>:w<Enter>")

vim.keymap.set("i", "jl", "<Esc>", { noremap = true })
