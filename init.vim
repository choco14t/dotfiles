call plug#begin('~/.vim/plugged')
  " Color Scheme / Interface
  Plug 'arcticicestudio/nord-vim'
  Plug 'ryanoasis/vim-devicons'

  " Utilities
  Plug 'Lokaltog/vim-easymotion'
  Plug 'tpope/vim-surround'
call plug#end()

filetype plugin indent on
syntax enable

set background=dark
set termguicolors
colorscheme nord

" options
set clipboard=unnamed,unnamedplus
set encoding=utf8
set number
set ruler
set mouse=a
set cursorline
set nowrap

" indent
set autoindent
set smartindent
set smarttab
set expandtab
set tabstop=4
set shiftwidth=4

" search
set hlsearch
set incsearch
set ignorecase
set smartcase
set wrapscan

" swap file
set directory=~/.vim/tmp

" keymap
let mapleader = "\<Space>"

noremap , :

" quit insert mode
inoremap jj <Esc>

" move window
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sh <C-w>h

nnoremap <Esc><Esc> :noh<CR>

" split window
nnoremap ss :<C-u>sp<CR>
nnoremap sv :<C-u>vs<CR>

" tab page
nnoremap sn gt
nnoremap sp gT
nnoremap st :<C-u>tabnew<CR>

" write file
nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :wq<CR>

" vim-easymotion
let g:EasyMotion_smartcase=1

" Turn off paste mode when leaving insert
autocmd InsertLeave * set nopaste

" Vim-Airline Configuration
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:hybrid_custom_term_colors = 1
let g:hybrid_reduced_contrast = 1

" NERDTree Configuration
let NERDTreeShowHidden=1
map <C-n> :NERDTreeToggle<CR>
