local M = {}

local nightfox_themes = {
  "nightfox",
  "dayfox",
  "dawnfox",
  "duskfox",
  "nordfox",
  "carbonfox",
  "terafox",
  "alphafox", -- A more transparent variant
}

local function set_theme(theme_name)
  if not vim.tbl_contains(nightfox_themes, theme_name) then
    vim.notify(
      "Theme '" .. theme_name .. "' is not a recognized Nightfox theme.",
      vim.log.levels.ERROR,
      { title = "Theme Switcher" }
    )
    return
  end
  vim.cmd("colorscheme " .. theme_name)
  vim.notify(
    "Colorscheme changed to " .. theme_name,
    vim.log.levels.INFO,
    { title = "Theme Switcher" }
  )
end

M.set_nightfox = function()
  set_theme("nightfox")
end
M.set_dayfox = function()
  set_theme("dayfox")
end
M.set_dawnfox = function()
  set_theme("dawnfox")
end
M.set_duskfox = function()
  set_theme("duskfox")
end
M.set_nordfox = function()
  set_theme("nordfox")
end
M.set_carbonfox = function()
  set_theme("carbonfox")
end
M.set_terafox = function()
  set_theme("terafox")
end
M.set_alphafox = function()
  set_theme("alphafox")
end

-- Optional: A function to cycle through themes
local current_theme_index = 1
M.cycle_nightfox_theme = function(direction)
  direction = direction or "next" -- "next" or "prev"
  if direction == "next" then
    current_theme_index = current_theme_index + 1
    if current_theme_index > #nightfox_themes then
      current_theme_index = 1
    end
  elseif direction == "prev" then
    current_theme_index = current_theme_index - 1
    if current_theme_index < 1 then
      current_theme_index = #nightfox_themes
    end
  end
  set_theme(nightfox_themes[current_theme_index])
end

return M

