return {
	{
		"williamboman/mason.nvim",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
		},
		config = function()
			local mason = require("mason")
			local mason_lspconfig = require("mason-lspconfig")
			local mason_tool_installer = require("mason-tool-installer")

			mason.setup({
				ui = {
					border = "rounded",
					icons = { package_installed = "✓", package_pending = "➜", package_uninstalled = "✗" },
				},
			})

			mason_lspconfig.setup({
				-- Ensure these LSP servers are installed
				ensure_installed = {
					"gopls",
					"ts_ls",
					"rust_analyzer",
					"phpactor",
					"jdtls",
					"csharp_ls",
					"html",
					"cssls",
					"emmet_ls",
					"perlnavigator",
					"kotlin_language_server",
					"terraformls",
					"taplo",
					"jsonls",
					"yamlls",
					"lemminx",
					"sqlls",
					"lua_ls", -- Added lua_ls for Neovim config help
				},
				automatic_installation = true,
			})

			mason_tool_installer.setup({
				-- Ensure these formatters and linters are installed
				ensure_installed = {
					-- Formatters
					"prettier", -- js, ts, css, html, json, yaml, markdown
					"stylua", -- lua
					"goimports", -- go
					"php-cs-fixer", -- php
					"google-java-format", -- java
					"csharpier", -- c#
					-- "rubocop", -- ruby (also linter)
					-- "perltidy", -- perl
					"ktlint", -- kotlin (also linter)
					-- "swiftformat", -- swift
					-- "terraform_fmt", -- terraform (built-in via LSP usually, but good to have)
					"sqlfluff", -- sql (also linter)
					"shfmt", -- shell

					-- Linters
					"eslint_d", -- js, ts
					"stylelint", -- css, scss
					"golangci-lint", -- go
					"shellcheck", -- shell
					"tflint", -- terraform (also formatter)
					"jq",
					"markdownlint",
					"yamllint",
					"harper_ls",
					"luacheck",
					-- phpstan, -- php (optional static analysis)
					-- Note: Some tools act as both (rubocop, ktlint, sqlfluff, tflint)
					-- Note: Rust linting via rust-analyzer, C# via LSP, Java via PMD/Checkstyle (manual setup often needed)
				},
				auto_update = false,
				run_on_start = true,
			})
		end,
	},
}
