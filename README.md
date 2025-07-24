# Neovim Configuration

This repository contains a modern Neovim configuration written in Lua, optimized for web development with TypeScript, Lua, and other languages.

## Overview

- **`init.lua`**: The main entry point that initializes settings and plugins.
- **`lua/`**: Contains modular configurations:
  - **`defaults/`**: General settings, key mappings, and event handlers.
  - **`lazyconfig/`**: Plugin-specific configurations and utilities.
    - **`plugins/`**: Individual plugin configurations.
    - **`util/`**: Utility functions and shared configurations.

## Features

- **Plugin Management**: Powered by `lazy.nvim` for efficient plugin loading.
- **LSP Integration**:
  - Comprehensive LSP support with `nvim-lspconfig` and `mason.nvim`.
  - TypeScript-specific tooling with `typescript-tools.nvim`.
  - Code completion via `nvim-cmp` with various sources.
- **Development Tools**:
  - Debugging with `nvim-dap`.
  - Code formatting with `conform.nvim`.
  - Git integration via `fugitive`, `gitsigns`, and `diffview`.
  - Database management with `vim-dadbod`.
- **UI Enhancements**:
  - Syntax highlighting with `nvim-treesitter`.
  - File navigation with `oil.nvim`.
  - Fuzzy finding with `telescope.nvim`.
  - Code folding with `nvim-ufo`.
  - Status updates with `fidget.nvim`.
  - Better Markdown rendering with `render-markdown.nvim`.
  - Large file handling with `snacks.nvim`.
- **Productivity**:
  - Quick navigation with `harpoon`.
  - Undo history visualization with `undotree`.
  - Snippets support with `LuaSnip`.
  - AI assistance with `windsurf.nvim` (powered by Codeium).
  - AI chat integration with `avante.nvim` (powered by Claude).
  - Focus mode with `zen-mode.nvim`.
  - Code screenshots with `silicon.nvim`.
  - JSON to TypeScript conversion.
  - Image support with `img-clip.nvim`.
  - Seamless navigation between tmux panes with `vim-tmux-navigator`.
  - Code commenting with `Comment.nvim`.
  - Translation with `translate.nvim`.

## Prerequisites

- Neovim 0.10 or higher
- `git` installed
- Node.js and npm (for TypeScript/JavaScript LSP)
- (Optional) [tmux](https://github.com/tmux/tmux) for terminal navigation
- (Optional) An Anthropic API key for Claude integration with `avante.nvim`

## Installation

1. Clone the repository:

```bash
git clone https://github.com/Ask-786/nvim ~/.config/nvim
```

2. Start Neovim and let it install plugins automatically:

```bash
nvim
```

## Custom Plugins

This configuration includes several custom plugins:

- `ask-786/time-calculator.nvim`: For time calculations
- `ask-786/emojis.nvim`: Emoji support

## Development Tools

This configuration includes several developer-friendly tools:

- `folke/lazydev.nvim`: Provides enhanced Lua development experience
- `nvim-surround`: For easily manipulating surroundings (quotes, brackets, tags, etc.)
- `nvim-autopairs`: Automatic bracket pairing
- `nvim-ts-autotag`: Automatically close and rename HTML/JSX tags

Additional mappings are available for telescope, git operations, and other tools.
