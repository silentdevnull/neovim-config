
vim.opt.guicursor = ""

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false


-- remaps


vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.keymap.set("n","<leader>fo",vim.cmd.Ex)

-- remap esc key
vim.keymap.set("i", "<C-c>", "<Esc>")
vim.keymap.set("i", "<C-s>", "<Esc>:w<Enter>")


-- run shoutout / so command 

vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end)
