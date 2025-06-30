-- lua/community.lua (or wherever you keep your plugin configurations)

return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.8',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local telescope = require('telescope')
    local actions = require('telescope.actions')
    local builtin = require('telescope.builtin')

    telescope.setup({
      defaults = {
        -- Default settings for all pickers
        vimgrep_arguments = {
          'rg',
          '--color=never',
          '--no-heading',
          '--with-filename',
          '--line-number',
          '--column',
          '--smart-case',
        },
        prompt_prefix = '   ',
        selection_caret = ' ',
        entry_prefix = '  ',
        initial_mode = 'insert',
        selection_strategy = 'current_buffer',
        set_env = { ['COLORTERM'] = 'truecolor' }, -- This can be useful for true color support
        file_sorter = require('telescope.sorters').get_fuzzy_file,
        file_ignore_patterns = { '%.git/', 'node_modules/' }, -- Ignore these directories
        -- configure the loading of themes
        themes = {
          -- default = {
          --   prompt_prefix = " >",
          --   selection_caret = " ",
          --   entry_prefix = "  ",
          -- },
          -- zenn = {
          --   prompt_prefix = "  ",
          --   selection_caret = " ",
          --   entry_prefix = "  ",
          -- },
        },
        mappings = {
          i = {
            ['<C-n>'] = actions.cycle_history_next,
            ['<C-p>'] = actions.cycle_history_prev,
            ['<C-j>'] = actions.move_selection_next,
            ['<C-k>'] = actions.move_selection_previous,
            ['<C-c>'] = actions.close,
            ['<CR>'] = actions.select_default,
            ['<C-x>'] = actions.select_horizontal,
            ['<C-v>'] = actions.select_vertical,
            ['<C-t>'] = actions.select_tab,
            ['<C-u>'] = actions.preview_scrolling_up,
            ['<C-d>'] = actions.preview_scrolling_down,
          },
          n = {
            ['<esc>'] = actions.close,
            ['<CR>'] = actions.select_default,
            ['<C-x>'] = actions.select_horizontal,
            ['<C-v>'] = actions.select_vertical,
            ['<C-t>'] = actions.select_tab,
            ['<C-u>'] = actions.preview_scrolling_up,
            ['<C-d>'] = actions.preview_scrolling_down,
            ['j'] = actions.move_selection_next,
            ['k'] = actions.move_selection_previous,
            ['?'] = actions.which_key,
          },
        },
      },
      pickers = {
        -- Specific configurations for individual pickers
        find_files = {
          hidden = true, -- Show hidden files
          find_command = { 'rg', '--files', '--hidden', '--glob', '!**/.git/*' },
        },
        live_grep = {
          theme = 'ivy',
        },
      },
      extensions = {
        -- You can configure extensions here if you have any
        -- For example, for `telescope-fzf-native.nvim` if you install it:
        -- fzf = {
        --   override_generic_sorter = true,
        --   override_file_sorter = true,
        -- },
      },
    })

    -- Enable extensions
    -- If you install `telescope-fzf-native.nvim`, you would uncomment this:
    -- pcall(require('telescope').load_extension, 'fzf')
  end,
}
