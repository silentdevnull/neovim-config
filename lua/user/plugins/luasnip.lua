-- ~/.config/nvim/lua/user/plugins/luasnip.lua

return {
	"L3MON4D3/LuaSnip",
	-- version = "v2.*", -- Optionally pin to a major version
	-- build = "make install_jsregexp", -- For regex in JS snippets, if you need it
	dependencies = { "rafamadriz/friendly-snippets" }, -- Ensure friendly-snippets is available
	config = function()
		local luasnip = require("luasnip")

		-- Option 1: Load friendly-snippets (VSCode format)
		-- This is often also done in cmp.lua, but can be here too.
		-- If you do it here, you might not need it in cmp.lua's config.
		require("luasnip.loaders.from_vscode").lazy_load()

		-- Option 2: Load custom Lua snippets
		-- Define the path to your custom snippets.
		-- We'll use a directory structure like:
		-- lua/user/snippets/lua.lua
		-- lua/user/snippets/python.lua
		-- lua/user/snippets/all.lua (for snippets available in all filetypes)
		local custom_snippet_path = vim.fn.stdpath("config") .. "/lua/user/snippets"

		-- Ensure the directory exists (optional, but good practice if you automate things)
		-- vim.fn.mkdir(custom_snippet_path, "p")

		-- Load snippets from the custom path
		-- This will look for .lua files in the specified path.
		-- Each .lua file should return a list of snippets or a list of filetype-keyed tables.
		require("luasnip.loaders.from_lua").load({ paths = { custom_snippet_path } })

		-- Example of how you might structure a custom Lua snippet file (e.g., lua/user/snippets/lua.lua):
		--
		-- return {
		--   -- Snippet for current date
		--   luasnip.s("date", {
		--     t(os.date("%Y-%m-%d")),
		--   }),
		--   -- Simple function snippet
		--   luasnip.s("fn", {
		--     t("function "),
		--     luasnip.i(1, "name"), -- Insert node for function name
		--     t("()"),
		--     luasnip.c(2, { -- Choice node for end or end)
		--         t({""}), -- empty line
		--         t({"end"})
		--     }),
		--     luasnip.i(0), -- Final cursor position
		--     t({"", "end"}),
		--   }),
		-- }, {
		--   -- Filetype specific snippets can also be grouped
		--   -- lua = { ... list of lua snippets ... }
		-- }

		-- Keymaps for navigating snippets (if not handled by nvim-cmp's Tab mapping)
		-- These are useful if you want dedicated keys for snippet jumping.
		-- vim.keymap.set({"i", "s"}, "<C-k>", function() luasnip.jump(1) end, {silent = true})
		-- vim.keymap.set({"i", "s"}, "<C-j>", function() luasnip.jump(-1) end, {silent = true})

		-- Optional: Keymap for cycling choices in a choice node
		-- vim.keymap.set({"i", "s"}, "<C-l>", function()
		--   if luasnip.choice_active() then
		--     luasnip.change_choice(1)
		--   end
		-- end, {silent = true})

		vim.notify("LuaSnip configured. Custom snippets path: " .. custom_snippet_path, vim.log.levels.INFO,
			{ title = "LuaSnip" })
	end,
}
