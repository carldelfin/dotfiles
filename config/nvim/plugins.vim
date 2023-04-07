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
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'phaazon/hop.nvim'
Plug 'machakann/vim-highlightedyank'
Plug 'moll/vim-bbye'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'karb94/neoscroll.nvim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
Plug 'terrortylor/nvim-comment'
Plug 'preservim/vim-pencil'

call plug#end()
