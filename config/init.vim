" ==============================================================
" Plugins
" ==============================================================

call plug#begin('~/.vim/plugged')

Plug 'ncm2/ncm2'
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-path'
Plug 'sirver/ultiSnips'
Plug 'ncm2/ncm2-ultisnips'
Plug 'roxma/nvim-yarp'
Plug 'jalvesaq/Nvim-R'
Plug 'jalvesaq/R-Vim-runtime'
Plug 'gaalcaras/ncm-R'
Plug 'jalvesaq/zotcite'
Plug 'Yggdroot/indentLine'
Plug 'tomasiser/vim-code-dark'
Plug 'preservim/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'machakann/vim-highlightedyank'
Plug 'ap/vim-buftabline'
Plug 'kien/ctrlp.vim'

augroup ncm2
    autocmd BufEnter * call ncm2#enable_for_buffer()
    set completeopt=noinsert,menuone,noselect
    inoremap <c-c> <ESC>
augroup END

call plug#end()

" ==============================================================
" Keybindings
" ==============================================================

" Various
let maplocalleader = "\<tab>"
nnoremap <C-t> :NERDTreeToggle<CR>

" R
vmap <Space> <Plug>RDSendSelection
nmap <Space> <Plug>RDSendLine

nnoremap <C-j> <C-w>h
nnoremap <C-k> <C-w>j
nnoremap <C-i> <C-w>k
nnoremap <C-l> <C-w>l

" Copy and paste using C-v and C-p
vmap <C-c> "+yi
vmap <C-x> "+c
vmap <C-v> c<ESC>"+p
imap <C-v> <ESC>"+pa

" Nvim-R object browser
vmap <C-o> <LocalLeader>ro
nmap <C-o> <LocalLeader>ro

" buffers
nnoremap <C-x> :bnext<CR>
nnoremap <C-z> :bprev<CR>

let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

" ==============================================================
" Syntax highlighting
" ==============================================================

syntax enable
syntax on
set encoding=utf8
set t_Co=256
set t_ut=
colorscheme codedark
set cursorline
let g:airline_theme='codedark'

" ==============================================================
" Settings
" ==============================================================

set mouse=n
set ma
set number
set autoindent
set si 
set showmatch

let g:rout_follow_colorscheme = 1
let g:Rout_more_colors = 1

let g:vimtex_view_method = 'okular'

" allow buffers to be hidden if modified
set hidden

" --------------------------------------------------------------
" NERDTree
" --------------------------------------------------------------

" Start NERDTree and put the cursor back in the other window.
" autocmd VimEnter * NERDTree | wincmd p
autocmd VimEnter * NERDTree

" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
    \ quit | endif

" Open the existing NERDTree on each new tab.
autocmd BufWinEnter * silent NERDTreeMirror

" --------------------------------------------------------------
" R
" --------------------------------------------------------------

"autocmd FileType r if string(g:SendCmdToR) == "function('SendCmdToR_fake')" | call StartR("R") | endif
"autocmd FileType rmd if string(g:SendCmdToR) == "function('SendCmdToR_fake')" | call StartR("R") | endif

let R_in_buffer=0
let R_term_cmd = 'kitty'
let R_openpdf = 2
let R_pdfviewer = "okular"

" Radian settings
let R_app = "radian"
let R_cmd = "R"
let R_hl_term = 0
let R_args = []  " if you had set any
let R_bracketed_paste = 1

" object browser
let R_objbr_place = 'script,right'
let R_objbr_place = 'console,left'
let R_objbr_w = 20

" console settings
let R_rconsole_width = 100
let R_min_editor_width = 100
set nosplitright

"autocmd VimResized * let R_rconsole_width = winwidth(0) / 2
"let R_rconsole_width = winwidth(0) / 2

"autocmd VimEnter * wincmd l
