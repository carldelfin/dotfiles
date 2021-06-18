" ---------------------------------------------------------------------------------------------------------------------
" plugins
" ---------------------------------------------------------------------------------------------------------------------

call plug#begin('~/.vim/plugged')

" nvim-r 
Plug 'jalvesaq/Nvim-R'
Plug 'jalvesaq/R-Vim-runtime'

" completion using tab
Plug 'lifepillar/vim-mucomplete'

" lualine.nvim
Plug 'hoob3rt/lualine.nvim'

" line indentation
Plug 'lukas-reineke/indent-blankline.nvim', { 'branch': 'lua' }

" highlight yanks
Plug 'machakann/vim-highlightedyank'

" colorscheme
Plug 'tjdevries/colorbuddy.vim'
Plug 'Th3Whit3Wolf/onebuddy'

" buffer tabs
Plug 'akinsho/nvim-bufferline.lua'

" pandoc
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'

" fade inactive buffers
Plug 'TaDaa/vimade'
let g:vimade = {}
let g:vimade.fadelevel = 0.7

" hop.nvim
Plug 'phaazon/hop.nvim'

" fuzzy find
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'chengzeyi/fzf-preview.vim'
let g:fzf_command_prefix = 'FZF'

" nvimtree.lua
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'ryanoasis/vim-devicons'

" bbye
Plug 'moll/vim-bbye'

" smooth scrolling
Plug 'karb94/neoscroll.nvim'

" save sessions
Plug 'tpope/vim-obsession'

call plug#end()

" ---------------------------------------------------------------------------------------------------------------------
" settings
" ---------------------------------------------------------------------------------------------------------------------

" tabs
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent

" no highlight during search
set nohlsearch

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

" try to keep within 120 characters
set colorcolumn=120

" allow mouse in normal mode
set mouse=n

" highlight matched parens, brackets, beginning and end of code blocks
set showmatch

" ---------------------------------------------------------------------------------------------------------------------
" appearance
" ---------------------------------------------------------------------------------------------------------------------

let g:indentLine_char='│'
let g:indent_blankline_space_char='·'
let g:indent_blankline_filetype_exclude=['term']
let g:indent_blankline_show_first_indent_level=v:true
let g:indent_blankline_show_trailing_blankline_indent=v:false

" Filetype {{{
filetype plugin indent on
" }}}
"

if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

set termguicolors

lua require('neoscroll').setup()

syntax enable
syntax on

set encoding=utf8
set t_Co=256
set t_ut=

lua require('colorbuddy').colorscheme('onebuddy')

" --------------------------------------------------------------
" various settings
" --------------------------------------------------------------

" mucomplete settings
set completeopt+=menuone,noselect
set shortmess+=c   " Shut off completion messages
set belloff+=ctrlg " If Vim beeps during completion
let g:mucomplete#enable_auto_at_startup = 1

" use zathura to view tex output
let g:vimtex_view_method = 'zathura'

" no folding on startup with vim-pandoc
let g:pandoc#modules#disabled = ["folding", "spell"]
let g:pandoc#syntax#conceal#use = 0

" --------------------------------------------------------------
" R specific settings
" --------------------------------------------------------------

" highlight chunk headers as r code
let rrst_syn_hl_chunk = 1
let rmd_syn_hl_chunk = 1

" open R automatically when opening .R and .Rmd files
"autocmd FileType r if string(g:SendCmdToR) == "function('SendCmdToR_fake')" | call StartR("R") | endif
"autocmd FileType rmd if string(g:SendCmdToR) == "function('SendCmdToR_fake')" | call StartR("R") | endif

" make sure R follows colorscheme
let g:rout_follow_colorscheme = 1
let g:Rout_more_colors = 1

" quit R automatically when closing nvim
autocmd VimLeave * if exists("g:SendCmdToR") && string(g:SendCmdToR) != "function('SendCmdToR_fake')" | call RQuit("nosave") | endif

" allow syntax folding, but unfolded when open
let r_syntax_folding = 1
set nofoldenable

" startup libraries
let R_start_libs = 'base,stats,graphics,grDevices,utils,methods,tidyverse'

" R may open PDFs once, using zathura, then update that window
let R_openpdf = 1
let R_pdfviewer = "zathura"

" use Ctrl+Space to do omnicompletion:
if has('nvim') || has('gui_running')
    inoremap <C-Space> <C-x><C-o>
else
    inoremap <Nul> <C-x><C-o>
endif

" don't turn _ into <- 
let R_assign = 0

" always place console to the right 
let R_rconsole_width = 57
let R_min_editor_width = 18

" always place object browser to the right with specific width
let R_objbr_place = "RIGHT"
let R_objbr_w = 30

" --------------------------------------------------------------
" keybindings
" --------------------------------------------------------------

" leader keys
let mapleader = ","
let maplocalleader="\<space>"

" toggle NvimTree
nnoremap <C-n> :NvimTreeToggle<CR>
"nnoremap <C-r> :NvimTreeRefresh<CR>

" select buffers using df
nnoremap <silent> df :BufferLinePick<CR>

let g:nvim_tree_auto_open = 0
let g:nvim_tree_auto_close = 1
let g:nvim_tree_indent_markers = 1

" fuzzy search
noremap <C-p> :FZF<CR>

" use return to send R code
vmap <Return> <Plug>RDSendSelection
nmap <Return> <Plug>RDSendLine

" open Nvim-R object browser
vmap <C-o> <LocalLeader>ro
nmap <C-o> <LocalLeader>ro

" remap Esc to kj
inoremap kj <Esc>

" move between windows using control+ijkl
nnoremap <C-h> <C-w>h " left
nnoremap <C-j> <C-w>j " down
nnoremap <C-k> <C-w>k " up
nnoremap <C-l> <C-w>l " right

" jump to char using bigram
nnoremap <LocalLeader>j <cmd>HopWord<cr>
nnoremap <LocalLeader>h <cmd>HopChar2<cr>
"nmap <C-c> <cmd>HopPattern><cr>
nnoremap <LocalLeader>k <cmd>HopLine<cr>

" modify linenumber colors 
highlight LineNr term=bold cterm=NONE ctermbg=NONE gui=NONE guifg=DarkGray
highlight CursorLineNr term=bold gui=bold guifg=LightGreen

" modify background color
highlight Normal cterm=NONE ctermbg=17 gui=NONE guibg=#1e222a

lua <<EOF
require('bufferline').setup {
  options = {
    offsets = {{filetype = "NvimTree", text = "", highlight = "Directory"}},
  }
}
require'lualine'.setup {
  options = {
    icons_enabled = true,
    theme = 'onedark',
    section_separators = {'', ''},
    component_separators = {'', ''},
    disabled_filetypes = {}
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
}
EOF

highlight HopNextKey guifg=#ff007c gui=bold ctermfg=198 cterm=bold
highlight HopNextKey1 guifg=#00dfff guibg=#262b35 gui=bold ctermfg=45 cterm=bold
highlight HopNextKey2 guifg=#2b8db3 guibg=#262b35 ctermfg=33
highlight HopUnmatched guifg=#666666 guibg=#262b35 ctermfg=242
