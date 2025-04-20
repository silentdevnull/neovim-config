-- Custom Go Snippets
local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node

return {
  -- Go error check
  s("err", {
    t({
      "if err != nil {",
      "\t",
    }),
    i(1, "return err // TODO: Handle error properly"),
    t({ "", "}" }),
  }),

   -- Go error check with log
  s("errl", {
    t({
      "if err != nil {",
      "\tlog.Printf(\"ERROR: %v\", err)", -- Example logging
      "\treturn err",
      "}",
    }),
  }),

  -- Simple function
  s("func", {
    t("func "),
    i(1, "FunctionName"),
    t("("),
    i(2, "params"),
    t(") "),
    i(3, "returnType"),
    t(" {"),
    t({ "", "\t" }),
    i(0), -- Final cursor position
    t({ "", "}" }),
  }),
}
