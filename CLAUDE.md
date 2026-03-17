# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Purpose

This repo syncs system configuration (dotfiles) from `~/ZenWayne/Unamed/` to `~/`. Files here map 1:1 to their home directory counterparts (see README.md path mapping table).

## Syncing configs to system

```bash
# Preferred: use GNU Stow (creates symlinks)
cd ~/ZenWayne/Unamed
stow -t ~ .

# Or copy individual files manually
cp .vimrc ~/.vimrc
cp .bashrc ~/.bashrc
cp .tmux.conf ~/.tmux.conf
cp .config/nvim/init.vim ~/.config/nvim/init.vim
cp .config/nvim/lua/dap-config.lua ~/.config/nvim/lua/dap-config.lua
```

## Architecture

- **`.vimrc`** — Main Vim/Neovim config. Uses vim-plug. LSP via coc.nvim, fuzzy find via fzf.vim, git via vim-fugitive.
- **`.config/nvim/init.vim`** — Neovim entry point; sources `~/.vimrc` and loads DAP config for Python files.
- **`.config/nvim/lua/dap-config.lua`** — Python debug adapter (nvim-dap + nvim-dap-python). Requires `pip install debugpy`.
- **`.bashrc`** — Sets Android SDK paths, proxy helpers (`setproxy`/`unsetproxy`), `alias docker='podman'`, `alias rm='trash-put'`, Kimi API helper (`setkimi`).
- **`.tmux.conf`** — Mouse support + tmux-resurrect plugin. Window navigation: `Ctrl+Shift+Left/Right`.
- **`.local/bin/install-android-sdk`** — Downloads Android 34 system image and creates `pixel_7` AVD.
- **`.local/bin/start-android-emulator`** — Launches the AVD emulator.

## Key behaviors

- `docker` is aliased to `podman` — use podman commands directly if alias is not active.
- `rm` is aliased to `trash-put` — files go to trash, not deleted immediately.
- Proxy at `127.0.0.1:10809` — run `setproxy` before Android SDK installs or other network ops that need it.
- Neovim shares vim-plug plugins from `~/.vim/plugged` — no separate nvim plugin directory.
