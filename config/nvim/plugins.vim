" --------------------------------------------------------------------------------------------------
" Plugins
" --------------------------------------------------------------------------------------------------

call plug#begin('~/.vim/plugged')

" r
Plug 'jalvesaq/Nvim-R'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'lervag/vimtex'

" lsp
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/mason.nvim', {'do': ':MasonUpdate'}
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'VonHeikemen/lsp-zero.nvim', {'branch': 'v2.x'}

" autocompletion
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'L3MON4D3/LuaSnip'

" misc
Plug 'EdenEast/nightfox.nvim'
Plug 'phaazon/hop.nvim'
Plug 'moll/vim-bbye'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'karb94/neoscroll.nvim'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'terrortylor/nvim-comment'
Plug 'preservim/vim-pencil'

call plug#end()
