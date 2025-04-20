-- Custom Lua Snippets
local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node
local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt

return {
  -- Simple error check
  s("err", {
    t({
      "if err ~= nil then",
      "\t",
    }),
    i(1, "return err -- TODO: Handle error"),
    t({ "", "end" }),
  }),

  -- Append to slice/table
  s("append", {
    t("table.insert("),
    i(1, "tableName"),
    t(", "),
    i(2, "value"),
    t(")"),
  }),

  -- Simple function definition
  s("fn", fmt(
    [[
    local function {}({})
      {}
    end
    ]],
    { i(1, "function_name"), i(2, "args"), i(0) }
  )),

  -- Simple print variable with inspect
   s("pkv", {
    t('print("'),
    i(1, "key"),
    t(': " .. vim.inspect('),
    i(2, "value"),
    t('))'),
  }),

}
