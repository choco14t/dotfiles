autocmd!

filetype plugin indent on
syntax enable

set background=dark
set termguicolors

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
set tabstop=2
set shiftwidth=2

" search
set hlsearch
set incsearch
set ignorecase
set smartcase
set wrapscan

set shell=zsh

" swap file
set directory=~/.vim/tmp

let s:base_dir = expand('~/.dotfiles/.config/nvim')

execute 'set runtimepath+=' . fnamemodify(s:base_dir, ':p')

runtime! keymap.vim
runtime! plug.vim
runtime! telescope.vim
