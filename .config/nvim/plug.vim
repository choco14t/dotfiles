call plug#begin('~/.vim/plugged')
  " Color Scheme / Interface
  Plug 'arcticicestudio/nord-vim'
  Plug 'ryanoasis/vim-devicons'

  " Utilities
  Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
  Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
call plug#end()

colorscheme nord
