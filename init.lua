vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("user.core.lazy")
require("user.core.keymaps")
require("user.core.options")

local swap_dir = vim.fn.stdpath('data') .. '/swap'
vim.fn.mkdir(swap_dir, 'p') -- Create directory if it doesn't exist

vim.opt.directory = swap_dir
