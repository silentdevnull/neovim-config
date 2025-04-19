-- ~/.config/nvim/lua/plugins/completion.lua

return {
  -- Autocompletion engine
  {
    "hrsh7th/nvim-cmp",
    -- Load dependency cmp-nvim-lsp early
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      -- Add other completion sources like snippets here if you use them
      -- "L3MON4D3/LuaSnip",
      -- "saadparwaiz1/cmp_luasnip",
    },
    event = "InsertEnter", -- Load nvim-cmp when entering insert mode
    config = function()
      local cmp = require("cmp")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- If you have LuaSnip or another snippet engine:
      -- local luasnip = require("luasnip")

      cmp.setup({
        snippet = {
          -- REQUIRED - you must specify a snippet engine
          -- Uncomment the following line if you have luasnip setup
          -- expand = function(args)
          --   luasnip.lsp_expand(args.body)
          -- end,
        },
        window = {
          -- completion = cmp.config.window.bordered(),
          -- documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(), -- Trigger completion
          ["<C-e>"] = cmp.mapping.abort(), -- Close completion
          ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept selected suggestion
          -- Tab completion (optional, adjust if you use snippets)
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            -- Uncomment the following lines if you have luasnip and want Tab integration
            -- elseif luasnip.expand_or_jumpable() then
            --   luasnip.expand_or_jump()
            else
              fallback() -- Fallback to default Tab behavior
            end
          end, { "i", "s" }), -- i = insert mode, s = select mode
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            -- Uncomment the following lines if you have luasnip and want Shift-Tab integration
            -- elseif luasnip.jumpable(-1) then
            --   luasnip.jump(-1)
            else
              fallback() -- Fallback to default Shift-Tab behavior
            end
          end, { "i", "s" }),
        }),
        -- Sources for completion
        sources = cmp.config.sources({
          { name = "nvim_lsp" }, -- Source for LSP completions
          -- Add other sources here, e.g., snippets, buffer, path
          -- { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        }),

        -- Pass LSP capabilities (important!)
        -- This is done globally in the lspconfig setup now,
        -- but ensuring cmp knows about them is good practice.
        -- Note: The actual capabilities object is generated *before* this setup
        -- and passed to each LSP server in your lspconfig file.
        -- We reference it here mainly for clarity and potential future use
        -- within cmp specific settings if needed.
        experimental = {
          ghost_text = true, -- Optional: Show inline completion hints
        },
      })

      -- Optional: If you want to set up completion for specific filetypes or commands
      -- cmp.setup.filetype('gitcommit', {
      --   sources = cmp.config.sources({
      --     { name = 'cmp_git' }, -- requires hrsh7th/cmp-git
      --   }, {
      --     { name = 'buffer' },
      --   })
      -- })

      -- Use buffer source for `/` (commands) and `?` (search)
      -- cmp.setup.cmdline({ '/', '?' }, {
      --   mapping = cmp.mapping.preset.cmdline(),
      --   sources = {
      --     { name = 'buffer' }
      --   }
      -- })

      -- Use path source for `:` (commands)
      -- cmp.setup.cmdline(':', {
      --   mapping = cmp.mapping.preset.cmdline(),
      --   sources = cmp.config.sources({
      --     { name = 'path' }
      --   }, {
      --     { name = 'cmdline' } -- requires hrsh7th/cmp-cmdline
      --   })
      -- })
    end,
  },

  -- This plugin bridges nvim-cmp and nvim-lspconfig
  {
    "hrsh7th/cmp-nvim-lsp",
    -- No specific config needed here usually,
    -- its main job is providing the 'nvim_lsp' source
    -- and the capabilities object used in lspconfig setup.
  },

  -- Optional: Other completion sources (add these to dependencies and sources above if used)
  -- { "hrsh7th/cmp-buffer" },
  -- { "hrsh7th/cmp-path" },
  -- { "hrsh7th/cmp-cmdline" },
  -- { "L3MON4D3/LuaSnip" }, -- Snippet engine
  -- { "saadparwaiz1/cmp_luasnip" }, -- Snippet source for nvim-cmp
  -- { "rafamadriz/friendly-snippets" }, -- Optional: A collection of snippets
}

