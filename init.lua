vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Load core configurations
require("user.core.lazy")
require("user.core.keymaps")

local options_ok, _ = pcall(require, "user.core.options")
if not options_ok then
  vim.notify("Could not load user.core.options", vim.log.levels.WARN, { title = "Neovim Startup" })
end
