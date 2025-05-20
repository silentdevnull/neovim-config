-- ~/.config/nvim/lua/user/snippets/go.lua

local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local fmt = require("luasnip.extras.fmt").fmt -- For easier string formatting

return {
  s("errchk", fmt([[
if err != nil {{
    return fmt.Errorf("{}: %w", err) -- Default to return, can be changed by choice node
}}
]], {
    i(1, "your error message"), -- Placeholder for the custom error message
  })),

  s("errhandle", { -- A more descriptive trigger name
    t("if err != nil {"),
    t({"", "\tfmt.Errorf(\""}), i(1, "your error message"), t(": %w\", err)"), -- Custom message and err
    t({"", "\t") , -- Newline and indent for the choice
    c(2, { -- Choice node for return or exit
      t("return"),
      t("os.Exit(1)"),
    }),
    t({"", "}"}),
    i(0) -- Final cursor position after the block (optional)
  }),

  -- A slightly more advanced version using fmt for the whole block
  -- and ensuring proper Go import for os.Exit if chosen
  s("erradv", fmt([[
if err != nil {{
    fmt.Errorf("{}: %w", err)
    {}
}}
]], {
      i(1, "failed to do something"), -- Placeholder for the custom error message
      c(2, {
        t("return"),
        -- Dynamic node to add import "os" if os.Exit(1) is chosen
        -- This is more advanced and might require more setup if you want auto-importing
        -- For simplicity, we'll just put os.Exit(1) directly.
        -- If you have a goimports or similar formatter on save, it might add the import.
        t("os.Exit(1)"),
      }),
    })
  ),
}

-- You can add more Go snippets here

