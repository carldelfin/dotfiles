" completion settings
set completeopt-=preview
set completeopt+=menu,menuone,noinsert,noselect
set shortmess+=c
set updatetime=300
set timeoutlen=500

" indentation and wrapping
filetype plugin indent on
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set linebreak

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

" use six lines of scrolloff
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
