-- ~/.config/nvim/lua/user/plugins/lualine.lua

return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" }, -- Optional
  config = function()
    local lualine = require("lualine")

    -- Custom function to show file encoding and format
    local custom_fileinfo = function()
      local enc = vim.bo.fenc ~= "" and vim.bo.fenc or vim.o.fenc -- Get buffer or global encoding
      local fmt = vim.bo.fileformat
      return string.format("%s[%s]", enc:upper(), fmt:upper())
    end

    lualine.setup({
      options = {
        icons_enabled = true,
        theme = "auto", -- Or your preferred nightfox variant e.g., 'nightfox', 'carbonfox'
        component_separators = { left = "", right = "" }, -- Nerd Font separators
        section_separators = { left = "", right = "" }, -- Nerd Font separators
        disabled_filetypes = {
          statusline = { "NvimTree", "neo-tree", "Outline" }, -- Disable for file explorer, etc.
          winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = false, -- Set to true if you want a single global statusline
        refresh = {
          statusline = 1000,
          tabline = 1000,
          winbar = 1000,
        },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = {
          {
            "filename",
            path = 1,             -- 0: Just filename, 1: Relative path, 2: Absolute path
            shorting_target = 40, -- Shorten filename if it's longer than this
          },
        },
        lualine_x = { custom_fileinfo, "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {}, -- You can configure a tabline here if you want
      winbar = {},
      inactive_winbar = {},
      extensions = { "neo-tree", "trouble" }, -- Integrate with other plugins
    })
    vim.notify("Lualine configured", vim.log.levels.INFO, { title = "Lualine" })
  end,
}
