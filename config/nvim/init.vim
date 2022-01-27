" --------------------------------------------------------------------------------------------------
" Plugins
" --------------------------------------------------------------------------------------------------

call plug#begin('~/.vim/plugged')

Plug 'jalvesaq/Nvim-R'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'lervag/vimtex'
Plug 'lifepillar/vim-mucomplete'
Plug 'akinsho/bufferline.nvim'
Plug 'machakann/vim-highlightedyank'
Plug 'phaazon/hop.nvim'
Plug 'moll/vim-bbye'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'karb94/neoscroll.nvim'
Plug 'sunjon/shade.nvim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'terrortylor/nvim-comment'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'carldelfin/ayur' 
Plug 'rrethy/vim-hexokinase'
Plug 'preservim/nerdtree'
Plug 'preservim/vim-pencil'

call plug#end()

" --------------------------------------------------------------------------------------------------
" Status line 
" --------------------------------------------------------------------------------------------------

set laststatus=2
set statusline=
set statusline+=%#NormalColor#%{(mode()=='n')?'\ \ NORMAL\ ':''}
set statusline+=%#InsertColor#%{(mode()=='i')?'\ \ INSERT\ ':''}
set statusline+=%#ReplaceColor#%{(mode()=='R')?'\ \ REPLACE\ ':''}
set statusline+=%#VisualColor#%{(mode()=='v')?'\ \ VISUAL\ ':''}
set statusline+=%1*
set statusline+=\ 
set statusline+=%f
set statusline+=%=
set statusline+=%{strlen(&fenc)?&fenc:'none'}
set statusline+=\ 
set statusline+=%y
set statusline+=\ 
set statusline+=%l
set statusline+=: 
set statusline+=%L
set statusline+=\ 
set statusline+=[ 
set statusline+=%c
set statusline+=] 

" --------------------------------------------------------------------------------------------------
" LUA configs
" --------------------------------------------------------------------------------------------------

lua << EOF

require('hop').setup{}
require('nvim_comment').setup{}
require('neoscroll').setup{}

require("indent_blankline").setup{
    char = "│",
    buftype_exclude = {"terminal"},
    space_char = ' ',
    show_first_indent_level = true,
    show_trailing_blankline_indent = false,
    char_highlight_list = {
        "IndentBlanklineIndent1",
        "IndentBlanklineIndent2",
        "IndentBlanklineIndent3",
        "IndentBlanklineIndent4",
        "IndentBlanklineIndent5",
        "IndentBlanklineIndent6"}
}

require("bufferline").setup{
    options = {
        close_command = "Bdelete",
        separator_style = "slant",
        always_show_bufferline = true}
}

require'shade'.setup{
  overlay_opacity = 50,
  opacity_step = 1,
  keys = { toggle = '<A-v>' }
}

EOF

" --------------------------------------------------------------------------------------------------
" Various settings
" --------------------------------------------------------------------------------------------------

" hexokinase should highlight background
let g:Hexokinase_highlighters = ['backgroundfull']

" completion settings
set completeopt-=preview
set completeopt+=menu,menuone,noinsert,noselect
set shortmess+=c
set updatetime=300
set timeoutlen=500

let g:mucomplete#enable_auto_at_startup = 1
let g:mucomplete#chains = {}
let g:mucomplete#chains.default = ['file', 'omni', 'keyn', 'dict', 'ulti']
let g:mucomplete#chains.unite = []

" indentation
filetype plugin indent on
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent

" spelling and language
set spelllang=en_us,sv

" allow buffers to be hidden if modified
set hidden

" show hybrid line numbers
set number relativenumber

" case insensitive search until cap
set smartcase

" highlight current line
set cursorline 

" turn off error bells
set noerrorbells

" turn off swapping and backup
set noswapfile
set nobackup

" use incremental search
set incsearch

" use eight lines of scrolloff
set scrolloff=8

" try to keep within 100 characters
set colorcolumn=100

" allow mouse in normal mode
set mouse=n

" highlight matched parens, brackets, beginning and end of code blocks
set showmatch

" no redraw during macros
set lazyredraw

 " turn off folding
set nofoldenable

" split settings
set splitbelow
set splitright

" don't continue comment lines
set formatoptions-=cro

" terminal coloring and syntax highlight
syntax on

if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

" pencil
let g:pencil#wrapModeDefault = 'soft'
augroup pencil
  autocmd!
  autocmd FileType text,rmarkdown,markdown,mkd call pencil#init()
augroup END

" use zathura to view tex output
let g:vimtex_view_method = 'zathura'

" no folding on startup with vim-pandoc
let g:pandoc#modules#disabled = ["folding"]
let g:pandoc#syntax#conceal#use = 0

" ------------------------------------------------------------------------------------------------
" R specific settings
" ------------------------------------------------------------------------------------------------

let rrst_syn_hl_chunk = 1
let rmd_syn_hl_chunk = 1
let R_hi_fun = 1
let R_hi_fun_paren = 0
let R_hi_fun_globenv = 0

" don't expand a dataframe to show columns
let R_objbr_opendf = 0

" make sure R follows colorscheme
let g:rout_follow_colorscheme = 1
let g:Rout_more_colors = 1

" quit R automatically when closing nvim
autocmd VimLeave * if exists("g:SendCmdToR") && string(g:SendCmdToR) != "function('SendCmdToR_fake')" | call RQuit("nosave") | endif

" don't allow syntax folding
let r_syntax_folding = 0

" quietly open R
let R_args = ['--no-save', '--quiet']
let R_rconsole_width = 100

" R may open PDFs once, using zathura, then update that window
let R_openpdf = 1
let R_pdfviewer = "zathura"

" << turns into <-  
let R_assign = 1
let R_assign_map = '<<'

" >> turns into %>%
autocmd FileType r inoremap <buffer> >> <Esc>:normal! a %>%<CR>a 
autocmd FileType rnoweb inoremap <buffer> >> <Esc>:normal! a %>%<CR>a 
autocmd FileType rmd inoremap <buffer> >> <Esc>:normal! a %>%<CR>a 

" --------------------------------------------------------------------------------------------------
" Colorscheme 
" --------------------------------------------------------------------------------------------------

let ayurcolor = "darker" 
colorscheme ayur

" make sure fzf follows ayur theme 
let g:fzf_colors =
            \ { 'fg':    ['fg', 'Normal'],
            \ 'bg':      ['bg', 'Normal'],
            \ 'hl':      ['fg', 'HopNextKey1'],
            \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
            \ 'bg+':     ['bg', 'Normal', 'CursorColumn'],
            \ 'hl+':     ['fg', 'HopNextKey'],
            \ 'info':    ['fg', 'Comment'],
            \ 'border':  ['fg', 'Constant'],
            \ 'prompt':  ['fg', 'Constant'],
            \ 'pointer': ['fg', 'Comment'],
            \ 'marker':  ['fg', 'Keyword'],
            \ 'spinner': ['fg', 'Label'],
            \ 'header':  ['fg', 'Comment'] }

" --------------------------------------------------------------------------------------------------
" Keybindings
" --------------------------------------------------------------------------------------------------

" leader keys
let mapleader = ","
let maplocalleader="\<space>"

" sensible defaults
nnoremap Y y$
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z

inoremap , ,<C-g>u
inoremap . .<C-g>u
inoremap ! !<C-g>u
inoremap ? ?<C-g>u

vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

nnoremap <leader><CR> :so %<CR>

" save and quit
nnoremap <C-s> :w<CR>
nnoremap <C-q> :q<CR>

" toggle nerdtree
nnoremap <C-t> :NERDTreeToggle<CR>

" switch window orientation
nnoremap <A-w> :wincmd H<CR>
nnoremap <S-A-w> :wincmd J<CR>

" fzf
nnoremap <A-f> <cmd>FZF<cr>


" omnicompletion (redundant?)
if has('nvim') || has('gui_running')
    inoremap <C-Space> <C-x><C-o>
else
    inoremap <Nul> <C-x><C-o>
endif

" window movement
nnoremap <A-m> <C-w>h " left
nnoremap <A-n> <C-w>j " down
nnoremap <A-e> <C-w>k " up
nnoremap <A-i> <C-w>l " right

" window resize 
nnoremap <S-A-m> :vertical resize -2<CR> " left
nnoremap <S-A-n> :resize +2<CR> " down
nnoremap <S-A-e> :resize -2<CR> " up
nnoremap <S-A-i> :vertical resize +2<CR> " right

" hop 
nnoremap <A-c> <cmd>HopChar2<cr>
nnoremap <A-d> <cmd>HopPattern<cr>
nnoremap s <cmd>HopChar1<cr>
omap s <cmd>HopChar1<cr>

" buffer control 
nnoremap <silent> tt :BufferLinePick<CR>
nnoremap <silent> <A-s> :BufferLineCyclePrev<CR>
nnoremap <silent> <A-t> :BufferLineCycleNext<CR>
nnoremap <silent> <S-A-s> :BufferLineMovePrev<CR>
nnoremap <silent> <S-A-t> :BufferLineMoveNext<CR>

" output the current syntax group 
" (temporary; for developing colorscheme)
nnoremap jj :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<cr>

" --------------------------------------------------------------------------------------------------
" R specific keybindings
" --------------------------------------------------------------------------------------------------

" send R code
vmap <Return> <Plug>RDSendSection
nmap <Return> <Plug>RDSendLine

" Nvim-R object browser
vmap <A-o> <LocalLeader>ro
nmap <A-o> <LocalLeader>ro
