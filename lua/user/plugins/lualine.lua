-- ~/.config/nvim/lua/user/plugins/lualine.lua

return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" }, 
  config = function()
    local lualine = require("lualine")

    local custom_fileinfo = function()
      local enc = vim.bo.fenc ~= "" and vim.bo.fenc or vim.o.fenc -- Get buffer or global encoding
      local fmt = vim.bo.fileformat
      return string.format("%s[%s]", enc:upper(), fmt:upper())
    end

    lualine.setup({
      options = {
        icons_enabled = true,
        theme = "auto", 
        component_separators = { left = "", right = "" }, 
        section_separators = { left = "", right = "" }, 
        disabled_filetypes = {
          statusline = { "NvimTree", "neo-tree", "Outline" }, 
          winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = false, 
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
            path = 1,             
            shorting_target = 40, 
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
      tabline = {}, 
      winbar = {},
      inactive_winbar = {},
      extensions = { "neo-tree", "trouble" }, 
    })
    vim.notify("Lualine configured", vim.log.levels.DEBUG, { title = "Lualine" })
  end,
}

