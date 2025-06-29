return {
  'NeogitOrg/neogit',
  dependencies = {
    'nvim-tree/nvim-web-devicons', -- Optional, for icons
    'plenary/plenary.nvim',        -- A common dependency for many plugins
    'sindrets/diffview.nvim',      -- Highly recommended for better diffs
  },
  cmd = 'Neogit',
  keys = {
    -- Keymap to open Neogit status window
    { '<leader>gs', '<cmd>Neogit<CR>', desc = 'Neogit Status' },

    -- Stage/unstage current file (in normal mode within Neogit status)
    -- These are usually default, but good to know
    -- { 's', '<cmd>lua require("neogit").stage_current_file()<CR>', mode = 'n', noremap = true, silent = true, desc = 'Stage Current File' },
    -- { 'u', '<cmd>lua require("neogit").unstage_current_file()<CR>', mode = 'n', noremap = true, silent = true, desc = 'Unstage Current File' },
  },
  opts = {
    disable_hint = true, -- Hide the hint at the bottom (optional)
    integrations = {
      -- If you use nvim-tree, this can be useful
      -- nvimtree = true,
      -- If you use diffview.nvim, this is highly recommended
      diffview = true,
    },
    mappings = {
      -- Global mappings (apply in all Neogit buffers)
      -- These are usually good defaults and you might not need to change them
      -- You can add custom mappings here if you want to override defaults or add new ones.
      -- Examples:
      -- ['gs'] = 'status',
      -- ['gc'] = 'commit',
      -- ['gp'] = 'pull',
      -- ['gP'] = 'push',
      -- ['gb'] = 'branch',
      -- ['gt'] = 'tag',
      -- ['gg'] = 'log',
      -- ['gr'] = 'rebase',
      -- ['gX'] = 'reset_hard', -- Be careful with this!
    },
    -- For status buffer specific mappings
    status = {
      -- This section defines mappings specific to the Neogit status buffer.
      -- These are usually the most frequently used.
      -- 's' and 'u' are for staging/unstaging individual lines/hunks/files
      ['s'] = { '<cmd>lua require("neogit").stage_hunk()<CR>', 'Stage Hunk' },
      ['S'] = { '<cmd>lua require("neogit").stage_file()<CR>', 'Stage File' },
      ['u'] = { '<cmd>lua require("neogit").unstage_hunk()<CR>', 'Unstage Hunk' },
      ['U'] = { '<cmd>lua require("neogit").unstage_file()<CR>', 'Unstage File' },
      ['a'] = { '<cmd>lua require("neogit").stage_all()<CR>', 'Stage All' },
      ['A'] = { '<cmd>lua require("neogit").unstage_all()<CR>', 'Unstage All' },

      -- Commit actions
      ['c'] = { '<cmd>lua require("neogit").commit_with_edit()<CR>', 'Commit' },
      ['C'] = { '<cmd>lua require("neogit").commit_amend()<CR>', 'Commit Amend' },
      ['F'] = { '<cmd>lua require("neogit").commit_fixup()<CR>', 'Commit Fixup' },

      -- Branch actions
      ['b'] = { '<cmd>lua require("neogit").branch_create()<CR>', 'Create Branch' },
      ['B'] = { '<cmd>lua require("neogit").branch_checkout()<CR>', 'Checkout Branch' },

      -- Pull/Push actions
      ['p'] = { '<cmd>lua require("neogit").pull()<CR>', 'Pull' },
      ['P'] = { '<cmd>lua require("neogit").push()<CR>', 'Push' },

      -- Other useful actions
      ['g'] = { '<cmd>lua require("neogit").fetch_all()<CR>', 'Fetch All' },
      ['l'] = { '<cmd>lua require("neogit").log_current_file()<CR>', 'Log File' },
      ['L'] = { '<cmd>lua require("neogit").log_all()<CR>', 'Log All' },
      ['d'] = { '<cmd>lua require("neogit").discard_hunk()<CR>', 'Discard Hunk' },
      ['D'] = { '<cmd>lua require("neogit").discard_file()<CR>', 'Discard File' },
      ['R'] = { '<cmd>lua require("neogit").revert_hunk()<CR>', 'Revert Hunk' },
      ['r'] = { '<cmd>lua require("neogit").refresh_status()<CR>', 'Refresh Status' },

      -- Diffview integration (if enabled)
      ['X'] = { '<cmd>lua require("diffview").open()<CR>', 'Open Diffview' },
    },
    -- For popup/menu specific mappings (e.g., when committing)
    commit_editor = {
      -- Usually, you don't need to change these much.
      -- The default mappings for saving/quitting work well.
    },
  },
}
