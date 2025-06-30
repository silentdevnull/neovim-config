local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    -- Import all files from the plugins directory
    { import = "user.plugins" },
  },
  -- Configure any other lazy.nvim options here
  checker = {
    enabled = true, -- Check for plugin updates
    notify = true, -- Notify when new updates are available
  },
  change_detection = {
    enabled = true,
    notify = true, -- Notify when changes are detected that require a restart
  },
})


