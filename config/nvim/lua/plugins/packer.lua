-----------------------------------------------------------
-- Plugin manager configuration file
-----------------------------------------------------------

-- Plugin manager: packer.nvim
-- https://github.com/wbthomason/packer.nvim

-- For information about installed plugins see the README
--- neovim-lua/README.md
--- https://github.com/brainfucksec/neovim-lua#readme


local cmd = vim.cmd
cmd [[packadd packer.nvim]]

local packer = require 'packer'

-- Add packages
return packer.startup(function()
  use 'wbthomason/packer.nvim'
  use 'jalvesaq/Nvim-R'
  use 'vim-pandoc/vim-pandoc'
  use 'vim-pandoc/vim-pandoc-syntax'
  use 'lervag/vimtex'
  use 'eigenfoo/stan-vim'
  use 'lifepillar/vim-mucomplete'
  use 'akinsho/bufferline.nvim'
  use 'phaazon/hop.nvim'
  use 'moll/vim-bbye'
  use 'karb94/neoscroll.nvim'
  use 'sunjon/shade.nvim'
  use 'terrortylor/nvim-comment'
  use { 'rrethy/vim-hexokinase', run = 'make hexokinase' }
  use 'preservim/vim-pencil'
  --use 'kyazdani42/nvim-tree.lua'
  use 'lukas-reineke/indent-blankline.nvim'
  use 'kyazdani42/nvim-web-devicons'
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use 'nvim-treesitter/playground'
  use 'neovim/nvim-lspconfig'
  use 'navarasu/onedark.nvim'
  use { 'ibhagwan/fzf-lua', requires = { 'kyazdani42/nvim-web-devicons' }}
  use { 'nvim-lualine/lualine.nvim', requires = { 'kyazdani42/nvim-web-devicons', opt = true }}
end)
