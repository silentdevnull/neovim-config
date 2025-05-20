-- ~/.config/nvim/lua/user/core/lsp_keymaps.lua

local M = {}

local map = vim.keymap.set
local lsp_opts = { noremap = true, silent = true }

M.on_attach = function(client, bufnr)
  local bufmap = function(mode, lhs, rhs, desc)
    if desc then
      lsp_opts.desc = desc
    end
    map(mode, lhs, rhs, vim.tbl_extend("force", lsp_opts, { buffer = bufnr }))
  end

  bufmap("n", "gD", vim.lsp.buf.declaration, "LSP Go to Declaration")
  bufmap("n", "gd", vim.lsp.buf.definition, "LSP Go to Definition")
  bufmap("n", "K", vim.lsp.buf.hover, "LSP Hover Documentation")
  bufmap("n", "gi", vim.lsp.buf.implementation, "LSP Go to Implementation")
  bufmap("n", "<leader>ls", vim.lsp.buf.signature_help, "LSP Signature Help")
  bufmap("n", "<leader>lt", vim.lsp.buf.type_definition, "LSP Go to Type Definition")
  bufmap("n", "<leader>lr", vim.lsp.buf.rename, "LSP Rename Symbol")
  bufmap({"n", "v"}, "<leader>la", vim.lsp.buf.code_action, "LSP Code Action")
  bufmap("n", "gr", vim.lsp.buf.references, "LSP Go to References")
  bufmap("n", "<leader>lf", function() vim.lsp.buf.format({ async = true }) end, "LSP Format Buffer")

  bufmap("n", "[d", vim.diagnostic.goto_prev, "LSP Prev Diagnostic")
  bufmap("n", "]d", vim.diagnostic.goto_next, "LSP Next Diagnostic")
  bufmap("n", "<leader>le", vim.diagnostic.open_float, "LSP Show Line Diagnostics")
  bufmap("n", "<leader>lq", vim.diagnostic.setloclist, "LSP Diagnostics to Loclist")

  if client.supports_method("workspace/didChangeWorkspaceFolders") then
    bufmap("n", "<leader>lwa", vim.lsp.buf.add_workspace_folder, "LSP Add Workspace Folder")
    bufmap("n", "<leader>lwr", vim.lsp.buf.remove_workspace_folder, "LSP Remove Workspace Folder")
    bufmap("n", "<leader>lwl", function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, "LSP List Workspace Folders")
  end

  vim.notify("LSP keymaps attached for " .. client.name .. " on buffer " .. bufnr, vim.log.levels.DEBUG, { title = "LSP" })
end

return M
