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
Plug 'ryanoasis/vim-devicons'

call plug#end()

" --------------------------------------------------------------------------------------------------
" Status line
" --------------------------------------------------------------------------------------------------

let g:currentmode={
      \ 'n'  : 'n',
      \ 'v'  : 'v',
      \ 'V'  : 'vl',
      \ ''   : 'vb',
      \ 'i'  : 'i',
      \ 'R'  : 'r',
      \ 'Rv' : 'rv',
      \ 'c'  : 'c',
      \ 't'  : 'f',
      \}

function! GitBranch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatuslineGit()
  let l:branchname = GitBranch()
  return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
endfunction

set laststatus=2
set statusline=
set statusline+=%#NormalColor#%{(g:currentmode[mode()]=='n')?'\ \ normal\ ':''}
set statusline+=%#InsertColor#%{(g:currentmode[mode()]=='i')?'\ \ insert\ ':''}
set statusline+=%#ReplaceColor#%{(g:currentmode[mode()]=='r')?'\ \ replace\ ':''}
set statusline+=%#ReplaceColor#%{(g:currentmode[mode()]=='rv')?'\ \ v-replace\ ':''}
set statusline+=%#VisualColor#%{(g:currentmode[mode()]=='v')?'\ \ visual\ ':''}
set statusline+=%#VisualColor#%{(g:currentmode[mode()]=='vl')?'\ \ v-line\ ':''}
set statusline+=%#VisualColor#%{(g:currentmode[mode()]=='vb')?'\ \ v-block\ ':''}
set statusline+=%#CommandColor#%{(g:currentmode[mode()]=='c')?'\ \ command\ ':''}
set statusline+=%#NormalColor#%{(g:currentmode[mode()]=='f')?'\ \ find\ ':''}
set statusline+=%4*
set statusline+=%{StatuslineGit()}
set statusline+=%1*
set statusline+=\ 
set statusline+=%t
set statusline+=\ 
set statusline+=%2*
set statusline+=%=
set statusline+=%{strlen(&fenc)?&fenc:'none'}
set statusline+=\  
set statusline+=\| 
set statusline+=\  
set statusline+=%{&ff}
set statusline+=\  
set statusline+=\| 
set statusline+=\  
set statusline+=%{expand(&filetype)}
set statusline+=\ 
set statusline+=%3*
set statusline+=\ 
set statusline+=%P
set statusline+=\ 
set statusline+=%4*
set statusline+=\ 
set statusline+=%02v
set statusline+=\  
set statusline+=%l
set statusline+=\:
set statusline+=%L
set statusline+=\ 

" --------------------------------------------------------------------------------------------------
" LUA config
" --------------------------------------------------------------------------------------------------

lua << EOF

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

set completeopt-=preview
set completeopt+=menu,menuone,noinsert,noselect
set shortmess+=c

let g:mucomplete#enable_auto_at_startup = 1
let g:mucomplete#chains = {}
let g:mucomplete#chains.default = ['file', 'omni', 'keyn', 'dict', 'ulti']
let g:mucomplete#chains.unite = []
let g:mucomplete#completion_delay = 1

" indentation
filetype plugin indent on
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent

" no highlight during search
" set nohlsearch

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
set termguicolors
syntax on

" --------------------------------------------------------------------------------------------------
" various settings
" --------------------------------------------------------------------------------------------------

" use zathura to view tex output
let g:vimtex_view_method = 'zathura'

" no folding on startup with vim-pandoc
let g:pandoc#modules#disabled = ["folding", "spell"]
let g:pandoc#syntax#conceal#use = 0

" --------------------------------------------------------------------------------------------------
" R specific settings
" --------------------------------------------------------------------------------------------------

" highlight chunk headers as r code
let rrst_syn_hl_chunk = 1
let rmd_syn_hl_chunk = 1
let R_hi_fun = 1
let R_hi_fun_paren = 1
let R_hi_fun_globenv = 1

" make sure R follows colorscheme
let g:rout_follow_colorscheme = 1
let g:Rout_more_colors = 1

" quit R automatically when closing nvim
autocmd VimLeave * if exists("g:SendCmdToR") && string(g:SendCmdToR) != "function('SendCmdToR_fake')" | call RQuit("nosave") | endif

" don't allow syntax folding
let r_syntax_folding = 0

let R_args = ['--no-save', '--quiet']

" R may open PDFs once, using zathura, then update that window
let R_openpdf = 1
let R_pdfviewer = "zathura"

" << turns into <-  
let R_assign = 1
let R_assign_map = '<<'

colorscheme northernlights 

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

