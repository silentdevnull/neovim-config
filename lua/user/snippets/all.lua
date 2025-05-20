-- ~/.config/nvim/lua/user/snippets/all.lua
local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
	s("date", { t(os.date("%Y-%m-%d")) }),
	s("datetime", { t(os.date("%Y-%m-%d %H:%M:%S")) }),
	s("todo", { t("-- TODO(yourname): "), i(1, "Remember to...") }),
}
