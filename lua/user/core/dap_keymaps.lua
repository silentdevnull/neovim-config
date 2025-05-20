-- ~/.config/nvim/lua/user/core/dap_keymaps.lua

local M = {}

function M.setup_keymaps()
	local dap = require("dap")
	local dapui = require("dapui") -- Make sure dapui is available if mapping its functions

	local map = vim.keymap.set
	local opts = { silent = true }

	-- General DAP controls
	map("n", "<leader>dc", dap.continue, vim.tbl_extend("force", opts, { desc = "DAP Continue" }))
	map("n", "<leader>dj", dap.step_over, vim.tbl_extend("force", opts, { desc = "DAP Step Over (Next)" })) -- j for next
	map("n", "<leader>dk", dap.step_into, vim.tbl_extend("force", opts, { desc = "DAP Step Into" }))  -- k for into
	map("n", "<leader>do", dap.step_out, vim.tbl_extend("force", opts, { desc = "DAP Step Out" }))
	map("n", "<leader>dt", dap.terminate, vim.tbl_extend("force", opts, { desc = "DAP Terminate" }))
	map("n", "<leader>dr", dap.repl.open, vim.tbl_extend("force", opts, { desc = "DAP Open REPL" }))
	map("n", "<leader>dl", dap.run_last, vim.tbl_extend("force", opts, { desc = "DAP Run Last" }))

	-- Breakpoints
	map("n", "<leader>db", dap.toggle_breakpoint, vim.tbl_extend("force", opts, { desc = "DAP Toggle Breakpoint" }))
	map("n", "<leader>dB", function() -- Breakpoint with condition
		dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
	end, vim.tbl_extend("force", opts, { desc = "DAP Set Conditional Breakpoint" }))
	map("n", "<leader>lp", function() -- Log point
		dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
	end, vim.tbl_extend("force", opts, { desc = "DAP Set Log Point" }))

	-- DAP UI Toggles
	if dapui then
		map("n", "<leader>du", dapui.toggle, vim.tbl_extend("force", opts, { desc = "DAP Toggle UI" }))
		map("n", "<leader>de", dapui.eval, vim.tbl_extend("force", opts, { desc = "DAP Eval (Visual/Input)" })) -- Eval under cursor or visual
	else
		map("n", "<leader>du", function() print("nvim-dap-ui not available") end,
			vim.tbl_extend("force", opts, { desc = "DAP UI (Not Loaded)" }))
		map("n", "<leader>de", function() print("nvim-dap-ui not available for eval") end,
			vim.tbl_extend("force", opts, { desc = "DAP Eval (UI Not Loaded)" }))
	end


	-- Scopes, Watches, etc. (can be accessed via DAP UI, but keymaps can be useful)
	map("n", "<leader>ds", function() dap.scopes() end,
		vim.tbl_extend("force", opts, { desc = "DAP View Scopes (if UI closed)" }))

	vim.notify("DAP keymaps configured.", vim.log.levels.INFO, { title = "DAP Keymaps" })
end

return M
