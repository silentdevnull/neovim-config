-- ~/.config/nvim/lua/user/core/dap_manager.lua

local M = {}

local dap_ok, dap = pcall(require, "dap")
local dapui_ok, dapui = pcall(require, "dapui")

function M.setup()
	if not dap_ok then
		vim.notify("nvim-dap module not found!", vim.log.levels.ERROR, { title = "DAP ERROR" })
		return
	end
	if not dapui_ok then
		vim.notify("nvim-dap-ui module not found!", vim.log.levels.ERROR, { title = "DAP ERROR" })
		-- DAP can still function without UI, so we might not want to return here.
	end

	vim.notify("DAP Manager: Starting setup...", vim.log.levels.DEBUG, { title = "DAP" })

	-- Load and setup adapters (with existence checks)
	local adapters_manager_ok, adapters_manager = pcall(require, "user.core.dap_adapters_config")
	if adapters_manager_ok and adapters_manager and adapters_manager.setup_adapters then
		adapters_manager.setup_adapters()
	else
		vim.notify("Failed to load or run dap_adapters_config.setup_adapters()", vim.log.levels.ERROR,
			{ title = "DAP ERROR" })
	end

	-- Setup DAP UI
	if dapui then
		dapui.setup({
			layouts = {
				{
					elements = {
						{ id = "scopes",      size = 0.25 },
						{ id = "breakpoints", size = 0.25 },
						{ id = "stacks",      size = 0.25 },
						{ id = "watches",     size = 0.25 },
					},
					size = 40,
					position = "left",
				},
				{
					elements = {
						{ id = "repl",    size = 0.5 },
						{ id = "console", size = 0.5 },
					},
					size = 10,
					position = "bottom",
				},
			},
			floating = {
				max_height = nil, -- Use default
				max_width = nil, -- Use default
				border = "rounded",
				mappings = {
					close = { "q", "<Esc>" },
				},
			},
			windows = { indent = 1 },
			render = {
				max_type_length = nil, -- Use default
				-- indent = 1, -- For icons
			}
		})

		-- Auto open/close DAP UI based on events
		dap.listeners.after.event_initialized["dapui_config"] = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated["dapui_config"] = function()
			dapui.close()
		end
		dap.listeners.before.event_exited["dapui_config"] = function()
			dapui.close()
		end
		vim.notify("nvim-dap-ui configured.", vim.log.levels.INFO, { title = "DAP UI" })
	end

	-- Load and setup keymaps
	local keymaps_manager_ok, keymaps_manager = pcall(require, "user.core.dap_keymaps")
	if keymaps_manager_ok and keymaps_manager and keymaps_manager.setup_keymaps then
		keymaps_manager.setup_keymaps()
	else
		vim.notify("Failed to load or run dap_keymaps.setup_keymaps()", vim.log.levels.ERROR,
			{ title = "DAP ERROR" })
	end

	vim.notify("DAP Manager: Setup complete.", vim.log.levels.INFO, { title = "DAP" })
end

return M
