-- Autocmds for init.lua
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- File type specific settings
autocmd('FileType', {
  pattern = 'smarty',
  callback = function()
    vim.bo.filetype = 'html'
  end,
})

autocmd('FileType', {
  pattern = 'html',
  callback = function()
    vim.bo.expandtab = true
    vim.bo.tabstop = 2
    vim.bo.shiftwidth = 2
  end,
})

autocmd('FileType', {
  pattern = 'vue',
  callback = function()
    vim.bo.expandtab = true
    vim.bo.tabstop = 2
    vim.bo.shiftwidth = 2
  end,
})

autocmd('FileType', {
  pattern = 'javascript',
  callback = function()
    vim.bo.expandtab = true
    vim.bo.tabstop = 2
    vim.bo.shiftwidth = 2
  end,
})

autocmd('FileType', {
  pattern = 'markdown',
  callback = function()
    vim.bo.shiftwidth = 3
    vim.bo.expandtab = true
  end,
})

autocmd('FileType', {
  pattern = 'cpp',
  callback = function()
    vim.bo.tabstop = 4
  end,
})

-- C++ namespace/template indent
autocmd('BufEnter', {
  pattern = { '*.cc', '*.cxx', '*.cpp', '*.h', '*.hh', '*.hpp', '*.hxx' },
  callback = function()
    vim.bo.indentexpr = 'CppNoNamespaceAndTemplateIndent()'
  end,
})

-- Format programs
autocmd({ 'BufNewFile', 'BufRead' }, {
  pattern = '*.cpp',
  command = 'set formatprg=astyle\\ -T4p\\ cino=N-s,j1,(0,ws,Ws',
})

autocmd({ 'BufNewFile', 'BufRead' }, {
  pattern = '*.c',
  command = 'set formatprg=astyle\\ -s4p',
})

autocmd({ 'BufNewFile', 'BufRead' }, {
  pattern = '*.java',
  command = 'set formatprg=astyle\\ -pA2',
})

autocmd({ 'BufNewFile', 'BufRead' }, {
  pattern = '*.py',
  command = 'set formatprg=astyle\\ -pA12',
})

-- Fugitive autocmd
autocmd('FileType', {
  pattern = 'fugitive',
  callback = function()
    vim.api.nvim_buf_set_keymap(0, 'n', 'gx', '<nop>', { noremap = true, silent = true })
  end,
})
