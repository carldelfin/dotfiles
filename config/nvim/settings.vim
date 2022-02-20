" completion settings
set omnifunc=v:lua.vim.lsp.omnifunc
set noinfercase
set completeopt-=preview
set completeopt+=menuone,noselect
set shortmess+=c
"set updatetime=300
"set timeoutlen=500

" indentation
filetype plugin indent on
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent

" spelling
set spelllang=en_us,sv

" allow buffers to be hidden if modified
set hidden

" show hybrid line numbers
set number relativenumber

" case insensitive search until cap
set smartcase

" use incremental search
set incsearch

" highlight current line
set cursorline 

" turn off error bells
set noerrorbells

" turn off swapping and backup
set noswapfile
set nobackup

" use eight lines of scrolloff
set scrolloff=6

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
