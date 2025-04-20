return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      -- Add other TS-dependent plugins here if needed
    },
    config = function()
      require("nvim-treesitter.configs").setup({
        -- Ensure parsers are installed for requested languages + common ones
        ensure_installed = {
          "bash", "c", "c_sharp", "css", "go", "gomod", "gosum", "html", "java",
          "javascript", "json", "kotlin", "lua", "markdown", "markdown_inline",
          "perl", "php", "python", "query", "regex", "ruby", "rust", "scss",
          "sql", "swift", "terraform", "toml", "tsx", "typescript", "vim",
          "vimdoc", "xml", "yaml",
        },
        sync_install = false, -- install synchronously (blocks UI)
        auto_install = true, -- automatically install missing parsers when entering buffer
        highlight = {
          enable = true,
          -- Disable highlighting for very large files to prevent slowdowns
          disable = function(lang, buf)
              local max_filesize = 100 * 1024 -- 100 KB
              local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
              if ok and stats and stats.size > max_filesize then
                  return true
              end
          end,
          additional_vim_regex_highlighting = false, -- Use Treesitter only
        },
        indent = { enable = true }, -- Use treesitter based indentation
        textobjects = {
          select = {
            enable = true,
            lookahead = true, -- Automatically jump forward to textobj
            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ["aa"] = "@parameter.outer",
              ["ia"] = "@parameter.inner",
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
              ["al"] = "@loop.outer", -- Example: Add loop text objects
              ["il"] = "@loop.inner",
            },
          },
          move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = { ["]m"] = "@function.outer", ["]]"] = "@class.outer" },
            goto_next_end = { ["]M"] = "@function.outer", ["]["] = "@class.outer" },
            goto_previous_start = { ["[m"] = "@function.outer", ["[["] = "@class.outer" },
            goto_previous_end = { ["[M"] = "@function.outer", ["[]"] = "@class.outer" },
          },
          -- swap = { -- Optional: Requires nvim-treesitter-textobjects
          --   enable = true,
          --   swap_next = { ["<leader>a"] = "@parameter.inner" },
          --   swap_previous = { ["<leader>A"] = "@parameter.inner" },
          -- },
        },
      })
    end,
  },
}
