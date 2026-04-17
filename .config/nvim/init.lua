-- Neovim configuration with vim-plug
-- vim-plug path: ~/.local/share/nvim/site/autoload/plug.vim

-- Plugin Management
local Plug = vim.fn['plug#']
vim.fn['plug#begin'](vim.fn.has('win32') == 1 and '~/vimfiles/plugged' or '~/.vim/plugged')

Plug('junegunn/vim-plug')
Plug('yianwillis/vimcdoc')
Plug('preservim/nerdtree')
Plug('jiangmiao/auto-pairs')
Plug('brenton-leighton/multiple-cursors.nvim')
Plug('plasticboy/vim-markdown')
Plug('iamcco/markdown-preview.nvim', { ['do'] = function() vim.fn['mkdp#util#install']() end })
Plug('posva/vim-vue')
Plug('pangloss/vim-javascript', { ['for'] = 'javascript' })
Plug('junegunn/fzf', { ['do'] = function() vim.fn['fzf#install']() end })
Plug('junegunn/fzf.vim')
Plug('tpope/vim-fugitive')
Plug('vim-airline/vim-airline')
Plug('vim-airline/vim-airline-themes')
Plug('altercation/vim-colors-solarized')
Plug('neoclide/coc.nvim', { ['do'] = './install.sh nightly' })
Plug('dart-lang/dart-vim-plugin')
Plug('iamcco/coc-flutter')
Plug('fannheyward/coc-pyright', { ['for'] = 'python' })
Plug('mfussenegger/nvim-dap', { ['for'] = 'python' })
Plug('mfussenegger/nvim-dap-python', { ['for'] = 'python' })
Plug('rcarriga/nvim-dap-ui', { ['for'] = 'python' })
Plug('nvim-neotest/nvim-nio', { ['for'] = 'python' })
Plug('wookayin/semshi', { ['do'] = ':UpdateRemotePlugins', ['for'] = 'python' })

vim.fn['plug#end']()

-- Basic Settings
local opt = vim.opt
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

opt.number = true
opt.relativenumber = false
opt.hlsearch = true
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.showcmd = true
opt.foldmethod = 'manual'
opt.helplang = 'cn'
opt.history = 1000
opt.compatible = false
opt.completeopt = 'menu'
opt.cmdheight = 2
opt.tabstop = 8
opt.shiftwidth = 4
opt.softtabstop = 1
opt.expandtab = false
opt.fileencodings = 'utf-8,ucs-bom,gb18030,gbk,gb2312,cp936'
opt.encoding = 'utf-8'
opt.splitright = true
opt.splitbelow = true
opt.equalalways = true
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.cursorline = false
opt.laststatus = 2
opt.termguicolors = false
opt.background = 'dark'

-- Solarized config must be set before the colorscheme is applied
vim.g.solarized_termcolors = 256
vim.g.solarized_termtrans = 1
vim.g.solarized_underline = 1
vim.g.solarized_italic = 1

vim.cmd('colorscheme solarized')

-- Key Mappings
local map = vim.keymap.set

map('n', '<Esc>', '<cmd>nohlsearch<CR>')
map('n', '<leader>w', '<cmd>w<CR>', { desc = 'Save' })
map('n', '<leader>q', '<cmd>q<CR>', { desc = 'Quit' })
map('n', '<C-h>', '<C-w>h', { desc = 'Window Left' })
map('n', '<C-j>', '<C-w>j', { desc = 'Window Down' })
map('n', '<C-k>', '<C-w>k', { desc = 'Window Up' })
map('n', '<C-l>', '<C-w>l', { desc = 'Window Right' })
map('n', '<S-h>', '<cmd>bprevious<CR>', { desc = 'Prev Buffer' })
map('n', '<S-l>', '<cmd>bnext<CR>', { desc = 'Next Buffer' })
map('n', '[d', vim.diagnostic.goto_prev, { desc = 'Prev Diagnostic' })
map('n', ']d', vim.diagnostic.goto_next, { desc = 'Next Diagnostic' })
map('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show Diagnostic' })

-- NERDTree
map('n', '<F2>', '<cmd>NERDTreeToggle<CR>')
map('n', '<leader>nf', '<cmd>NERDTreeFind<CR>')

-- FZF
map('n', '<C-f>', '<cmd>Files<CR>')
map('n', '<C-p>', '<cmd>GFiles<CR>')
map('n', '<leader>fs', '<cmd>Rg<CR>')

-- Git (fugitive)
map('n', '<leader>gs', '<cmd>Git<CR>')
map('n', '<leader>gc', '<cmd>Git commit<CR>')
map('n', '<leader>gp', '<cmd>Git push<CR>')
map('n', '<leader>gl', '<cmd>Git pull<CR>')
map('n', '<leader>dd', '<cmd>Gdiffsplit<CR>')
map('n', '<leader>gv', '<cmd>Gvdiffsplit<CR>')
map('n', '<leader>gb', '<cmd>Git blame<CR>')
map('n', '<leader>gx', '<cmd>only<CR>')
map('n', '<leader>go', '<cmd>diffoff!<CR>')
map('n', '<leader>gh', '<cmd>diffget //2<CR>')

-- Copy filename
map('n', '<leader>fn', ':let @+ = expand("%:t")<CR>:echo "Copied: " . expand("%:t")<CR>')
map('n', '<leader>fp', ':let @+ = expand("%:p")<CR>:echo "Copied: " . expand("%:p")<CR>')
map('n', '<leader>fr', ':let @+ = expand("%")<CR>:echo "Copied: " . expand("%")<CR>')

-- Visual Multi - using default mappings to avoid configuration errors

-- Functions
function Compile()
  vim.cmd('w')
  local ft = vim.bo.filetype
  if ft == 'c' then
    vim.cmd('!gcc % -o run_%< -lm')
  elseif ft == 'cpp' then
    vim.cmd('!g++ % -o run_%<')
  elseif ft == 'python' then
    vim.cmd('!python3 %')
  elseif ft == 'java' then
    vim.cmd('!javac % && java %<')
  elseif ft == 'sh' then
    vim.cmd('!time bash %')
  elseif ft == 'html' then
    vim.cmd('!google-chrome % &')
  elseif ft == 'php' then
    vim.cmd('!php %')
  end
end

function OpenglCompile()
  vim.cmd('w')
  vim.cmd('!gcc % -o %< -lglfw3 -lGL -lm -ldl -lXinerama -lXrandr -lXi -lXcursor -lX11 -lXxf86vm -lpthread')
end

function Debugger()
  vim.cmd('w')
  local ft = vim.bo.filetype
  if ft == 'c' then
    vim.cmd('!rm -rf GDB_%< && gcc -g % -o GDB_%<')
  elseif ft == 'cpp' then
    vim.cmd('!rm -rf GDB_%< && g++ -g % -o GDB_%<')
  end
end

-- Coc.nvim keymaps
vim.keymap.set('n', 'gd', '<Plug>(coc-definition)', { silent = true })
vim.keymap.set('n', 'gy', '<Plug>(coc-type-definition)', { silent = true })
vim.keymap.set('n', 'gi', '<Plug>(coc-implementation)', { silent = true })
vim.keymap.set('n', 'gr', '<Plug>(coc-references)', { silent = true })
vim.keymap.set('n', 'K', ':call CocActionAsync("doHover")<CR>', { silent = true })
vim.keymap.set('n', '<leader>rn', '<Plug>(coc-rename)', { silent = true })
vim.keymap.set('n', '<leader>f', ':call CocActionAsync("format")<CR>', { silent = true })
vim.keymap.set('n', '<leader>qf', '<Plug>(coc-fix-current)', { silent = true })

-- Airline configuration
vim.g.airline_powerline_fonts = 1
vim.g['airline#extensions#tabline#enabled'] = 1
vim.g['airline#extensions#tabline#buffer_nr_show'] = 1

-- NERDTree configuration
vim.g.NERDTreeShowHidden = 1
vim.g.NERDTreeMinimalUI = 1
vim.g.NERDTreeDirArrows = 1

-- FZF configuration
vim.g.fzf_layout = { window = { width = 0.9, height = 0.6 } }

-- Autocmds
vim.api.nvim_create_autocmd('VimEnter', {
  pattern = '*',
  callback = function()
    if vim.fn.argc() == 1 and vim.fn.isdirectory(vim.fn.argv(0)) == 1 then
      vim.cmd('NERDTree')
      vim.cmd('wincmd p')
      vim.cmd('enew')
    end
  end,
})


-- ============================================================================
-- MISSING CONFIGURATION - ADDED TO COMPLETE MIGRATION
-- ============================================================================

-- Terminal mapping <M-t>
map('n', '<M-t>', '<cmd>vert bel ter<CR>', { desc = 'Open vertical terminal' })

-- TlistToggle mapping <F3> (note: taglist plugin not installed, using placeholder)
map('n', '<F3>', '<cmd>echo "TlistToggle: taglist plugin not installed"<CR>', { desc = 'Toggle taglist (not installed)' })

-- diffget //3 mapping for merge conflicts
map('n', '<leader>gj', '<cmd>diffget //3<CR>', { desc = 'Get from merge branch (//3)' })

-- ============================================================================
-- PLUGIN CONFIGURATION
-- ============================================================================

-- Conceallevel for vim-markdown
opt.conceallevel = 2

-- vim-markdown configuration
vim.g.vim_markdown_math = 1
vim.g.vim_markdown_folding_disabled = 1
vim.g.vim_markdown_conceal_code_blocks = 1

-- HTML indent settings
vim.g.html_indent_script1 = "inc"
vim.g.html_indent_style1 = "inc"
vim.g.html_indent_inctags = "html,address,article,aside,audio,blockquote,canvas,dd,div,dl,fieldset,figcaption,figure,footer,form,h1,h2,h3,h4,h5,h6,header,hgroup,hr,main,nav,noscript,ol,output,p,pre,section,table,tfoot,ul,video"

-- emmet-vim configuration (plugin not installed but config ready)
vim.g.user_emmet_mode = 'a'
vim.g.user_emmet_expandabbr_key = '<C-Y>'

-- Solarized config is set above, before colorscheme is applied

-- ============================================================================
-- COC.NVIM EXTENDED CONFIGURATION
-- ============================================================================

-- Tab/S-Tab mappings for coc completion
vim.keymap.set('i', '<Tab>', [[pumvisible() ? "\<C-n>" : "\<Tab>"]], { expr = true, silent = true })
vim.keymap.set('i', '<S-Tab>', [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]], { expr = true, silent = true })

-- SetupCommandAbbrs function and C abbreviation
local function SetupCommandAbbrs(from, to)
  local cmd = string.format(
    'cnoreabbrev <expr> %s ((getcmdtype() ==# ":" && getcmdline() ==# "%s") ? ("%s") : ("%s"))',
    from, from, to, from
  )
  vim.cmd(cmd)
end
SetupCommandAbbrs('C', 'CocConfig')

-- show_documentation function (replaces K mapping)
function ShowDocumentation()
  local ft = vim.bo.filetype
  if ft == 'vim' or ft == 'help' then
    vim.cmd('h ' .. vim.fn.expand('<cword>'))
  else
    vim.cmd([[call CocAction('doHover')]])
  end
end

-- ============================================================================
-- CRITICAL: CppNoNamespaceAndTemplateIndent FUNCTION
-- This function is REQUIRED by autocmds.lua
-- ============================================================================

function CppNoNamespaceAndTemplateIndent()
  local cline_num = vim.fn.line('.')
  local cline = vim.fn.getline(cline_num)
  local pline_num = vim.fn.prevnonblank(cline_num - 1)
  local pline = vim.fn.getline(pline_num)
  
  -- Skip comment lines (using simple string checks instead of complex patterns)
  while pline:find('^%s*{%s*$') or pline:find('^%s*//') or pline:find('^%s*/%*') or pline:find('%*/%s*$') do
    pline_num = vim.fn.prevnonblank(pline_num - 1)
    pline = vim.fn.getline(pline_num)
  end
  
  local retv = vim.fn.cindent('.')
  local pindent = vim.fn.indent(pline_num)
  local shiftwidth = vim.fn.shiftwidth()
  
  if pline:find('^%s*template%s*$') then
    retv = pindent
  elseif pline:find('%s*typename.+,') then
    retv = pindent
  elseif cline:find('^%s*>%s*$') then
    retv = pindent - shiftwidth
  elseif pline:find('%s*typename.->') then
    retv = pindent - shiftwidth
  elseif pline:find('^%s*namespace') then
    retv = 0
  end
  
  return retv
end

-- ============================================================================
-- FIX: Airline symbols must be set before airline loads
-- ============================================================================

-- Ensure airline_symbols is a proper Vim dict before airline loads
-- Note: `{}` in Lua is converted to a Vim List, not Dict; use vim.empty_dict() instead
if vim.g.airline_symbols == nil then
  vim.g.airline_symbols = vim.empty_dict()
end

-- Alternative: Disable problematic airline extensions if they cause issues
-- vim.g['airline#extensions#whitespace#enabled'] = 0

-- ============================================================================
-- FIX: CppNoNamespaceAndTemplateIndent with proper patterns
-- ============================================================================

-- The function is defined above, but we need to ensure autocmds.lua can find it
-- It's already defined in the init.lua above
