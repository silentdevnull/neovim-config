# Consolidated Neovim Keybindings

The **Leader key** is set to `Space`.

| Mode   | Keybinding      | Plugin/Feature        | Action / Description                               |
| :----- | :-------------- | :-------------------- | :------------------------------------------------- |
| **Global Core Keymaps (`lua/user/core/keymaps.lua`)** |
| N      | `<C-h>`         | Window Navigation     | Navigate to window left                            |
| N      | `<C-j>`         | Window Navigation     | Navigate to window down                            |
| N      | `<C-k>`         | Window Navigation     | Navigate to window up                              |
| N      | `<C-l>`         | Window Navigation     | Navigate to window right                           |
| N      | `<C-Up>`        | Window Resize         | `:resize +2<CR>` (Increase window height)          |
| N      | `<C-Down>`      | Window Resize         | `:resize -2<CR>` (Decrease window height)          |
| N      | `<C-Left>`      | Window Resize         | `:horizontal resize -2<CR>` (Decrease window width)|
| N      | `<C-Right>`     | Window Resize         | `:horizontal resize +2<CR>` (Increase window width)|
| N      | `<S-l>`         | Buffer Navigation     | `:bnext<CR>` (Next buffer)                         |
| N      | `<S-h>`         | Buffer Navigation     | `:bprevious<CR>` (Previous buffer)                   |
| N      | `<leader>nh`    | Search                | `:nohl<CR>` (Clear search highlights)              |
| N      | `<leader>q`     | Buffer Management     | `:bdelete<CR>` (Close current buffer)              |
| N      | `<leader>Q`     | Buffer Management     | `:bdelete!<CR>` (Force close current buffer)       |
| N      | `<leader>w`     | File Operations       | `:write<CR>` (Write/save file)                     |
| N      | `<leader>wq`    | File Operations       | `:wq<CR>` (Write/save and quit)                    |
| C      | `q<CR>`         | Custom Quit           | `:qall<CR>` (if cmdline is just "q")               |
| C      | `q!<CR>`        | Custom Quit           | `:qall!<CR>` (if cmdline is just "q!")             |
| C      | `w<CR>`         | Custom Save           | `:wall<CR>` (if cmdline is just "w")               |
| C      | `w!<CR>`        | Custom Save           | `:wall!<CR>` (if cmdline is just "w!")             |
| I      | `jlw`           | Custom Save           | `<Esc>:wall<CR>` (Save All)                         |
| N      | `jlw`           | Custom Save           | `:wall<CR>` (Save All)                             |
| I      | `jlwq`          | Custom Save & Quit    | `<Esc>:wqall<CR>` (Save All & Quit All)             |
| N      | `jlwq`          | Custom Save & Quit    | `:wqall<CR>` (Save All & Quit All)                 |
| I      | `jj`            | Custom Quit           | `<Esc>:q<CR>` (becomes `:qall` via C map)          |
| N      | `<leader>qq`    | Custom Quit           | `:q<CR>` (becomes `:qall` via C map)               |
| N      | `<C-d>`         | Scrolling             | `<C-d>zz` (Scroll down, center cursor)             |
| N      | `<C-u>`         | Scrolling             | `<C-u>zz` (Scroll up, center cursor)               |
| N      | `n`             | Search Navigation     | `nzz` (Next search result, center cursor)          |
| N      | `N`             | Search Navigation     | `Nzz` (Prev search result, center cursor)          |
| V      | `J`             | Visual Mode           | Move selected lines down                           |
| V      | `K`             | Visual Mode           | Move selected lines up                             |
| X      | `<leader>p`     | Clipboard             | Paste without yanking selection                    |
| N, V   | `<leader>y`     | Clipboard             | Yank to system clipboard                           |
| N      | `<leader>Y`     | Clipboard             | Yank current line to system clipboard              |
| **Theme Switching (`lua/user/utils/themes.lua` via `keymaps.lua`)** |
| N      | `<leader>ttn`  | Nightfox Themes       | Set Nightfox theme                                 |
| N      | `<leader>ttd`  | Nightfox Themes       | Set Dayfox theme                                   |
| N      | `<leader>tta`  | Nightfox Themes       | Set Dawnfox theme                                  |
| N      | `<leader>ttu`  | Nightfox Themes       | Set Duskfox theme                                  |
| N      | `<leader>tto`  | Nightfox Themes       | Set Nordfox theme                                  |
| N      | `<leader>ttc`  | Nightfox Themes       | Set Carbonfox theme                                |
| N      | `<leader>ttt`  | Nightfox Themes       | Set Terafox theme                                  |
| N      | `<leader>ttl`  | Nightfox Themes       | Set Alphafox theme                                 |
| N      | `<leader>tt]`  | Nightfox Themes       | Cycle to next Nightfox theme                       |
| N      | `<leader>tt[`  | Nightfox Themes       | Cycle to prev Nightfox theme                       |
| **LSP Keymaps (`lua/user/core/lsp_keymaps.lua` - On LSP Attach)** |
| N      | `gD`          | LSP Navigation        | Go to Declaration                                  |
| N      | `gd`          | LSP Navigation        | Go to Definition                                   |
| N      | `K`           | LSP Info              | Hover Documentation                                |
| N      | `gi`          | LSP Navigation        | Go to Implementation                               |
| N      | `<leader>ls`  | LSP Info              | Signature Help                                     |
| N      | `<leader>lt`  | LSP Navigation        | Go to Type Definition                              |
| N      | `<leader>lr`  | LSP Actions           | Rename Symbol                                      |
| N, V   | `<leader>la`  | LSP Actions           | Code Action                                        |
| N      | `gr`          | LSP Navigation        | Go to References                                   |
| N      | `<leader>lf`  | LSP Formatting        | Format Buffer (LSP fallback)                       |
| N      | `[d`          | LSP Diagnostics       | Previous Diagnostic                                |
| N      | `]d`          | LSP Diagnostics       | Next Diagnostic                                    |
| N      | `<leader>le`  | LSP Diagnostics       | Show Line Diagnostics                              |
| N      | `<leader>lq`  | LSP Diagnostics       | Diagnostics to Loclist                             |
| N      | `<leader>lwa` | LSP Workspace         | Add Workspace Folder                               |
| N      | `<leader>lwr` | LSP Workspace         | Remove Workspace Folder                            |
| N      | `<leader>lwl` | LSP Workspace         | List Workspace Folders                             |
| **Plugin: Neo-tree (`lua/user/plugins/neotree.lua`)** |
| N      | `<leader>ee`  | Neo-tree              | Toggle NeoTree (cwd)                               |
| N      | `<leader>ef`  | Neo-tree              | Find current file in NeoTree                       |
| N      | `<leader>fe`  | Neo-tree              | Explorer NeoTree (file dir)                        |
| N      | `<leader>ge`  | Neo-tree              | Git Explorer NeoTree                               |
| N      | `<leader>be`  | Neo-tree              | Buffer Explorer NeoTree                            |
| *Neo-tree Window* | `j`/`k`     | Neo-tree Navigation   | Navigate up/down                                   |
| *Neo-tree Window* | `h`/`l`/`o`/`<CR>` | Neo-tree Navigation | Collapse/Expand directory or open file             |
| *Neo-tree Window* | `a` / `A`   | Neo-tree File Ops     | Add file / directory                               |
| *Neo-tree Window* | `d`         | Neo-tree File Ops     | Delete                                             |
| *Neo-tree Window* | `r`         | Neo-tree File Ops     | Rename                                             |
| *Neo-tree Window* | `<leader>h` | Neo-tree View         | Toggle hidden files                                |
| *Neo-tree Window* | `q`/`<Esc>` | Neo-tree UI           | Close Neo-tree window                              |
| *Neo-tree Window* | `?`         | Neo-tree UI           | Show help                                          |
| **Plugin: Telescope (`lua/user/plugins/telescope.lua`)** |
| N      | `<leader>ff`  | Telescope             | Find Files                                         |
| N      | `<leader>fg`  | Telescope             | Live Grep                                          |
| N      | `<leader>fb`  | Telescope             | Find Buffers                                       |
| N      | `<leader>fh`  | Telescope             | Help Tags                                          |
| N      | `<leader>fo`  | Telescope             | Old Files (History)                                |
| N      | `<leader>fz`  | Telescope             | Fuzzy Find (rg, hidden)                            |
| N      | `<leader>gf`  | Telescope             | Git Files                                          |
| N      | `<leader>gc`  | Telescope             | Git Commits                                        |
| N      | `<leader>gs`  | Telescope             | Git Status                                         |
| *Telescope (Insert)* | `<C-j>`/`<C-k>` | Telescope Navigation | Navigate results                                   |
| *Telescope (Insert)* | `<CR>`      | Telescope Actions     | Select item                                        |
| *Telescope (Insert)* | `<Esc>`     | Telescope UI          | Close Telescope                                    |
| **Plugin: Undotree (`lua/user/plugins/undotree.lua`)** |
| N      | `<leader>u`   | Undotree              | Toggle Undotree                                    |
| **Plugin: Treesitter (`lua/user/plugins/treesitter.lua`)** |
| N      | `<leader>ti`  | Treesitter            | Treesitter Install Info                            |
| N      | `<leader>tp`  | Treesitter            | Toggle Treesitter Playground                       |
| (Op/Vis) | `af`/`if`   | Treesitter Textobj    | Around/Inner function                              |
| (Op/Vis) | `ac`/`ic`   | Treesitter Textobj    | Around/Inner class                                 |
| **Plugin: Trouble (`lua/user/plugins/trouble.lua`)** |
| N      | `<leader>xx`  | Trouble               | Toggle Trouble (Diagnostics)                       |
| N      | `<leader>xw`  | Trouble               | Workspace Diagnostics                              |
| N      | `<leader>xd`  | Trouble               | Document Diagnostics                               |
| N      | `<leader>xl`  | Trouble               | Location List                                      |
| N      | `<leader>xq`  | Trouble               | Quickfix List                                      |
| N      | `gR`          | Trouble               | LSP References                                     |
| **Plugin: Conform (`lua/user/plugins/conform.lua`)** |
| N, V   | `<leader>cf`  | Conform               | Format buffer/selection                            |
| **Plugin: DAP - Debugger (`lua/user/core/dap_keymaps.lua`)** |
| N      | `<leader>dc`  | DAP                   | Continue session                                   |
| N      | `<leader>dj`  | DAP                   | Step Over                                          |
| N      | `<leader>dk`  | DAP                   | Step Into                                          |
| N      | `<leader>do`  | DAP                   | Step Out                                           |
| N      | `<leader>dt`  | DAP                   | Terminate session                                  |
| N      | `<leader>dr`  | DAP                   | Open REPL                                          |
| N      | `<leader>dl`  | DAP                   | Run Last configuration                             |
| N      | `<leader>db`  | DAP                   | Toggle Breakpoint                                  |
| N      | `<leader>dB`  | DAP                   | Set Conditional Breakpoint (prompts)               |
| N      | `<leader>lp`  | DAP                   | Set Log Point (prompts)                            |
| N      | `<leader>du`  | DAP UI                | Toggle DAP UI                                      |
| N      | `<leader>de`  | DAP                   | Evaluate expression                                |
| N      | `<leader>ds`  | DAP                   | View Scopes                                        |
| N      | `<leader>dsc` | DAP                   | Select launch configuration                        |
| N      | `<leader>dss` | DAP                   | Get current DAP session info                       |
| **Plugin: Gitsigns (`lua/user/plugins/gitsigns.lua`)** |
| N      | `]h`          | Gitsigns Navigation   | Go to next hunk                                    |
| N      | `[h`          | Gitsigns Navigation   | Go to previous hunk                                |
| N, V   | `<leader>hs`  | Gitsigns Actions      | Stage hunk                                         |
| N, V   | `<leader>hr`  | Gitsigns Actions      | Reset hunk                                         |
| N      | `<leader>hS`  | Gitsigns Actions      | Stage buffer                                       |
| N      | `<leader>hu`  | Gitsigns Actions      | Undo stage hunk                                    |
| N      | `<leader>hR`  | Gitsigns Actions      | Reset buffer                                       |
| N      | `<leader>hp`  | Gitsigns Actions      | Preview hunk                                       |
| N      | `<leader>hb`  | Gitsigns Actions      | Blame line (full)                                  |
| N      | `<leader>htb` | Gitsigns Actions      | Toggle current line blame                          |
| O, X   | `ih`          | Gitsigns Textobj      | Select hunk                                        |
| **Plugin: Comment.nvim (`lua/user/plugins/comment.lua`)** |
| N      | `gcc`         | Comment.nvim          | Toggle current line comment                        |
| N, V   | `gc`          | Comment.nvim          | Toggle comment for motion/selection                |
| **Plugin: nvim-surround (`lua/user/plugins/surround.lua`)** |
| N      | `ysiw<char>`  | nvim-surround         | Surround Inner Word with `<char>` (e.g., `ysiw"`)   |
| N      | `cs<old><new>`| nvim-surround         | Change Surrounding `<old>` to `<new>` (e.g., `cs"'`)|
| N      | `ds<char>`    | nvim-surround         | Delete Surrounding `<char>` (e.g., `ds"`)          |
| **Plugin: Todo Comments (`lua/user/plugins/todo_comments.lua`)** |
| N      | `<leader>ft`  | Todo Comments         | Find Todos (Telescope)                             |
| N      | `<leader>fT`  | Todo Comments         | Find Specific Todos (Telescope)                    |
| **Plugin: Toggleterm (`lua/user/plugins/toggleterm.lua`)** |
| N      | `<c-\>`       | Toggleterm            | Open/Toggle floating terminal (default mapping)    |
| N      | `<leader>gg`  | Toggleterm (Custom)   | Toggle LazyGit terminal                            |
| N      | `<leader>wd`  | Toggleterm (Custom)   | Toggle Wrangler Dev terminal                       |
| N      | `<leader>wp`  | Toggleterm (Custom)   | Run Wrangler Publish                               |
| T      | `<esc>` / `jk`| Toggleterm            | Exit terminal mode to Normal mode                  |
| **Plugin: vim-tmux-navigator (`lua/user/plugins/tmux.lua`)** |
| N, T   | `<c-h/j/k/l>` | Tmux Navigator        | Navigate Neovim splits & Tmux panes                |
| **Plugin: nvim-cmp & LuaSnip (Insert Mode)** |
| I, S   | `<C-Space>`   | nvim-cmp              | Trigger completion                                 |
| I, S   | `<CR>`        | nvim-cmp              | Confirm selected completion                        |
| I, S   | `<Tab>`       | nvim-cmp / LuaSnip    | Select next / Expand or Jump snippet / Complete    |
| I, S   | `<S-Tab>`     | nvim-cmp / LuaSnip    | Select previous / Jump snippet backward            |
| I      | `<C-e>`       | nvim-cmp              | Abort completion                                   |
| I      | `<C-b>`       | nvim-cmp              | Scroll documentation up                            |
| I      | `<C-f>`       | nvim-cmp              | Scroll documentation down                          |
| **Plugin: Linters (`lua/user/plugins/linters.lua`)** |
| N      | `<leader>ll`  | nvim-lint             | Lint current buffer                                |
| **Plugin: Auto Session (`lua/user/plugins/auto_session.lua`)** |
| N      | `<leader>sl`  | auto-session          | Load Session                                       |
| N      | `<leader>ss`  | auto-session          | Save Session                                       |

*Note: "Op/Vis" means Operator-pending and Visual modes. "C" means Command-line mode. "T" means Terminal mode.*
*Keybindings inside plugin windows (like Telescope, Neo-tree) are specific to when those windows are active.*

