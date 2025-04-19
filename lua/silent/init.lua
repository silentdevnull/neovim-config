require('silent.vim')
require('silent.lazy')
local path = vim.fn.stdpath("data") .. "/plugin/lazy.nvim"

if not vim.loop.fs_stat(path) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    path
  })
end
vim.opt.rtp:prepend(path)

require("lazy").setup({
    spec = "silent.lazy",
    change_detection = { notify = false }
})
