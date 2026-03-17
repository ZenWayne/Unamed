# Unamed - System Configuration Files Sync

This project is used to synchronize and manage system configuration files.

## Path Mapping

| Project Path | System Path | Description |
|---------|---------|------|
| `.config/nvim/init.vim` | `~/.config/nvim/init.vim` | Neovim main configuration |
| `.config/nvim/lua/dap-config.lua` | `~/.config/nvim/lua/dap-config.lua` | Neovim DAP debug configuration |
| `.vimrc` | `~/.vimrc` | Vim configuration file |
| `.bashrc` | `~/.bashrc` | Bash configuration file |
| `.tmux.conf` | `~/.tmux.conf` | Tmux configuration file |

## Install/Sync Methods

```bash
# Sync from project to system (using stow or manual symlink)
cd ~/ZenWayne/Unamed
stow -t ~ .

# Or copy manually
cp .config/nvim/init.vim ~/.config/nvim/init.vim
cp .config/nvim/lua/dap-config.lua ~/.config/nvim/lua/dap-config.lua
cp .vimrc ~/.vimrc
cp .bashrc ~/.bashrc
cp .tmux.conf ~/.tmux.conf
```

## DAP Debug Configuration

### Dependencies Installation

```bash
# Install debugpy in your virtual environment
pip install debugpy
```

### Neovim Plugins

Using vim-plug, already configured in `.vimrc`:

```vim
Plug 'mfussenegger/nvim-dap'
Plug 'mfussenegger/nvim-dap-python'
Plug 'rcarriga/nvim-dap-ui'
Plug 'nvim-neotest/nvim-nio'
```

### Key Bindings

| Key | Function |
|------|------|
| `<F5>` | Launch/continue debugging |
| `<F6>` | Toggle debug UI show/hide |
| `<F9>` | Toggle breakpoint |
| `<F10>` | Step over |
| `<F11>` | Step into |
| `<F12>` | Step out |
| `<Leader>B` | Set conditional breakpoint |
| `<Leader>dr` | Open REPL |
| `<Leader>dl` | Re-run last debug session |

### Debug Workflow

1. Open a Python file
2. Press `<F9>` to set a breakpoint
3. Press `<F5>` to start debugging
4. Use `<F10>` / `<F11>` to step through code
5. Press `<F6>` to toggle debug panel visibility
