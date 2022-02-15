-----------------------------------------------------------
-- Keymaps configuration file: keymaps of neovim
-- and plugins.
-----------------------------------------------------------

local map = vim.api.nvim_set_keymap
local default_opts = { noremap = true, silent = true }

vim.g.mapleader = ','
vim.g.maplocalleader = " "

-----------------------------------------------------------
-- Neovim shortcuts:
-----------------------------------------------------------

-- window movement based on colemak-dh
map('n', '<A-m>', '<C-w>h', { noremap = true })
map('n', '<A-n>', '<C-w>j', { noremap = true })
map('n', '<A-e>', '<C-w>k', { noremap = true })
map('n', '<A-i>', '<C-w>l', { noremap = true })

-- window resize based on colemak-dh
map('n', '<S-A-m>', ':vertical resize -2<CR>', { noremap = true })
map('n', '<S-A-n>', ':resize +2>CR>', { noremap = true })
map('n', '<S-A-e>', ':resize -2<CR>', { noremap = true })
map('n', '<S-A-i>', ':vertical resize +2<CR>', { noremap = true })

-- sensible defaults
map('n', 'Y', 'y$', { noremap = true })
map('n', 'n', 'nzzzv', { noremap = true })
map('n', 'N', 'Nzzzv', { noremap = true })
map('n', 'J', 'mzJ`z', { noremap = true })

map('i', ',', ',<C-g>u', { noremap = true })
map('i', '.', '.<C-g>u', { noremap = true })
map('i', '!', '!<C-g>u', { noremap = true })
map('i', '?', '?<C-g>u', { noremap = true })

-- nvim-tree
map('n', '<C-t>', ':NvimTreeToggle<CR>', { noremap = true })
--map('n', '<C-r>', ':NvimTreeRefresh<CR>', { noremap = true})

-- fzf
map('n', '<A-f>', "<cmd>lua require('fzf-lua').files()<CR>", { noremap = true, silent = true })

-- output highlight group
map('n', 'jj', ":TSHighlightCapturesUnderCursor<CR>", default_opts)

-- save
map('n', '<C-s>', ':w<CR>', default_opts)

-- buffer control
map('n', 'tt', ':BufferLinePick<CR>', default_opts)
map('n', '<A-s>', ':BufferLineCyclePrev<CR>', default_opts)
map('n', '<A-t>', ':BufferLineCycleNext<CR>', default_opts)
map('n', '<S-A-s>', ':BufferLineMovePrev<CR>', default_opts)
map('n', '<S-A-t>', ':BufferLineMoveNext<CR>', default_opts)

-- hop
map('n', '<A-c>', '<cmd>HopChar2<CR>', default_opts)
map('n', '<A-d>', '<cmd>HopPattern<CR>', default_opts)
map('n', 's', '<cmd>HopChar1<CR>', default_opts)

----------------------------------------------------------------------------------------------------
-- R specific keybindings
----------------------------------------------------------------------------------------------------

-- send R code
map('v', '<Return>', '<Plug>RDSendSection', { noremap = false })
map('n', '<Return>', '<Plug>RDSendLine', { noremap = false })

map('v', '<A-o>', '<LocalLeader>ro', { noremap = false })
map('n', '<A-o>', '<LocalLeader>ro', { noremap = false })


-- vnoremap J :m '>+1<CR>gv=gv
-- vnoremap K :m '<-2<CR>gv=gv
--
-- nnoremap <leader><CR> :so %<CR>
--
-- " switch window orientation
-- nnoremap <A-w> :wincmd H<CR>
-- nnoremap <S-A-w> :wincmd J<CR>
--
--
-- "if has('nvim') || has('gui_running')
-- "    inoremap <C-Space> <C-x><C-o>
-- "else
-- "    inoremap <Nul> <C-x><C-o>
-- "endif
--
--
--
-- " output the current syntax group
-- " (temporary; for developing colorscheme)
-- nnoremap jj :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
-- \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
-- \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<cr>
--
-- " reload config
-- nnoremap ll :so%<CR>
--
-- " mark word as correct
-- nnoremap <A-g> zg
--
