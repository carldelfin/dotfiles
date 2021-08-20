" --------------------------------------------------------------------------------------------------
" plugins
" --------------------------------------------------------------------------------------------------

call plug#begin('~/.vim/plugged')

Plug 'neovim/nvim-lspconfig'
Plug 'jalvesaq/Nvim-R'
Plug 'jalvesaq/R-Vim-runtime'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'lervag/vimtex'
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
Plug 'folke/tokyonight.nvim'
Plug 'rktjmp/lush.nvim'
Plug 'ellisonleao/gruvbox.nvim'
Plug 'marko-cerovac/material.nvim'
Plug 'nvim-lua/completion-nvim'
Plug 'hoob3rt/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'machakann/vim-highlightedyank'
Plug 'akinsho/nvim-bufferline.lua'
Plug 'phaazon/hop.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'onsails/lspkind-nvim'
Plug 'moll/vim-bbye'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'aserebryakov/vim-todo-lists'
Plug 'karb94/neoscroll.nvim'

call plug#end()

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
    show_trailing_blankline_indent = false
}

-- smooth scrollling
require('neoscroll').setup()

-- R language server
require'lspconfig'.r_language_server.setup{}

-- bufferline
require("bufferline").setup{
    options = {
        close_command = "Bdelete",
        separator_style = "slant",
        always_show_bufferline = true
    }
}

-- treesitter
require'nvim-treesitter.configs'.setup {
    ensure_installed = "maintained",
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false
    }
}

-- LSP diagnostics
vim.lsp.diagnostic.show_line_diagnostics()
vim.lsp.handlers["textDocument/publishDiagnostics"] =
    vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = false }
)

-- lualine
require'lualine'.setup {
  options = {
    icons_enabled = true,
    theme = 'gruvbox',
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

-- lsplind
require('lspkind').init({
    with_text = true,
    preset = 'default',
    symbol_map = {
      Text = "",
      Method = "",
      Function = "",
      Constructor = "",
      Field = "ﰠ",
      Variable = "",
      Class = "ﴯ",
      Interface = "",
      Module = "",
      Property = "ﰠ",
      Unit = "塞",
      Value = "",
      Enum = "",
      Keyword = "",
      Snippet = "",
      Color = "",
      File = "",
      Reference = "",
      Folder = "",
      EnumMember = "",
      Constant = "",
      Struct = "פּ",
      Event = "",
      Operator = "",
      TypeParameter = ""
    },
})

EOF

" --------------------------------------------------------------------------------------------------
" settings
" --------------------------------------------------------------------------------------------------

" completion
autocmd BufEnter * lua require'completion'.on_attach()
set completeopt=menuone,noinsert,noselect
set shortmess+=c

" indentation
filetype plugin indent on
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

if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

syntax on

set encoding=utf8
set t_Co=256
set t_ut=

"let g:tokyonight_style = "night"
"let g:tokyonight_italic_functions = 1
"colorscheme tokyonight

let g:gruvbox_contrast_dark = "hard"
set background=dark " or light if you want light mode
colorscheme gruvbox

"let g:material_italic_strings = v:true
"let g:material_italic_functions = v:true
"let g:material_italic_comments = v:true
"let g:material_style = 'darker'
"colorscheme material

" --------------------------------------------------------------------------------------------------
" various settings
" --------------------------------------------------------------------------------------------------

" use zathura to view tex output
let g:vimtex_view_method = 'zathura'

" no folding on startup with vim-pandoc
let g:pandoc#modules#disabled = ["folding", "spell"]
let g:pandoc#syntax#conceal#use = 0

" netrw
let g:netrw_banner = 0
let g:netrw_liststyle = 3

" --------------------------------------------------------------------------------------------------
" R specific settings
" --------------------------------------------------------------------------------------------------

" highlight chunk headers as r code
let rrst_syn_hl_chunk = 1
let rmd_syn_hl_chunk = 1

" open R automatically when opening .R and .Rmd files
autocmd FileType r if string(g:SendCmdToR) == "function('SendCmdToR_fake')" | call StartR("R") | endif
autocmd FileType rmd if string(g:SendCmdToR) == "function('SendCmdToR_fake')" | call StartR("R") | endif

" make sure R follows colorscheme
let g:rout_follow_colorscheme = 1
let g:Rout_more_colors = 1

" quit R automatically when closing nvim
autocmd VimLeave * if exists("g:SendCmdToR") && string(g:SendCmdToR) != "function('SendCmdToR_fake')" | call RQuit("nosave") | endif

" don't allow syntax folding
let r_syntax_folding = 0

" R may open PDFs once, using zathura, then update that window
let R_openpdf = 1
let R_pdfviewer = "zathura"

" don't turn _ into <- 
let R_assign = 0

" always place console to the right 
let R_rconsole_width = 57
let R_min_editor_width = 18

" always place object browser to the right with specific width
let R_objbr_place = "RIGHT"
let R_objbr_w = 30

" --------------------------------------------------------------------------------------------------
" keybindings
" --------------------------------------------------------------------------------------------------

" leader keys
let mapleader = ","
let maplocalleader="\<space>"

" telescope
nnoremap <A-f> <cmd>Telescope file_browser hidden=true<cr>
nnoremap <A-p> <cmd>Telescope find_files hidden=true<cr>

" send R code
vmap <Return> <Plug>RDSendSelection
nmap <Return> <Plug>RDSendLine

" Nvim-R object browser
vmap <A-o> <LocalLeader>ro
nmap <A-o> <LocalLeader>ro

" window movement
nnoremap <A-m> <C-w>h " left
nnoremap <A-n> <C-w>j " down
nnoremap <A-e> <C-w>k " up
nnoremap <A-i> <C-w>l " right

" hop 
nnoremap <A-s> <cmd>HopLine<cr>
nnoremap <A-t> <cmd>HopWord<cr>
nnoremap <A-g> <cmd>HopChar2<cr>

" buffer control 
nnoremap <silent> tt :BufferLinePick<CR>
nnoremap <silent> <A-m> :BufferLineCyclePrev<CR>
nnoremap <silent> <A-i> :BufferLineCycleNext<CR>
nnoremap <silent> <S-A-m> :BufferLineMovePrev<CR>
nnoremap <silent> <S-A-i> :BufferLineMoveNext<CR>

" completion popup navigation
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" material style
nnoremap <LocalLeader>mm :lua require('material.functions').toggle_style()<CR>
