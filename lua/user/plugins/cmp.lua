return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",          -- Load when entering insert mode
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",       -- LSP completions
    "hrsh7th/cmp-buffer",         -- Buffer completions
    "hrsh7th/cmp-path",           -- Path completions
    "hrsh7th/cmp-cmdline",        -- Command-line completions
    "L3MON4D3/LuaSnip",           -- Snippet engine
    "saadparwaiz1/cmp_luasnip",   -- Snippet completion source for nvim-cmp
    "rafamadriz/friendly-snippets", -- A collection of snippets
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    -- Load friendly-snippets (optional, but recommended)
    -- This line should be called AFTER LuaSnip is setup/required
    require("luasnip.loaders.from_vscode").lazy_load()

    -- Custom snippets directory (we'll set this up in luasnip.lua more formally)
    -- For now, just ensure LuaSnip knows about it if you create it.
    -- Example: require("luasnip.loaders.from_lua").load({paths = "~/.config/nvim/lua/user/snippets"})

    local has_words_before = function()
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0 and
          vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
    end

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),        -- Main completion trigger
        ["<C-e>"] = cmp.mapping.abort(),               -- Close completion menu
        ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Confirm selection
        -- Tab completion
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif has_words_before() then
            cmp.complete() -- Trigger completion if there are words before cursor
          else
            fallback()  -- Fallback to default Tab behavior (e.g., indent)
          end
        end, { "i", "s" }), -- "i" for insert mode, "s" for select mode (snippets)
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
        { name = "luasnip" }, -- For snippets
        { name = "buffer" },
        { name = "path" },
      }),
      -- Configure how completion items are presented.
      -- See `:help cmp-config.formatting`
      formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)
          -- Kind icons (optional, requires a Nerd Font)
          vim_item.kind = string.format("%s %s", vim_item.kind, vim_item.kind) -- Show kind icon and text
          -- vim_item.kind = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item) -- If using lspkind

          vim_item.menu = ({
            nvim_lsp = "[LSP]",
            luasnip = "[Snip]",
            buffer = "[Buff]",
            path = "[Path]",
          })[entry.source.name]
          return vim_item
        end,
      },
    })

    -- Setup for command-line completion
    cmp.setup.cmdline("/", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "buffer" }, -- Search in current buffer
      },
    })

    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = "path" },
      }, {
        { name = "cmdline" },
      }),
    })

    vim.notify("nvim-cmp configured", vim.log.levels.INFO, { title = "nCmp" })
  end,
}
