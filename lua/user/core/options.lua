local opt = vim.opt

opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true
opt.termguicolors = true
opt.nu = true
opt.relativenumber = true
opt.signcolumn = "yes"

vim.g.lazyvim_eslint_auto_format = true
vim.notify("Core Options set", vim.log.levels.INFO)
