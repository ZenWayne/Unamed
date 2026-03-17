" Neovim configuration that inherits Vim settings
" This file makes nvim use ~/.vimrc and ~/.vim/ directory

" Prepend ~/.vim to runtimepath so vim plugins are loaded
set runtimepath^=~/.vim
set runtimepath+=~/.vim/after

" Set packpath for vim-plug plugins
set packpath^=~/.vim

" Source the original .vimrc
source ~/.vimrc

" Additional nvim-specific settings (if any) can go here
" For example, you might want to set the Python host for nvim
" let g:python3_host_prog = '/usr/bin/python3'

" ============= Python DAP Configuration =============
" 使用 autocmd 确保只在 Python 文件类型时加载 DAP 配置
augroup DAPPython
  autocmd!
  autocmd FileType python lua require('dap-config').setup()
augroup END
