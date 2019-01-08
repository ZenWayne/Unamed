"=================    Plugin    ================="

call plug#begin('~/.vim/plugged')
Plug 'junegunn/vim-plug'
Plug 'mileszs/ack.vim'
Plug 'yianwillis/vimcdoc'
Plug 'scrooloose/nerdtree' 
Plug 'vim-scripts/taglist.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-fugitive'
Plug 'mg979/vim-visual-multi'

Plug 'vim-syntastic/syntastic',{'for':['c','py','php','sh','desktop','css']}
Plug 'vim-airline/vim-airline' 
Plug 'vim-airline/vim-airline-themes' 
Plug 'altercation/vim-colors-solarized' 
Plug 'Valloric/YouCompleteMe'
Plug 'davidhalter/jedi-vim',{'for':['python']}
"Plug 'Valloric/YouCompleteMe',{'for':['c','java','cpp','php','sh','desktop','css']}
Plug 'mattn/emmet-vim',{'for':['html','php']}
Plug '2072/PHP-Indenting-for-VIm'

Plug 'rayburgemeestre/phpfolding.vim'
"Plug 'artur-shaik/vim-javacomplete2',{'for':['java']}
Plug '~/.vim/plugged/eclim',{'for':['java']}

"Plug 'mg979/alt-mappings.vim'
"Plug 'tpope/vim-surround',{'for':['html']}
"Plug 'terryma/vim-expand-region' 
"Plug 'terryma/vim-multiple-cursors' 
"Plug 'artur-shaik/vim-javacomplete2'
call plug#end()
"=================    .Vimrc    ================="

set nu
set showcmd
syntax enable 
set fdm=manual
set helplang=cn
set history=1000
set nocompatible
set completeopt=menu
colorscheme solarized 
filetype indent on
set ts=8
set sw=4
set encoding=utf-8 
set fileencodings=ucs-bom,utf-8,cp936
autocmd Filetype smarty setlocal ft=html
autocmd Filetype html setlocal ts=2 sw=2 expandtab
autocmd FileType text setlocal textwidth=78

set smartindent
"==============    windows    =============="
set noea

"=================    html    ================="
let g:html_indent_script1 = "inc"
let g:html_indent_style1 = "inc" 
let g:html_indent_inctags = "html,address,article,aside,audio,blockquote,canvas,dd,div,dl,fieldset,figcaption,figure,footer,form,h1,h2,h3,h4,h5,h6,header,hgroup,hr,main,nav,noscript,ol,output,p,pre,section,table,tfoot,ul,video"
let php_htmlInStrings = 1
"=================    .Vimrc    ================="

nmap Y y$
nmap <F5> :call Compile()<CR>
nmap <C-F5> :call OpenglCompile()<CR>

func! Compile()
    exec ":w" 
    if &filetype == 'c' 
	exec '!gcc % -o run_%< -lm'
	exec '!time ./run_%<'
    elseif &filetype == 'cpp'
	exec '!g++ % -o run_%<'
	exec '!time ./run_%<'
    elseif &filetype == 'python'
	exec '!python3 %'
    elseif &filetype == 'java'
	exec '!javac % &&java %<'  
    elseif &filetype == 'sh'
	exec '!time bash %'
    elseif &filetype == 'html'
	exec  '!google-chrome % &'
    elseif &filetype == 'php'
	let filename=split(expand('%'),"/")
	exec '!php %;firefox localhost/'.filename[len(filename)-1]
    endif
endfunc
func! OpenglCompile()
    exec "w"
    exec "!gcc % -o %< -lglfw3 -lGL -lm -ldl  -lXinerama -lXrandr -lXi -lXcursor -lX11 -lXxf86vm -lpthread"
endfunc

map <F6> :call Debugger()<CR>
func! Debugger()
    exec "w"
    if &filetype =='c'
	exec '!rm -rf GDB_%< &&gcc -g % -o GDB_%<'
    elseif &filetype == 'cpp'                 
	exec '!rm -rf GDB_%< &&g++ -g % -o GDB_%<'
    endif
endfunc

"=================Plugin Configure================="

"=================   YCM   ================="

let g:ycm_server_python_interpreter='/usr/bin/python3.6'
let g:ycm_python_binary_path = '/usr/bin/python3.6'
let g:ycm_global_ycm_extra_conf='~/.vim/plugged/YouCompleteMe/third_party/ycmd/examples/.ycm_extra_conf.py'
let g:ycm_semantic_triggers = {
	    \   'css': [ 're!^\s{4}', 're!:\s+' ],
	    \ }

"===============  airline  ==============="

let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#bufferline#enabled = 1
let g:airline#extensions#ycm#enabled = 1
let g:airline#extensions#ycm#error_symbol = 'E:'
let g:airline#extensions#ycm#warning_symbol = 'W:'

"===============  solarized  ==============="

let g:solarized_termcolors=256
let g:solarized_termtrans=1
let g:solarized_underline=1
let g:solarized_italic=1

if has('gui_running')
    set background=light
else
    set background=dark
endif

"============== NERDTreeToggle ============="

map <F2> :NERDTreeToggle <CR>
set rtp+=/usr/local/lib/python2.7/dist-packages/powerline/bindings/vim/
set laststatus=2
set t_Co=256

"==============    taglist   ============="

map <F3> :TlistToggle <CR>
let Tlist_Use_Right_Window=0
"==============    emmet-vim   ============="

let g:user_emmet_mode='a'
let g:user_emmet_expandabbr_key = '<C-Y>'

"============   syntastic   ============"  

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

"============   eclim   ============"  

let g:EclimCompletionMethod = 'omnifunc'
command PD execute ":ProjectDelete "

"=========== javacomplete2 ========="

"autocmd FileType java setlocal omnifunc=javacomplete#Complete
"let g:JavaComplete_EnableDefaultMappings = 1

"=========== multi-visual ========="
set <M-j>=j
set <M-k>=k
set timeout timeoutlen=250 ttimeoutlen=25
let g:VM_maps = {}
let g:VM_maps["Add Cursor Down"]             = '<M-j>'
let g:VM_maps["Add Cursor Up"]               = '<M-k>'
