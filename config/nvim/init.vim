" --------------------------------------------------------------------------------------------------
" plugins
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
Plug 'hoob3rt/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'carldelfin/ayu-vim' 
Plug 'rrethy/vim-hexokinase'

call plug#end()

" --------------------------------------------------------------------------------------------------
" LUA config
" --------------------------------------------------------------------------------------------------

lua << EOF

-- hop
require('hop').setup{}

require('nvim_comment').setup()

require('lualine').setup{
    options = {theme = 'onedark'},
}

-- indent blankline
require("indent_blankline").setup {
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
        "IndentBlanklineIndent6",
    },
}

-- smooth scrolling
require('neoscroll').setup()

-- bufferline
require("bufferline").setup{
    options = {
        close_command = "Bdelete",
        separator_style = "slant",
        always_show_bufferline = true
    }
}

-- shade
require'shade'.setup({
  overlay_opacity = 50,
  opacity_step = 1,
  keys = { toggle = '<A-v>' }
})

EOF

" --------------------------------------------------------------------------------------------------
" settings
" --------------------------------------------------------------------------------------------------

let g:Hexokinase_highlighters = ['backgroundfull']

set completeopt-=preview
set completeopt+=menu,menuone,noinsert,noselect
set shortmess+=c

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

" terminal coloring and syntax highlight

"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  if (has("termguicolors"))
    set termguicolors
  endif
endif

syntax on

" --------------------------------------------------------------------------------------------------
" various settings
" --------------------------------------------------------------------------------------------------

" use zathura to view tex output
let g:vimtex_view_method = 'zathura'

" no folding on startup with vim-pandoc
let g:pandoc#modules#disabled = ["folding"]
let g:pandoc#syntax#conceal#use = 0

" --------------------------------------------------------------------------------------------------
" R specific settings
" --------------------------------------------------------------------------------------------------

" highlight chunk headers as r code
let rrst_syn_hl_chunk = 1
let rmd_syn_hl_chunk = 1
let R_hi_fun = 1
let R_hi_fun_paren = 0
let R_hi_fun_globenv = 0

" make sure R follows colorscheme
let g:rout_follow_colorscheme = 1
let g:Rout_more_colors = 1

" quit R automatically when closing nvim
autocmd VimLeave * if exists("g:SendCmdToR") && string(g:SendCmdToR) != "function('SendCmdToR_fake')" | call RQuit("nosave") | endif

" don't allow syntax folding
let r_syntax_folding = 0

" quietly open R, always horizontal
let R_args = ['--no-save', '--quiet']
let R_rconsole_width = 0

" R may open PDFs once, using zathura, then update that window
let R_openpdf = 1
let R_pdfviewer = "zathura"

" << turns into <-  
let R_assign = 1
let R_assign_map = '<<'


" --------------------------------------------------------------------------------------------------
" colors 
" --------------------------------------------------------------------------------------------------

let ayucolor = "darker" 
colorscheme ayu

" --------------------------------------------------------------------------------------------------
" keybindings
" --------------------------------------------------------------------------------------------------

" leader keys
let mapleader = ","
let maplocalleader="\<space>"

" fzf
nnoremap <A-f> <cmd>FZF<cr>

" send R code
vmap <Return> <Plug>RDSendSection
nmap <Return> <Plug>RDSendLine

" Nvim-R object browser
vmap <A-o> <LocalLeader>ro
nmap <A-o> <LocalLeader>ro

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
nnoremap <C-A-m> :vertical resize -2<CR> " left
nnoremap <C-A-n> :resize +2<CR> " down
nnoremap <C-A-e> :resize -2<CR> " up
nnoremap <C-A-i> :vertical resize +2<CR> " right

" replace
nnoremap <leader>r :%s/\<<C-r><C-w>\>//g<left><left>

" hop 
nnoremap <A-c> <cmd>HopPattern<cr>
nnoremap <A-d> <cmd>HopWord<cr>
nnoremap s <cmd>HopChar1<cr>
omap s <cmd>HopChar1<cr>

" buffer control 
nnoremap <silent> tt :BufferLinePick<CR>
nnoremap <silent> <A-s> :BufferLineCyclePrev<CR>
nnoremap <silent> <A-t> :BufferLineCycleNext<CR>
nnoremap <silent> <S-A-s> :BufferLineMovePrev<CR>
nnoremap <silent> <S-A-t> :BufferLineMoveNext<CR>

" Output the current syntax group
nnoremap jj :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<cr>

