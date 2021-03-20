" --------------------------------------------------------------
" plugins
" --------------------------------------------------------------

call plug#begin('~/.vim/plugged')

" ncm2 and related
Plug 'ncm2/ncm2'
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-path'
Plug 'ncm2/ncm2-ultisnips'
Plug 'roxma/nvim-yarp'
Plug 'sirver/ultiSnips'
Plug 'gaalcaras/ncm-R'

" nvim-r and related
Plug 'jalvesaq/Nvim-R'
Plug 'jalvesaq/R-Vim-runtime'

" airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" nerdtree
Plug 'preservim/nerdtree'

" appearance
Plug 'Yggdroot/indentLine'
Plug 'tomasiser/vim-code-dark'
Plug 'machakann/vim-highlightedyank'

" buffer control
Plug 'ap/vim-buftabline'
Plug 'kien/ctrlp.vim'

" citations
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'

augroup ncm2
    autocmd BufEnter * call ncm2#enable_for_buffer()
    set completeopt=noinsert,menuone,noselect
    inoremap <c-c> <ESC>
augroup END

call plug#end()

" --------------------------------------------------------------
" various settings
" --------------------------------------------------------------

set mouse=n
set ma
set number
set autoindent
set si 
set showmatch

" make sure R follows colorscheme
let g:rout_follow_colorscheme = 1
let g:Rout_more_colors = 1

" use okular to view tex output
let g:vimtex_view_method = 'okular'

" allow buffers to be hidden if modified
set hidden

" disable folding of vim-pandoc plugin
let g:pandoc#modules#disabled = ["folding"]

" exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
    \ quit | endif

" let NERDTree and CtrlP show hidden files by default
let NERDTreeShowHidden = 1
let g:ctrlp_show_hidden = 1

" --------------------------------------------------------------
" R specific settings
" --------------------------------------------------------------

" open R automatically when opening .R and .Rmd files
autocmd FileType r if string(g:SendCmdToR) == "function('SendCmdToR_fake')" | call StartR("R") | endif
autocmd FileType rmd if string(g:SendCmdToR) == "function('SendCmdToR_fake')" | call StartR("R") | endif

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

" --------------------------------------------------------------
" keybindings
" --------------------------------------------------------------

" use tab as local leader
let maplocalleader = "\<tab>"

" toggle NERDTree using control+t
nnoremap <C-t> :NERDTreeToggle<CR>

" move between windows using control+jikl
nnoremap <C-j> <C-w>h
nnoremap <C-k> <C-w>j
nnoremap <C-i> <C-w>k
nnoremap <C-l> <C-w>l

" use space to send R code
vmap <Space> <Plug>RDSendSelection
nmap <Space> <Plug>RDSendLine

" copy/paste using control+v and control+p
"vmap <C-c> "+yi
"vmap <C-x> "+c
"vmap <C-v> c<ESC>"+p
"imap <C-v> <ESC>"+pa

" open Nvim-R object browser
vmap <C-o> <LocalLeader>ro
nmap <C-o> <LocalLeader>ro

" toggle between buffers with control+w and control+q
nnoremap <C-w> :bnext<CR>
nnoremap <C-q> :bprev<CR>

" activate CtrlP using control+p
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

" --------------------------------------------------------------
" appearance
" --------------------------------------------------------------

syntax enable
syntax on
set encoding=utf8
set t_Co=256
set t_ut=
colorscheme codedark
set cursorline
let g:airline_theme='codedark'
