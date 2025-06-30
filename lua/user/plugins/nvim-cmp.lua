return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter", -- Load when entering insert mode
  dependencies = {
    -- Snippet Engine
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip", -- nvim-cmp integration for LuaSnip
    "rafamadriz/friendly-snippets",

    -- Completion Sources
    "hrsh7th/cmp-nvim-lsp",    -- LSP completion
    "hrsh7th/cmp-buffer",     -- Buffer words
    "hrsh7th/cmp-path",       -- File paths
    "hrsh7th/cmp-cmdline",  -- Command line completion
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")

    -- Set up nvim-cmp
    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body) -- For `cmp_luasnip`
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
        { name = "cmdline" },
      }),
      formatting = {
        format = function(entry, vim_item)
          -- Add icons to completion items
          local kind = require("nvim-web-devicons").get_icon_by_filetype(entry.source.name)
          vim_item.kind = string.format("%s %s", kind or " ", vim_item.kind)
          return vim_item
        end,
      },
      -- You can add more customization here, like a border for the completion menu
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
    })

    -- Set up command line completion
    cmp.setup.cmdline({ "/", "?" }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "buffer" },
      },
    })

    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = "cmdline" },
      }),
    })

    -- Load friendly-snippets for LuaSnip if you want common snippets
    require("luasnip.loaders.from_vscode").lazy_load()
  end,
}
