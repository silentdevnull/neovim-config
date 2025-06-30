return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",                     -- Or build = function() vim.cmd("TSUpdate") end
  event = { "BufReadPost", "BufNewFile" }, -- Load on opening a file
  dependencies = {
    -- For textobjects, if you want them (highly recommended)
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  config = function()
    require("nvim-treesitter.configs").setup({
      -- A list of parser names, or "all" (takes longer to install)
      ensure_installed = {
        "c",
        "lua",
        "vim",
        "vimdoc",
        "query",
        "javascript",
        "typescript",
        "tsx",
        "html",
        "css",
        "json",
        "yaml",
        "markdown",
        "markdown_inline",
        "bash",
        "go",
        "dockerfile",
      },

      sync_install = false,
      auto_install = true,

      highlight = {
        enable = true, -- Enable syntax highlighting
        additional_vim_regex_highlighting = false,
      },

      indent = {
        enable = true,
        -- disable = { "yaml" } -- Disable indentation for specific languages
      },

      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
            ["aa"] = "@parameter.outer",
            ["ia"] = "@parameter.inner",
          },
        },
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            ["]m"] = "@function.outer",
            ["]c"] = "@class.outer",
          },
          goto_next_end = {
            ["]M"] = "@function.outer",
            ["]C"] = "@class.outer",
          },
          goto_previous_start = {
            ["[m"] = "@function.outer",
            ["[c"] = "@class.outer",
          },
          goto_previous_end = {
            ["[M"] = "@function.outer",
            ["[C"] = "@class.outer",
          },
        },
      },

      -- Other modules (see :h nvim-treesitter-modules)
      -- e.g., playground, incremental_selection, etc.
      -- incremental_selection = {
      --   enable = true,
      --   keymaps = {
      --     init_selection = "<CR>",
      --     node_incremental = "<CR>",
      --     scope_incremental = "<S-CR>",
      --     node_decremental = "<BS>",
      --   },
      -- },
    })

    vim.notify("nvim-treesitter configured", vim.log.levels.INFO)
  end,
  keys = {
    {
      "<leader>ti",
      function()
        vim.cmd("TSInstallInfo")
      end,
      desc = "Treesitter Info",
    },
    { "<leader>tp", function() vim.cmd("TSPlaygroundToggle") end, desc = "Treesitter Playground" },
  },
}
