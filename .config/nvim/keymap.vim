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

" Turn off paste mode when leaving insert
autocmd InsertLeave * set nopaste

" NERDTree Configuration
let NERDTreeShowHidden=1
map <C-n> :NERDTreeToggle<CR>
