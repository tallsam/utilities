" Following lines added by drush vimrc-install on Mon, 27 May 2013 05:15:50 +0000.
set nocompatible
call pathogen#infect('/home/sam/.drush/vimrc/bundle/{}')
call pathogen#infect('/home/sam/.vim/bundle/{}')
" End of vimrc-install additions.
source $VIMRUNTIME/vimrc_example.vim

"colorscheme darkblue
colorscheme elflord

map ,t <Esc>:tabnew<CR>
map ,n <Esc>:tabn<CR>
map ,p <Esc>:tabp<CR>
map <F8> :NERDTreeToggle<CR>
map <silent> <F7> :if &number <Bar>
  \set nonumber <Bar>
  \set paste <Bar>
  \else <Bar>
  \set number <Bar>
  \set nopaste <Bar>
  \endif<cr>


set mouse-=a
set nu
set et
set sw=2
set smarttab
set hlsearch
set incsearch
set autoindent
set textwidth=0
set backspace=indent,eol,start
set ruler
set history=50
set showcmd
set showmatch
set nowrap
set expandtab tabstop=2 shiftwidth=2
set nobackup

let g:debuggerPort = 9000
