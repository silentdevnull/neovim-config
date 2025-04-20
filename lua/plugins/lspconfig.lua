return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"hrsh7th/cmp-nvim-lsp", -- Dependency for completion source
			{ "antosha417/nvim-lsp-file-operations", config = true },
			"williamboman/mason-lspconfig.nvim", -- To integrate with Mason
			-- Optional: Provides extra lua setup assistance, especially for Neovim config
			{ "folke/neodev.nvim", opts = {} },
		},
		config = function()
			local lspconfig = require("lspconfig")
			local cmp_nvim_lsp = require("cmp_nvim_lsp")
			local keymap_lsp = vim.keymap
			-- Get capabilities with support for cmp-nvim-lsp
			local capabilities = cmp_nvim_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities())

			-- Setup language servers using mason-lspconfig
			require("mason-lspconfig").setup_handlers({
				-- Default handler function
				function(server_name)
					lspconfig[server_name].setup({
						capabilities = capabilities,
						on_attach = function(client, bufnr)
							-- Standard LSP keymaps
							local opts = { buffer = bufnr, noremap = true, silent = true }
							keymap_lsp.set("n", "gd", vim.lsp.buf.definition, opts)
							keymap_lsp.set("n", "K", vim.lsp.buf.hover, opts)
							keymap_lsp.set("n", "gi", vim.lsp.buf.implementation, opts)
							keymap_lsp.set("n", "<C-k>", vim.lsp.buf.signature_help, opts) -- Use <C-k> for signature help
							keymap_lsp.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
							keymap_lsp.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
							keymap_lsp.set("n", "<leader>wl", function()
								print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
							end, opts)
							keymap_lsp.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
							keymap_lsp.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
							keymap_lsp.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
							keymap_lsp.set("n", "gr", vim.lsp.buf.references, opts)
							-- Note: Formatting is handled by conform.nvim plugin
						end,
					})
				end,
				-- Specific server configurations
				["jdtls"] = function()
					-- Requires manual setup often, refer to nvim-jdtls docs
					lspconfig.jdtls.setup({
						capabilities = capabilities,
						on_attach = function(client, bufnr)
							local opts = { buffer = bufnr, noremap = true, silent = true }
							keymap_lsp.set("n", "gd", vim.lsp.buf.definition, opts)
							keymap_lsp.set("n", "K", vim.lsp.buf.hover, opts)
							-- Add other Java-specific mappings if needed
						end,
					})
				end,
				["lua_ls"] = function()
					-- Configure lua_ls specifically for Neovim config development
					lspconfig.lua_ls.setup({
						capabilities = capabilities,
						settings = {
							Lua = {
								runtime = { version = "LuaJIT" },
								diagnostics = { globals = { "vim" } },
								workspace = {
									library = vim.api.nvim_get_runtime_file("", true),
									checkThirdParty = false, -- Avoid issues with workspace libraries
								},
								telemetry = { enable = false },
							},
						},
						on_attach = function(client, bufnr)
							local opts = { buffer = bufnr, noremap = true, silent = true }
							keymap_lsp.set("n", "gd", vim.lsp.buf.definition, opts)
							keymap_lsp.set("n", "K", vim.lsp.buf.hover, opts)
						end,
					})
				end,
				-- Add other specific server configs if necessary (e.g., rust_analyzer custom settings)
			})

			-- Configure diagnostics appearance using the new API (FIXED)
			--    vim.diagnostic.define_sign(vim.diagnostic.severity.ERROR, { text = " ", texthl = "DiagnosticSignError", numhl = "DiagnosticSignError" })
			--  vim.diagnostic.define_sign(vim.diagnostic.severity.WARN,  { text = " ", texthl = "DiagnosticSignWarn",  numhl = "DiagnosticSignWarn" })
			--vim.diagnostic.define_sign(vim.diagnostic.severity.INFO,  { text = " ", texthl = "DiagnosticSignInfo",  numhl = "DiagnosticSignInfo" })
			--vim.diagnostic.define_sign(vim.diagnostic.severity.HINT,  { text = " ", texthl = "DiagnosticSignHint",  numhl = "DiagnosticSignHint" })

			-- Configure diagnostics appearance (Using deprecated method for older Neovim versions)
			local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				-- Use deprecated function vim.fn.sign_define
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
			end

			vim.diagnostic.config({
				virtual_text = false, -- Disable virtual text diagnostics (can be noisy)
				signs = true,
				underline = true,
				update_in_insert = false, -- Only update diagnostics when leaving insert mode
				severity_sort = true,
				float = {
					border = "rounded",
					source = "always", -- Show source of diagnostic e.g. 'eslint'
				},
			})

			-- Optional: Show diagnostics automatically in floating window when cursor hovers
			-- vim.cmd([[autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focus = false })]])
		end,
	},
}
