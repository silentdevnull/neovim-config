-- ~/.config/nvim/lua/user/snippets/lua.lua
-- This file should return a list of snippets for Lua,
-- or a table keyed by filetype if you want to mix.

local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt

return {
	s("req", fmt([[local {} = require("{}")]], { i(1, "module"), i(2, "module_name") })),
	s("pcall", fmt([[
local ok, {} = pcall(require, "{}")
if not ok then
  vim.notify("Failed to load {}: " .. {}, vim.log.levels.ERROR)
  return
end
]], { i(1, "var"), i(2, "module_name"), i(2), i(1) }
	)),
	s("fn", {
		t("function "), i(1, "name"), t("("), i(2, "params"), t(")"),
		t({ "", "" }), -- Newline and indent for body
		i(0), -- Final cursor position
		t({ "", "end" }),
	}),
}
