-- ~/.config/nvim/lua/user/plugins/lspconfig.lua

return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
	},
	config = function()
		local lspconfig = require("lspconfig")
		local lsp_keymaps = require("user.core.lsp_keymaps")

		-- DEBUGGING BLOCK --
		local mason_lspconfig_module = require("mason-lspconfig")
		if not mason_lspconfig_module then
			vim.notify("LSPConfig: require('mason-lspconfig') returned nil!", vim.log.levels.ERROR,
				{ title = "LSP ERROR" })
			return -- Stop if module is nil
		end
		if type(mason_lspconfig_module) ~= "table" then
			vim.notify(
			"LSPConfig: require('mason-lspconfig') did not return a table! Type: " ..
			type(mason_lspconfig_module), vim.log.levels.ERROR, { title = "LSP ERROR" })
			return
		end
		if not mason_lspconfig_module.setup_handlers then
			vim.notify("LSPConfig: 'mason-lspconfig' module does NOT have 'setup_handlers' field!",
				vim.log.levels.ERROR, { title = "LSP ERROR" })
			local keys_available = {}
			for k, _ in pairs(mason_lspconfig_module) do
				table.insert(keys_available, k)
			end
			vim.notify(
			"LSPConfig: Keys available in 'mason-lspconfig' module: " .. table.concat(keys_available, ", "),
				vim.log.levels.INFO, { title = "LSP DEBUG" })
			return -- Stop if function is missing
		end
		vim.notify("LSPConfig: 'mason-lspconfig' module loaded and 'setup_handlers' IS available.",
			vim.log.levels.INFO, { title = "LSP DEBUG" })
		-- END DEBUGGING BLOCK --

		local capabilities = vim.lsp.protocol.make_client_capabilities()
		-- capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

		local successfully_configured_servers = {}
		local skipped_servers = {}

		local default_lsp_settings = {
			flags = { debounce_text_changes = 150 },
			on_attach = lsp_keymaps.on_attach,
			capabilities = capabilities,
		}

		local custom_lsp_setup_handler = function(server_name)
			local server_is_ready = false
			local server_options = vim.deepcopy(default_lsp_settings)
			local lsp_executable_path

			local success, server_info = pcall(require("mason-registry").get_package, server_name)
			if success and server_info then
				local install_dir = server_info:get_install_path()
				local common_exe_name = server_name
				if server_name == "lua_ls" then common_exe_name = "lua-language-server" end

				local potential_paths = {
					install_dir .. "/bin/" .. common_exe_name,
					install_dir .. "/" .. common_exe_name,
					install_dir .. "/bin/" .. server_name,
					install_dir .. "/" .. server_name,
				}
				if server_name == "rust_analyzer" then potential_paths = { install_dir ..
					"/rust-analyzer" } end
				if server_name == "clangd" then potential_paths = { install_dir .. "/bin/clangd" } end

				for _, path_candidate in ipairs(potential_paths) do
					if vim.fn.filereadable(path_candidate) == 1 and vim.fn.executable(path_candidate) == 1 then
						lsp_executable_path = path_candidate
						server_options.cmd = { lsp_executable_path }
						server_is_ready = true
						break
					end
				end
				if not server_is_ready and vim.fn.executable(server_name) == 1 then
					lsp_executable_path = server_name
					server_is_ready = true
				end
			elseif vim.fn.executable(server_name) == 1 then
				lsp_executable_path = server_name
				server_is_ready = true
			end

			if server_is_ready then
				if server_name == "lua_ls" then
					server_options.settings = {
						Lua = {
							runtime = { version = "LuaJIT" },
							diagnostics = { globals = { "vim" } },
							workspace = { library = vim.api.nvim_get_runtime_file("", true) },
							telemetry = { enable = false },
						},
					}
				elseif server_name == "pylsp" then
					server_options.settings = {
						pylsp = {
							plugins = {
								ruff = { enabled = true, lineLength = 79 },
								pycodestyle = { enabled = false },
								pylint = { enabled = false },
							}
						}
					}
				end
				lspconfig[server_name].setup(server_options)
				table.insert(successfully_configured_servers,
					server_name ..
					(lsp_executable_path and lsp_executable_path ~= server_name and (" (at " .. vim.fn.fnamemodify(lsp_executable_path, ":t") .. ")") or ""))
			else
				table.insert(skipped_servers, server_name .. " (executable not found/ready)")
			end
		end

		-- This is where the error occurs (around original line 123)
		mason_lspconfig_module.setup_handlers({
			["*"] = custom_lsp_setup_handler,
		})

		vim.diagnostic.config({
			virtual_text = true,
			signs = true,
			underline = true,
			update_in_insert = false,
			severity_sort = true,
			float = { border = "rounded", source = "always" },
		})

		local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		if #successfully_configured_servers > 0 then
			vim.notify("LSP: Configured: " .. table.concat(successfully_configured_servers, ", "),
				vim.log.levels.INFO, { title = "LSP Setup" })
		end
		if #skipped_servers > 0 then
			vim.notify("LSP: Skipped: " .. table.concat(skipped_servers, ", "), vim.log.levels.WARN,
				{ title = "LSP Setup" })
		end
		vim.notify("nvim-lspconfig setup complete.", vim.log.levels.INFO, { title = "LSP Setup" })
	end,
}
