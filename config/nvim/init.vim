" --------------------------------------------------------------------------------------------------
" plugins
" --------------------------------------------------------------------------------------------------

call plug#begin('~/.vim/plugged')

"Plug 'neovim/nvim-lspconfig'
Plug 'jalvesaq/Nvim-R'
Plug 'jalvesaq/R-Vim-runtime'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'lervag/vimtex'

Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
Plug 'gaalcaras/ncm-R'
Plug 'sirver/UltiSnips'
Plug 'ncm2/ncm2-ultisnips'
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-path'
Plug 'lifepillar/vim-mucomplete'

"Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
"Plug 'nvim-treesitter/playground'
"Plug 'carldelfin/nvcode-color-schemes.vim'
"Plug 'nvim-lua/completion-nvim'
Plug 'hoob3rt/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'machakann/vim-highlightedyank'
Plug 'akinsho/nvim-bufferline.lua'
Plug 'phaazon/hop.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
"Plug 'onsails/lspkind-nvim'
Plug 'moll/vim-bbye'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'aserebryakov/vim-todo-lists'
Plug 'karb94/neoscroll.nvim'
Plug 'sunjon/shade.nvim'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'akinsho/nvim-toggleterm.lua'
Plug 'terrortylor/nvim-comment'
"Plug 'svermeulen/vim-subversive'

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
-- require'lspconfig'.r_language_server.setup()

-- bufferline
require("bufferline").setup{
    options = {
        close_command = "Bdelete",
        separator_style = "slant",
        always_show_bufferline = true
    }
}

-- treesitter
--require'nvim-treesitter.configs'.setup {
--    ensure_installed = "maintained",
--    highlight = {
--        enable = true,
--        additional_vim_regex_highlighting = false
--    }
--}

--require "nvim-treesitter.configs".setup {
--  playground = {
--    enable = true,
--    disable = {},
--    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
--    persist_queries = false -- Whether the query persists across vim sessions
--  }
--}

-- LSP diagnostics
--vim.lsp.diagnostic.show_line_diagnostics()
--vim.lsp.handlers["textDocument/publishDiagnostics"] =
 --   vim.lsp.with(
  --  vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = false }
--)

-- lualine
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

-- shade
require'shade'.setup({
  overlay_opacity = 50,
  opacity_step = 1,
  keys = {
    toggle           = '<A-v>',
  }
})

-- toggleterm
require("toggleterm").setup()

-- comments
require('nvim_comment').setup()

EOF

" --------------------------------------------------------------------------------------------------
" settings
" --------------------------------------------------------------------------------------------------

" completion
"autocmd BufEnter * lua require'completion'.on_attach()
autocmd BufEnter * call ncm2#enable_for_buffer()
set shortmess+=c
set completeopt-=preview
set completeopt+=longest,menuone,noselect

let g:mucomplete#enable_auto_at_startup = 1

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

" change colors using LL cs
"lua << EOF
"vim.api.nvim_set_keymap('n', '<A-b>', [[<Cmd>lua require('onedark').toggle()<CR>]], { noremap = true, silent = true })
"EOF

"let g:onedark_style = 'warmer'
"let g:nvcode_termcolors=256
"colorscheme test 

lua require'colorizer'.setup()

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

" open R automatically when opening .R and .Rmd files
"autocmd FileType r if string(g:SendCmdToR) == "function('SendCmdToR_fake')" | call StartR("R") | endif
"autocmd FileType rmd if string(g:SendCmdToR) == "function('SendCmdToR_fake')" | call StartR("R") | endif

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
vmap <Return> <Plug>RDSendSection
nmap <Return> <Plug>RDSendLine

" Nvim-R object browser
vmap <A-o> <LocalLeader>ro
nmap <A-o> <LocalLeader>ro

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

" hop 
nnoremap <A-c> <cmd>HopLine<cr>
nnoremap <A-d> <cmd>HopWord<cr>
nnoremap <A-v> <cmd>HopChar2<cr>

" comments
" gcc

" buffer control 
nnoremap <silent> tt :BufferLinePick<CR>
nnoremap <silent> <A-s> :BufferLineCyclePrev<CR>
nnoremap <silent> <A-t> :BufferLineCycleNext<CR>
nnoremap <silent> <S-A-s> :BufferLineMovePrev<CR>
nnoremap <silent> <S-A-t> :BufferLineMoveNext<CR>

" replace
nnoremap <leader>r :%s/\<<C-r><C-w>\>//g<left><left>

" completion
"inoremap <A-Space> <C-x><C-o>

highlight HopNextKey guifg=#ff007c guibg=#262b35 gui=bold ctermfg=198 cterm=bold
highlight HopNextKey1 guifg=#00dfff guibg=#262b35 gui=bold ctermfg=45 cterm=bold
highlight HopNextKey2 guifg=#2b8db3 guibg=#262b35 ctermfg=33
highlight HopUnmatched guifg=#666666 guibg=#262b35 ctermfg=242
