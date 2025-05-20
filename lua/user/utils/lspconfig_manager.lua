local M = {}                           -- Our module to export functions

local lspconfig = require("lspconfig") -- nvim-lspconfig module
local lsp_keymaps = require("user.core.lsp_keymaps")

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
capabilities.textDocument.completion.completionItem.snippetSupport = true

local successfully_configured_servers = {}
local skipped_servers = {}

-- Default settings for all LSP servers
local default_lsp_settings = {
  flags = { debounce_text_changes = 150 },
  on_attach = lsp_keymaps.on_attach,
  capabilities = capabilities,
}

-- This function is called by mason-lspconfig's handler for each server
M.setup_server = function(server_name, server_specific_overrides)
  server_specific_overrides = server_specific_overrides or {}
  local server_is_ready = false
  local server_options = vim.deepcopy(default_lsp_settings)
  server_options = vim.tbl_deep_extend("force", server_options, server_specific_overrides)

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
    if server_name == "rust_analyzer" then potential_paths = { install_dir .. "/rust-analyzer" } end
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
    if server_name == "csharp_ls" then
      -- No specific default options needed for csharp_ls usually,
      -- but you could add them here if necessary.
      -- For example, if you need to specify the solution file:
      -- server_options.root_dir = lspconfig.util.root_pattern("*.sln", ".git")
      -- server_options.cmd = { "path/to/csharp-ls", "--stdio" } -- If not found by default
      vim.notify("LSP: Configuring csharp_ls...", vim.log.levels.DEBUG)
    end
    if server_name == "lua_ls" then
      server_options.settings = vim.tbl_deep_extend("force", server_options.settings or {}, {
        Lua = {
          runtime = { version = "LuaJIT" },
          diagnostics = { globals = { "vim" } },
          workspace = { library = vim.api.nvim_get_runtime_file("", true) },
          telemetry = { enable = false },
        },
      })
    elseif server_name == "pylsp" then
      server_options.settings = vim.tbl_deep_extend("force", server_options.settings or {}, {
        pylsp = {
          plugins = {
            ruff = { enabled = true, lineLength = 79 },
            pycodestyle = { enabled = false },
            pylint = { enabled = false },
          },
        },
      })
    end

    lspconfig[server_name].setup(server_options)
    local server_id = server_name ..
        (lsp_executable_path and lsp_executable_path ~= server_name and (" (at " .. vim.fn.fnamemodify(lsp_executable_path, ":t") .. ")") or "")
    if not vim.tbl_contains(successfully_configured_servers, server_id) then
      table.insert(successfully_configured_servers, server_id)
    end
  else
    local skipped_id = server_name .. " (executable not found/ready)"
    if not vim.tbl_contains(skipped_servers, skipped_id) then
      table.insert(skipped_servers, skipped_id)
    end
  end
end

M.finalize_setup_and_notify = function()
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
  vim.notify("LSP setup process finalized.", vim.log.levels.INFO, { title = "LSP Setup" })

  successfully_configured_servers = {}
  skipped_servers = {}
end

return M
