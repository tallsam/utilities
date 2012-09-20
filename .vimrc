syntax on
set nu
set backspace=indent,eol,start
set nocompatible " rende vim compatibile a vi
set et
set sw=2
set smarttab
set hlsearch
set incsearch
set autoindent
set textwidth=0
set ruler " fa apparire la posizione del cursore
set history=50

au BufNewFile,BufRead *.test set filetype=php 


if has("autocmd") " permette il riconoscimento del linguaggio
  filetype plugin indent on
endif

set showcmd
set showmatch

set nowrap
set expandtab tabstop=2 shiftwidth=2

"colorscheme elflord
colorscheme darkblue
"colorscheme delek
"colorscheme morning

set filetype=php

map <F2> :NERDTreeToggle<CR>

set mouse=a


