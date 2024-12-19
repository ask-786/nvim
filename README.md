# Neovim Configuration

This repository contains a Neovim configuration written in Lua.

## Overview

- **`init.lua`**: The main entry point that initializes settings and plugins.
- **`lua/`**: Contains modular configurations:
  - **`defaults/`**: General settings, key mappings, and event handlers.
  - **`lazyconfig/`**: Plugin-specific configurations and utilities.

## Features

- Plugin management with `lazy.nvim`.
- LSP support with autocompletion and diagnostics.
- Supported snippets.
- UI enhancements with themes and treesitter.
- Productivity tools like `telescope` and `undotree`.
- Git integration with `fugitive` and `gitsigns`.

## Usage

### Prerequisites

- Neovim 0.10 or higher
- `git` installed
- (Optional) [tmux](https://github.com/tmux/tmux) for terminal navigation (I use it all the time by the way).

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/your-repo-name.git ~/.config/nvim
