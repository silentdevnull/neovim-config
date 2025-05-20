-- ~/.config/nvim/lua/user/core/options.lua
local opt = vim.opt

opt.tabstop = 2      -- Number of visual spaces per TAB
opt.shiftwidth = 2   -- Number of spaces for autoindent
opt.softtabstop = 2  -- Number of spaces for TAB key, uses spaces/tabs per expandtab
opt.expandtab = true -- Use spaces instead of tabs
opt.autoindent = true
opt.smartindent = true
-- opt.cindent = true -- For C-like languages, but formatters usually handle this better

opt.termguicolors = true  -- Enable true color support
opt.nu = true             -- Show line numbers
opt.relativenumber = true -- Show relative line numbers
opt.signcolumn = "yes"    -- Always show the signcolumn

vim.notify("Core options set", vim.log.levels.INFO)
