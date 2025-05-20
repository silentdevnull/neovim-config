-- ~/.config/nvim/lua/user/core/dap_adapters_config.lua

local M = {}

function M.setup_adapters()
	local dap = require("dap")
	local dap_utils_ok, dap_utils = pcall(require, "dap.utils") -- For pick_process

	vim.notify("DAP Adapters: Starting configuration...", vim.log.levels.DEBUG, { title = "DAP Adapters" })

	-- Helper function to check executable and notify
	local function check_and_notify(exe_name, adapter_name, skip_message)
		if vim.fn.executable(exe_name) == 1 then
			vim.notify("DAP Adapters: Found executable '" .. exe_name .. "' for " .. adapter_name .. ".",
				vim.log.levels.DEBUG, { title = "DAP Adapters" })
			return true
		else
			vim.notify(
			skip_message or
			"DAP Adapters: Executable '" ..
			exe_name .. "' not found. Skipping " .. adapter_name .. " adapter.", vim.log.levels.WARN,
				{ title = "DAP Adapters" })
			return false
		end
	end

	-- --- Go (Delve) ---
	-- Installation: `go install github.com/go-delve/delve/cmd/dlv@latest`
	if check_and_notify("dlv", "Go") then
		dap.adapters.go = {
			type = "server",
			port = "${port}", -- DAP will find a free port and substitute it
			executable = {
				command = "dlv",
				args = { "dap", "-l", "127.0.0.1:${port}" },
			},
		}
		dap.configurations.go = {
			{
				type = "go",
				name = "Debug Go Package",
				request = "launch",
				program = "${fileDirname}", -- Debugs the package containing the current file
				dlvToolPath = vim.fn.exepath("dlv"), -- Optional: explicitly provide path
			},
			{
				type = "go",
				name = "Debug Go Test",
				request = "launch",
				mode = "test",
				program = "${fileDirname}",
			},
			{
				type = "go",
				name = "Debug Go File",
				request = "launch",
				program = "${file}",
			},
		}
		vim.notify("DAP Adapters: Go (dlv) adapter configured.", vim.log.levels.INFO, { title = "DAP Adapters" })
	end

	-- --- Python (debugpy) ---
	-- Installation: `pip install debugpy` (preferably in your project's virtual environment)
	local python_exe = vim.fn.exepath("python3") or vim.fn.exepath("python")
	if python_exe and python_exe ~= "" then
		-- We assume `python -m debugpy.adapter` will work if python is found.
		-- The user needs to ensure `debugpy` is installed in the Python environment being used.
		dap.adapters.python = {
			type = "executable", -- Changed from server to executable for this common pattern
			command = python_exe,
			args = { "-m", "debugpy.adapter" },
		}
		dap.configurations.python = {
			{
				type = "python",
				request = "launch",
				name = "Python: Current File",
				program = "${file}",
				pythonPath = python_exe, -- Tells debugpy which python to use for the debugged program
				console = "integratedTerminal", -- "internalConsole" or "externalTerminal"
				justMyCode = true, -- Step through user-written code only by default
			},
			-- Add more configurations, e.g., for Django, Flask, specific scripts
			-- {
			--   type = "python",
			--   request = "launch",
			--   name = "Python: Module",
			--   module = "module.name", -- e.g., "myapp.cli"
			--   pythonPath = python_exe,
			--   console = "integratedTerminal",
			-- },
		}
		vim.notify(
		"DAP Adapters: Python (debugpy) adapter configured (uses '" .. python_exe .. " -m debugpy.adapter').",
			vim.log.levels.INFO, { title = "DAP Adapters" })
	else
		vim.notify("DAP Adapters: Python executable not found. Skipping Python adapter.", vim.log.levels.WARN,
			{ title = "DAP Adapters" })
	end

	-- --- Node.js ---
	-- For Node, the easiest non-Mason way is often to use Node's built-in inspector.
	-- Users start their node process with `node --inspect-brk my_script.js`
	-- and then use an "attach" configuration in DAP.
	-- A "launch" config without a separate adapter like node-debug2-adapter or js-debug-adapter is harder.
	if check_and_notify("node", "Node.js") then
		dap.adapters.node = { -- For attach configurations primarily
			type = "server", -- nvim-dap will act as a client to Node's inspector server
			host = "127.0.0.1",
			port = 9229, -- Default Node inspect port
		}
		-- A more robust 'node' adapter for launch often requires a separate adapter script.
		-- Example using a hypothetical globally installed 'js-debug-adapter' (user would need to install this)
		-- if vim.fn.executable("js-debug-adapter") == 1 then
		--   dap.adapters.node_launch = {
		--     type = "executable",
		--     command = "js-debug-adapter",
		--     args = {""}, -- js-debug-adapter might take arguments or read from stdin
		--   }
		-- else
		--   vim.notify("DAP Adapters: 'js-debug-adapter' not found for Node launch. Only attach configured.", vim.log.levels.WARN)
		-- end

		dap.configurations.javascript = {
			{
				name = "Node: Attach to Process (Port 9229)",
				type = "node",                      -- Matches dap.adapters.node
				request = "attach",
				processId = dap_utils_ok and dap_utils.pick_process or nil, -- Helper to pick a running Node process
				protocol = "inspector",             -- Explicitly set protocol
				port = 9229,
				cwd = vim.fn.getcwd(),
				sourceMaps = true,
			},
			-- Example launch config if you had a `node_launch` adapter (requires js-debug-adapter or similar)
			-- {
			--   name = "Node: Launch Current File",
			--   type = "node_launch", -- This would need a corresponding dap.adapters.node_launch
			--   request = "launch",
			--   program = "${file}",
			--   cwd = "${workspaceFolder}",
			--   sourceMaps = true,
			--   protocol = "inspector",
			--   console = "integratedTerminal",
			-- },
		}
		dap.configurations.typescript = dap.configurations.javascript -- Can often reuse JS configs
		vim.notify(
		"DAP Adapters: Node.js (attach) adapter configured. For launch, a separate adapter setup is usually needed.",
			vim.log.levels.INFO, { title = "DAP Adapters" })
	end

	-- --- C/C++/Rust (codelldb) ---
	-- Installation: `cargo install codelldb` or download binary from GitHub releases.
	if check_and_notify("codelldb", "C/C++/Rust (codelldb)") then
		dap.adapters.codelldb = {
			type = "server",
			port = "${port}",
			executable = {
				command = "codelldb",
				args = { "--port", "${port}" },
			},
		}
		local cpp_rust_configs = {
			{
				name = "Launch Executable (codelldb)",
				type = "codelldb", -- Must match adapter name
				request = "launch",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				cwd = "${workspaceFolder}",
				stopOnEntry = false,
				args = function()
					local arg_string = vim.fn.input("Program arguments: ")
					local args_table = {}
					for arg in string.gmatch(arg_string, "[^%s]+") do
						table.insert(args_table, arg)
					end
					return args_table
				end,
				runInTerminal = false, -- Set to true if your program needs its own terminal
				sourceLanguages = { "cpp", "c", "rust" }, -- Helps DAP know how to map sources
			},
		}
		dap.configurations.cpp = vim.deepcopy(cpp_rust_configs)
		dap.configurations.c = vim.deepcopy(cpp_rust_configs)
		dap.configurations.rust = vim.deepcopy(cpp_rust_configs)
		vim.notify("DAP Adapters: C/C++/Rust (codelldb) adapter configured.", vim.log.levels.INFO,
			{ title = "DAP Adapters" })
	end

	-- Add more adapters here following the same pattern:
	-- 1. Check if executable exists.
	-- 2. If yes, define `dap.adapters.<name> = { ... }`.
	-- 3. Define `dap.configurations.<language> = { ... }`.
	-- 4. Notify user.

	vim.notify("DAP Adapters: Configuration finished.", vim.log.levels.DEBUG, { title = "DAP Adapters" })
end

return M
