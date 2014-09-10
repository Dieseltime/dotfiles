set nocompatible
set backspace=indent,eol,start
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set autoindent
set noswapfile
set number
set history=1000
set incsearch
set hlsearch
set wildmode=list:longest
set wildmenu

syntax on

autocmd BufWritePre * :%s/\s\+$//e