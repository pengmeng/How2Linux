"Pathogen
call pathogen#infect()

"command leader
let mapleader=";"

set nocompatible
syntax enable
syntax on

filetype on
filetype plugin on
set shortmess=atI   " 去掉欢迎界面
set autoindent
autocmd BufEnter * :syntax sync fromstart

set laststatus=2
set nu
set ruler
set cursorline

set showcmd         " 显示命令
set lz              " 当运行宏时，在命令执行完成之前，不重绘屏幕
set hid             " 可以在没有保存的情况下切换buffer
set backspace=eol,start,indent 
set whichwrap+=<,>,h,l " 退格键和方向键可以换行
set incsearch       " 增量式搜索
set hlsearch        " 高亮搜索
set magic           " 额，自己:h magic吧，一行很难解释
set showmatch       " 显示匹配的括号
set nobackup        " 关闭备份
set nowb
set noswapfile      " 不使用swp文件，注意，错误退出后无法恢复
set lbr             " 在breakat字符处而不是最后一个字符处断行
set ai              " 自动缩进
set si              " 智能缩进
"set cindent
set wildmenu         
set nofen
set fdl=10
 
"indent
filetype indent on
set expandtab
set smarttab
set shiftwidth=4
set tabstop=4
set softtabstop=4

"vim-go
let g:go_disable_autoinstall = 0
let g:neocomplete#enable_at_startup = 1

"color
set t_Co=256
let g:molokai_original = 0
colorscheme molokai
"let g:rehash256 = 1


"tagbar
let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
    \ }
nmap <F8> :TagbarToggle<CR>

"rust language
set hidden
let g:racer_cmd = "racer"
let $RUST_SRC_PATH=""
