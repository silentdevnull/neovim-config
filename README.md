# Neovim Configuration

This is a highly customized Neovim configuration designed for a productive development workflow. It leverages `lazy.nvim` for plugin management and is structured with Lua for clarity and performance. This setup includes robust LSP support, autocompletion, snippets, formatting, linting, debugging, an enhanced UI, and various utility plugins.

The current date for this configuration snapshot is 5/16/2025.

## Directory Structure

The configuration is organized as follows within your `~/.config/nvim/` directory (or your OS equivalent):

~/.config/nvim/
├── init.lua        # Main entry point, sets leader key, loads core modules
├── lua/
│   └── user/       # Namespace for all custom Lua modules
│       ├── core/   # Core configuration files
│       │   ├── lazy.lua                # lazy.nvim plugin manager setup
│       │   ├── keymaps.lua             # Global Neovim keybindings
│       │   ├── options.lua             # General Neovim options (set, opt)
│       │   ├── lsp_keymaps.lua         # Keymaps specific to LSP on_attach
│       │   ├── dap_manager.lua         # Debug Adapter Protocol orchestrator
│       │   ├── dap_keymaps.lua         # DAP specific keybindings
│       │   └── dap_adapters_config.lua # Manual DAP adapter configurations
│       ├── utils/  # Utility modules
│       │   ├── themes.lua              # Nightfox theme switcher
│       │   └── lspconfig_manager.lua   # LSP server setup logic
│       ├── snippets/ # Custom snippets for LuaSnip
│       │   ├── all.lua                 # Snippets for all filetypes
│       │   ├── go.lua                  # Go specific snippets
│       │   └── lua.lua                 # Lua specific snippets
│       └── plugins/  # Configuration for each plugin
│           ├── autopairs.lua
│           ├── cmp.lua                 # nvim-cmp (completion)
│           ├── colorizer.lua
│           ├── comment.lua
│           ├── conform.lua             # Formatting
│           ├── dap.lua                 # nvim-dap & nvim-dap-ui
│           ├── gitsigns.lua
│           ├── indent_blankline.lua
│           ├── linters.lua             # nvim-lint
│           ├── lualine.lua
│           ├── luasnip.lua
│           ├── mason-lspconfig.lua
│           ├── mason.lua
│           ├── neotree.lua             # File explorer
│           ├── nightfox.lua            # Colorscheme
│           ├── nvim_lspconfig_plugin.lua # Base nvim-lspconfig plugin entry
│           ├── surround.lua
│           ├── telescope.lua
│           ├── tmux.lua                # vim-tmux-navigator
│           ├── todo_comments.lua
│           ├── toggleterm.lua
│           ├── treesitter.lua
│           ├── trouble.lua
│           └── undotree.lua
├── lazy-lock.json  # Automatically managed by lazy.nvim, locks plugin versions
└── stylua.toml     # Configuration for the Stylua Lua formatter


## Plugin Management: `lazy.nvim`

This configuration uses [folke/lazy.nvim](https://github.com/folke/lazy.nvim) for plugin management.
-   Plugins are defined as individual `*.lua` files within `lua/user/plugins/`.
-   `lazy.nvim` is configured in `lua/user/core/lazy.lua` to import all specs from `user.plugins`.
-   It automatically installs missing plugins and can update them.
-   Manage plugins using the `:Lazy` command.

## Core Features

-   **LSP Integration**: Comprehensive language server support via `nvim-lspconfig`, managed by `mason.nvim` and `mason-lspconfig.nvim`. Custom logic in `lspconfig_manager.lua` ensures servers are only set up if their executables are found.
-   **Autocompletion**: Powered by `nvim-cmp` with sources for LSP, snippets, buffers, and paths.
-   **Snippets**: `LuaSnip` engine with support for `friendly-snippets` and custom Lua snippets located in `lua/user/snippets/`.
-   **Formatting**: Handled by `conform.nvim`, which checks for available formatters (e.g., Prettier, Stylua, Ruff, Black) and applies them, often on save.
-   **Linting**: Asynchronous linting via `nvim-lint`, configured to use available linters (e.g., ESLint, ShellCheck, Ruff, Luacheck).
-   **Debugging**: Uses `nvim-dap` and `nvim-dap-ui`. Adapters are configured manually in `dap_adapters_config.lua` with checks for debugger executables.
-   **Syntax Highlighting**: Enhanced via `nvim-treesitter`.
-   **File Explorer**: `neo-tree.nvim` is used, configured to open when Neovim starts with a directory argument (e.g., `nvim .`).
-   **Colorscheme**: `nightfox.nvim` with easy theme switching.

## Installed Plugins

Here's a list of the primary plugins used in this configuration:

**Core & Plugin Management:**
-   `folke/lazy.nvim`: Plugin manager.

**Language Support & Development Tools:**
-   `neovim/nvim-lspconfig`: LSP configuration helper.
-   `williamboman/mason.nvim`: Manages LSP servers, DAP servers, linters, formatters.
-   `williamboman/mason-lspconfig.nvim`: Integrates Mason with nvim-lspconfig.
-   `nvim-treesitter/nvim-treesitter`: Advanced syntax highlighting and code parsing.
-   `nvim-treesitter/nvim-treesitter-textobjects`: Text objects based on Treesitter nodes.
-   `hrsh7th/nvim-cmp`: Autocompletion engine.
    -   `hrsh7th/cmp-nvim-lsp`
    -   `hrsh7th/cmp-buffer`
    -   `hrsh7th/cmp-path`
    -   `hrsh7th/cmp-cmdline`
    -   `saadparwaiz1/cmp_luasnip`
-   `L3MON4D3/LuaSnip`: Snippet engine.
-   `rafamadriz/friendly-snippets`: Collection of common snippets.
-   `stevearc/conform.nvim`: Formatting plugin.
-   `mfussenegger/nvim-lint`: Asynchronous linting plugin.
-   `mfussenegger/nvim-dap`: Debug Adapter Protocol client.
-   `rcarriga/nvim-dap-ui`: UI for nvim-dap.
    -   `nvim-neotest/nvim-nio`: Dependency for nvim-dap-ui.

**User Interface & UX:**
-   `EdenEast/nightfox.nvim`: Colorscheme.
-   `nvim-neo-tree/neo-tree.nvim`: File explorer.
    -   `MunifTanjim/nui.nvim`: UI component library (dependency for Neo-tree).
-   `nvim-lualine/lualine.nvim`: Status line.
-   `nvim-tree/nvim-web-devicons`: Icons for various UI elements.
-   `lukas-reineke/indent-blankline.nvim`: Indentation guides.
-   `folke/trouble.nvim`: Pretty list for diagnostics, references, etc.
-   `NvChad/nvim-colorizer.lua`: Displays actual colors for color codes.
-   `akinsho/toggleterm.nvim`: Manages terminal windows inside Neovim.

**Editing Enhancements & Utilities:**
-   `windwp/nvim-autopairs`: Automatically inserts and manages closing pairs.
-   `windwp/nvim-ts-autotag`: Automatically renames/closes HTML/XML tags.
-   `numToStr/Comment.nvim`: Smart commenting.
-   `kylechui/nvim-surround`: Add, change, delete surrounding pairs.
-   `mbbill/undotree`: Visualizes undo history.
-   `nvim-telescope/telescope.nvim`: Fuzzy finder.
    -   `nvim-telescope/telescope-fzf-native.nvim`: Optional FZF native sorter for Telescope.
-   `folke/todo-comments.nvim`: Highlights and lists TODO comments.
-   `lewis6991/gitsigns.nvim`: Git integration in the sign column.
-   `christoomey/vim-tmux-navigator`: Seamless navigation between Neovim splits and Tmux panes.
-   `nvim-lua/plenary.nvim`: Utility library (dependency for many plugins).

## Keybindings

The **Leader key** is set to `Space`.

### Global Keymappings (`lua/user/core/keymaps.lua`)

| Mode   | Keybinding      | Action                                     | Description                       |
| :----- | :-------------- | :----------------------------------------- | :-------------------------------- |
| N      | `<C-h>`         | Window left                                | Navigate to window left           |
| N      | `<C-j>`         | Window down                                | Navigate to window down           |
| N      | `<C-k>`         | Window up                                  | Navigate to window up             |
| N      | `<C-l>`         | Window right                               | Navigate to window right          |
| N      | `<C-Up>`        | `:resize +2<CR>`                           | Increase window height            |
| N      | `<C-Down>`      | `:resize -2<CR>`                           | Decrease window height            |
| N      | `<C-Left>`      | `:horizontal resize -2<CR>`                | Decrease window width             |
| N      | `<C-Right>`     | `:horizontal resize +2<CR>`                | Increase window width             |
| N      | `<S-l>`         | `:bnext<CR>`                               | Next buffer                       |
| N      | `<S-h>`         | `:bprevious<CR>`                           | Previous buffer                   |
| N      | `<leader>nh`    | `:nohl<CR>`                                | Clear search highlights           |
| N      | `<leader>q`     | `:bdelete<CR>`                             | Close current buffer              |
| N      | `<leader>Q`     | `:bdelete!<CR>`                            | Force close current buffer        |
| N      | `<leader>w`     | `:write<CR>`                               | Write (save) file                 |
| N      | `<leader>wq`    | `:wq<CR>`                                  | Write (save) and quit             |
| C      | `q<CR>`         | `:qall<CR>` (if cmdline is just "q")       | Quit All (custom)                 |
| C      | `q!<CR>`        | `:qall!<CR>` (if cmdline is just "q!")     | Force Quit All (custom)           |
| C      | `w<CR>`         | `:wall<CR>` (if cmdline is just "w")       | Write All (custom)                |
| C      | `w!<CR>`        | `:wall!<CR>` (if cmdline is just "w!")     | Force Write All (custom)          |
| I      | `jlw`           | `<Esc>:wall<CR>`                           | Save All (Insert Mode)            |
| N      | `jlw`           | `:wall<CR>`                                | Save All (Normal Mode)            |
| I      | `jlwq`          | `<Esc>:wqall<CR>`                          | Save All & Quit All (Insert Mode) |
| N      | `jlwq`          | `:wqall<CR>`                               | Save All & Quit All (Normal Mode)|
| I      | `jj`            | `<Esc>:q<CR>` (becomes `:qall` via C map)  | Exit Insert & Quit All            |
| N      | `<leader>qq`    | `:q<CR>` (becomes `:qall` via C map)       | Leader Quick Quit All             |
| N      | `<C-d>`         | `<C-d>zz`                                   | Scroll down, center cursor        |
| N      | `<C-u>`         | `<C-u>zz`                                   | Scroll up, center cursor          |
| N      | `n`             | `nzz`                                      | Next search result, center cursor |
| N      | `N`             | `Nzz`                                      | Prev search result, center cursor |
| V      | `J`             | Move selected lines down                   | Move selected lines down          |
| V      | `K`             | Move selected lines up                     | Move selected lines up            |
| X      | `<leader>p`     | Paste without yanking selection            | Paste without yanking selection   |
| N, V   | `<leader>y`     | Yank to system clipboard                   | Yank to system clipboard          |
| N      | `<leader>Y`     | Yank current line to system clipboard      | Yank line to system clipboard     |
| N      | `<leader>ttn`  | Set Nightfox theme                         | Theme: Nightfox                   |
| N      | `<leader>ttd`  | Set Dayfox theme                           | Theme: Dayfox                     |
| N      | `<leader>tta`  | Set Dawnfox theme                          | Theme: Dawnfox                    |
| N      | `<leader>ttu`  | Set Duskfox theme                          | Theme: Duskfox                    |
| N      | `<leader>tto`  | Set Nordfox theme                          | Theme: Nordfox                    |
| N      | `<leader>ttc`  | Set Carbonfox theme                        | Theme: Carbonfox                  |
| N      | `<leader>ttt`  | Set Terafox theme                          | Theme: Terafox                    |
| N      | `<leader>ttl`  | Set Alphafox theme                         | Theme: Alphafox                   |
| N      | `<leader>tt]`  | Cycle to next Nightfox theme               | Theme: Next                       |
| N      | `<leader>tt[`  | Cycle to prev Nightfox theme               | Theme: Previous                   |

### LSP Keymappings (`lua/user/core/lsp_keymaps.lua` - active on LSP attach)

| Mode   | Keybinding    | Action                        | Description                   |
| :----- | :------------ | :---------------------------- | :---------------------------- |
| N      | `gD`          | Go to Declaration             | LSP Go to Declaration         |
| N      | `gd`          | Go to Definition              | LSP Go to Definition          |
| N      | `K`           | Hover Documentation           | LSP Hover Documentation       |
| N      | `gi`          | Go to Implementation          | LSP Go to Implementation      |
| N      | `<leader>ls`  | Signature Help                | LSP Signature Help            |
| N      | `<leader>lt`  | Go to Type Definition         | LSP Go to Type Definition     |
| N      | `<leader>lr`  | Rename Symbol                 | LSP Rename Symbol             |
| N, V   | `<leader>la`  | Code Action                   | LSP Code Action               |
| N      | `gr`          | Go to References              | LSP Go to References          |
| N      | `<leader>lf`  | Format Buffer (LSP)           | LSP Format Buffer (fallback)  |
| N      | `[d`          | Previous Diagnostic           | LSP Prev Diagnostic           |
| N      | `]d`          | Next Diagnostic               | LSP Next Diagnostic           |
| N      | `<leader>le`  | Show Line Diagnostics         | LSP Show Line Diagnostics     |
| N      | `<leader>lq`  | Diagnostics to Loclist        | LSP Diagnostics to Loclist    |
| N      | `<leader>lwa` | Add Workspace Folder          | LSP Add Workspace Folder      |
| N      | `<leader>lwr` | Remove Workspace Folder       | LSP Remove Workspace Folder   |
| N      | `<leader>lwl` | List Workspace Folders        | LSP List Workspace Folders    |

### Plugin-Specific Keymappings

**Neo-tree (`lua/user/plugins/neotree.lua`)**
-   `<leader>ee`: Toggle NeoTree (current working directory)
-   `<leader>ef`: Find current file in NeoTree
-   *Inside Neo-tree window (common):*
    -   `j`/`k`: Navigate up/down
    -   `h`/`l` or `o` or `<CR>`: Collapse/Expand directory or open file
    -   `a`: Add file/directory
    -   `d`: Delete
    -   `r`: Rename
    -   `H`: Toggle hidden files
    -   `q` or `<Esc>`: Close Neo-tree
    -   `?`: Show help

**Telescope (`lua/user/plugins/telescope.lua`)**
-   `<leader>ff`: Find Files
-   `<leader>fg`: Live Grep
-   `<leader>fb`: Find Buffers
-   `<leader>fh`: Help Tags
-   `<leader>fo`: Old Files (History)
-   `<leader>fz`: Fuzzy Find (rg, hidden)
-   `<leader>gf`: Git Files
-   `<leader>gc`: Git Commits
-   `<leader>gs`: Git Status
-   *Inside Telescope window (common):* `<C-j>`/`<C-k>` to navigate, `<CR>` to select, `<Esc>` to close.

**Undotree (`lua/user/plugins/undotree.lua`)**
-   `<leader>u`: Toggle Undotree

**Treesitter (`lua/user/plugins/treesitter.lua`)**
-   `<leader>ti`: Treesitter Install Info
-   `<leader>tp`: Toggle Treesitter Playground
-   Text objects like `af`, `if`, `ac`, `ic` are available.

**Trouble (`lua/user/plugins/trouble.lua`)**
-   `<leader>xx`: Toggle Trouble (Diagnostics)
-   `<leader>xw`: Workspace Diagnostics
-   `<leader>xd`: Document Diagnostics
-   `<leader>xl`: Location List
-   `<leader>xq`: Quickfix List
-   `gR`: LSP References

**Conform (`lua/user/plugins/conform.lua`)**
-   `<leader>cf`: Format buffer (Normal or Visual mode)

**DAP - Debugger (`lua/user/core/dap_keymaps.lua`)**
-   `<leader>dc`: DAP Continue
-   `<leader>dj`: DAP Step Over
-   `<leader>dk`: DAP Step Into
-   `<leader>do`: DAP Step Out
-   `<leader>dt`: DAP Terminate
-   `<leader>dr`: DAP Open REPL
-   `<leader>dl`: DAP Run Last
-   `<leader>db`: DAP Toggle Breakpoint
-   `<leader>dB`: DAP Set Conditional Breakpoint
-   `<leader>lp`: DAP Set Log Point
-   `<leader>du`: DAP Toggle UI
-   `<leader>de`: DAP Eval
-   `<leader>ds`: DAP View Scopes
-   `<leader>dsc`: DAP Select Configuration
-   `<leader>dss`: DAP Get Session Info

**Gitsigns (`lua/user/plugins/gitsigns.lua`)**
-   `]h` / `[h`: Next/Prev Hunk
-   `<leader>hs`: Stage Hunk
-   `<leader>hr`: Reset Hunk
-   `<leader>hp`: Preview Hunk
-   `<leader>hb`: Blame Line
-   (Many more, see gitsigns config)

**Comment.nvim (`lua/user/plugins/comment.lua`)**
-   `gcc`: Toggle current line comment.
-   `gc` + motion (e.g., `gcip`): Toggle comment for selection/text object.

**nvim-surround (`lua/user/plugins/surround.lua`)**
-   `ysiw"`: Example: Surround Inner Word with quotes.
-   `cs"'`: Example: Change Surrounding `"` to `'`.
-   `ds"`: Example: Delete Surrounding quotes.

**Todo Comments (`lua/user/plugins/todo_comments.lua`)**
-   `<leader>ft`: Find Todos (Telescope)
-   `<leader>fT`: Find Specific Todos (Telescope)

**Toggleterm (`lua/user/plugins/toggleterm.lua`)**
-   `<c-\>` (Ctrl + Backslash): Default mapping to open a floating terminal.
-   `<leader>gg`: Toggle LazyGit terminal.
-   `<leader>wd`: Toggle Wrangler Dev terminal.
-   `<leader>wp`: Run Wrangler Publish.
-   *Inside terminal buffer*: `<Esc>` or `jk` to return to Normal mode.

**vim-tmux-navigator (`lua/user/plugins/tmux.lua`)**
-   `<c-h/j/k/l>`: Navigate Neovim splits and Tmux panes seamlessly.

**nvim-cmp & LuaSnip (Insert Mode)**
-   `<C-Space>`: Trigger completion.
-   `<CR>`: Confirm selected completion.
-   `<Tab>` / `<S-Tab>`: Navigate completion items / Expand or jump snippets.
-   `<C-e>`: Abort completion.
-   `<C-b>` / `<C-f>`: Scroll documentation.

## Customization Guide

### Adding New Language Support

To add support for a new language (e.g., "newlang"):

1.  **Treesitter Parser**:
    -   Edit `lua/user/plugins/treesitter.lua`.
    -   Add `"newlang_parser_name"` (find the correct name via `:TSInstallInfo` or the nvim-treesitter docs) to the `ensure_installed` list.
    -   Restart Neovim; the parser should install automatically.

2.  **LSP Server**:
    -   **Install**:
        -   Open Mason: `:Mason`.
        -   Search for and install the LSP server for "newlang" (e.g., `newlang_lsp_server`).
    -   **Configure**:
        -   Edit `lua/user/plugins/mason.lua`: Add the Mason package name (e.g., `"newlang_lsp_server"`) to `ensure_installed_tools`.
        -   Edit `lua/user/plugins/mason-lspconfig.lua`: Add the `lspconfig` server name (e.g., `"newlang_lsp"`, which might be different from the Mason package name) to `servers_to_setup`.
        -   Edit `lua/user/utils/lspconfig_manager.lua`: Inside the `M.setup_server` function, you can add an `elseif server_name == "newlang_lsp" then ... end` block if "newlang_lsp" requires specific `server_options` (like custom `cmd` or `settings`). Often, the default setup works if the executable is found by Mason.
    -   Restart Neovim.

3.  **Formatter (Optional)**:
    -   **Install**: Find a CLI formatter for "newlang". Install it on your system (e.g., via `npm`, `pip`, package manager, or download binary).
    -   **Configure**:
        -   Edit `lua/user/plugins/conform.lua`.
        -   Add an entry to `desired_formatters_list`:
            ```lua
            { name = "newlang_formatter_id", exe = "newlang_formatter_cli", ft = { "newlang_filetype" } },
            ```
        -   If needed, add specific arguments in the `formatters` table within `conform.setup()`:
            ```lua
            newlang_formatter_id = {
              prepend_args = {"--some-option", "value"},
            },
            ```
    -   Restart Neovim. Formatting should apply on save if configured.

4.  **Linter (Optional)**:
    -   **Install**: Find a CLI linter for "newlang". Install it on your system.
    -   **Configure**:
        -   Edit `lua/user/plugins/linters.lua`.
        -   Add an entry to `desired_linters_definitions`:
            ```lua
            {
              linter_name = "newlang_linter_id",
              executable = "newlang_linter_cli",
              filetypes = { "newlang_filetype" },
              args = { "--some-arg", "--format=json" }, -- Ensure output is parsable
              format = "json", -- Or another format nvim-lint understands
            },
            ```
    -   Restart Neovim. Linting should occur on configured events.

5.  **Debugger (Optional)**:
    -   **Install**: Find and install the Debug Adapter executable for "newlang".
    -   **Configure**:
        -   Edit `lua/user/core/dap_adapters_config.lua`.
        -   Add a new section, checking for the executable:
            ```lua
            if check_and_notify("newlang_debugger_cli", "NewLang") then
              dap.adapters.newlang_adapter_name = {
                type = "executable", -- or "server"
                command = "newlang_debugger_cli",
                args = { "--some-arg" },
              }
              dap.configurations.newlang_filetype = {
                {
                  type = "newlang_adapter_name",
                  name = "Launch NewLang Program",
                  request = "launch",
                  program = "${file}", -- Or project specific
                  -- ... other necessary launch options ...
                },
              }
              vim.notify("DAP Adapters: NewLang adapter configured.", vim.log.levels.INFO)
            end
            ```
    -   Restart Neovim.

### Adding Custom Snippets

1.  Navigate to `~/.config/nvim/lua/user/snippets/`.
2.  Create a new `language_name.lua` file (e.g., `newlang.lua`) or edit `all.lua` for global snippets.
3.  Define your snippets using the `LuaSnip` API. Each snippet file should return a table of snippets. Example (`lua.lua`):
    ```lua
    local ls = require("luasnip")
    local s = ls.snippet
    local t = ls.text_node
    local i = ls.insert_node

    return {
      s("mytrigger", { t("This is my new snippet for "), i(1, "placeholder") }),
    }
    ```
4.  `LuaSnip` (configured in `lua/user/plugins/luasnip.lua`) automatically loads `*.lua` files from this directory.

## External Dependencies

Remember that some tools require external command-line programs to be installed on your system:
-   **Formatters**: `stylua`, `prettier`, `shfmt`, `ruff`, `black`, `isort`, `goimports`, `clang-format`, `zigfmt`, `dotnet-csharpier`, `sqlfluff`, etc.
-   **Linters**: `luacheck`, `eslint_d` (or `eslint`), `shellcheck`, `ruff`, `golangci-lint`, `cppcheck`, `cargo clippy`, `markdownlint-cli`, `yamllint`, etc.
-   **Debug Adapters**: `dlv` (Go), `debugpy` (Python, via pip), `netcoredbg` (C#), `codelldb` (C++/Rust), Node.js debuggers.
-   **Git**: For `gitsigns.nvim` and Telescope git commands.
-   **Ripgrep (`rg`)**: For Telescope's `live_grep` for optimal performance.
-   **`make` and a C Compiler**: For building `telescope-fzf-native.nvim`.
-   **Ranger**: If you decide to use `Rnvimr` in the future.
-   **`ueberzug` or `ueberzugpp`**: For image previews in Ranger/Rnvimr on Linux.

Ensure these are installed and available in your system's `PATH` for the respective features to work correctly. The configuration files include checks for many of these executables and will notify you if they are missing.

---

This README should provide a good starting point and reference for your configuration. You can copy and paste this into `~/.config/nvim/README.md`.

