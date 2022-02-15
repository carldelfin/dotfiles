vim.cmd [[
  augroup Packer
    autocmd!
    autocmd BufWritePost init.lua PackerCompile
  augroup end
]]

require('settings')
require('keymaps')
require('plugins/packer')
require('plugins/configs')
require('plugins/nvim-lspconfig')
--require('plugins/nvim-tree')
