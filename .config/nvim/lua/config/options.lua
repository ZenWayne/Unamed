local opt = vim.opt

-- 基础设置
opt.number = true
opt.relativenumber = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true
opt.wrap = false
opt.termguicolors = true
opt.signcolumn = "yes"
opt.updatetime = 250
opt.timeoutlen = 300
opt.undofile = true
opt.splitright = true
opt.splitbelow = true
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.cursorline = true
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true

-- 诊断显示
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    border = "rounded",
    source = "always",
  },
})
