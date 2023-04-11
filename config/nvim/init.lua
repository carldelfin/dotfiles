----------------------------------------------------------------------------------------------------
-- initial setup
----------------------------------------------------------------------------------------------------

-- aliases
local cmd = vim.cmd
local fn = vim.fn
local g = vim.g
local opt = vim.opt

-- keymapping function
local function map(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then
        if opts.desc then
            opts.desc = "keymaps.lua: " .. opts.desc
        end
        options = vim.tbl_extend('force', options, opts)
    end
    vim.keymap.set(mode, lhs, rhs, options)
end

-- comma as leader
g.mapleader = ","

-- space as local leader
g.maplocalleader = " "

----------------------------------------------------------------------------------------------------
-- plugins via lazy.nvim
----------------------------------------------------------------------------------------------------

-- let lazy.nvim handle itself
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

if not vim.loop.fs_stat(lazypath) then
    print('Installing lazy.nvim....')
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable',
        lazypath,
    })
    print('Done.')
end

opt.rtp:prepend(lazypath)

-- plugins start here
require('lazy').setup({
    {'jalvesaq/Nvim-R'},
    {'EdenEast/nightfox.nvim'},
    {'nvim-lualine/lualine.nvim'},
    {'junegunn/fzf'},
    {'junegunn/fzf.vim'},
    {'terrortylor/nvim-comment'},
    {'karb94/neoscroll.nvim'},
    {'phaazon/hop.nvim'},
    {'moll/vim-bbye'},
    {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
    {'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        dependencies = {
            {'neovim/nvim-lspconfig'},
            {'williamboman/mason.nvim',
                build = function()
                    pcall(vim.cmd, 'MasonUpdate')
                end,
            },
            {'williamboman/mason-lspconfig.nvim'},
            {'hrsh7th/nvim-cmp'},
            {'hrsh7th/cmp-nvim-lsp'},
            {'L3MON4D3/LuaSnip'},
        }
    }
})

----------------------------------------------------------------------------------------------------
-- plugin setups
----------------------------------------------------------------------------------------------------

require('neoscroll').setup({})
require('lualine').setup({})

require('nvim_comment').setup({
    comment_empty = false
})

require('nightfox').setup({
    options = {
        styles = {
            comments = "italic",
            keywords = "bold",
            types = "italic,bold",
        }
    }
})

require('hop').setup({
    keys = 'arstgmneioqwfpbjluy'
})

require("nvim-treesitter.configs").setup({
    ensure_installed = { "bash", "c", "lua", "vim", "r", "yaml", "css" },
    sync_install = false,
    auto_install = true,
    highlight = {
        enable = true,
    }
})

----------------------------------------------------------------------------------------------------
-- options 
----------------------------------------------------------------------------------------------------

cmd.colorscheme("nordfox")

-- specific colors for hop
cmd("hi HopNextKey guifg=#82fa8e")
cmd("hi HopNextKey1 guifg=#faea41")
cmd("hi HopNextKey2 guifg=#ff4d76")
cmd("hi HopUnmatched guifg=#576279")

opt.mouse = "a"                                         -- Enable mouse support
opt.clipboard = "unnamedplus"                           -- Copy/paste to system clipboard
opt.swapfile = false                                    -- Don't use swapfile
opt.completeopt = "menu,menuone,noinsert,noselect"      -- Autocomplete options
opt.showmatch = true                                    -- Highlight matching parenthesis
opt.foldmethod = "marker"                               -- Enable folding (default 'foldmarker')
opt.colorcolumn = "100"                                 -- Line lenght marker at 100 columns
opt.splitright = true                                   -- Vertical split to the right
opt.splitbelow = true                                   -- Horizontal split to the bottom
opt.ignorecase = true                                   -- Ignore case in search
opt.smartcase = true                                    -- Ignore lowercase for the whole pattern
opt.linebreak = true                                    -- Wrap on word boundary
opt.termguicolors = true                                -- Enable 24-bit RGB colors
opt.relativenumber = true                               -- Enable relative line numbers
opt.scrolloff = 4                                       -- Set 4 line scrolloff
opt.expandtab = true                                    -- Use spaces instead of tabs
opt.shiftwidth = 4                                      -- Shift 4 spaces when tab
opt.tabstop = 4                                         -- 1 tab == 4 spaces
opt.smartindent = true                                  -- Autoindent new lines
opt.hidden = true                                       -- Enable background buffers
opt.history = 100                                       -- Remember N lines in history
opt.lazyredraw = true                                   -- Faster scrolling
opt.synmaxcol = 240                                     -- Max column for syntax highlight
opt.updatetime = 250                                    -- ms to wait for trigger an event
opt.shortmess:append "sI"                               -- Diable intro

-- r specific settings 
g.rout_follow_colorscheme = 1
g.rout_more_colors = 1
g.R_assign = 2
g.R_enable_comment = 1
g.rrst_syn_hl_chunk = 1
g.rmd_syn_hl_chunk = 1
g.R_hi_fun_paren = 0
g.R_hi_fun_globenv = 0

----------------------------------------------------------------------------------------------------
-- Keybindings 
----------------------------------------------------------------------------------------------------

-- save and quit
map("n", "<C-s>", ":w<CR>")
map("n", "<C-q>", ":bd<CR>")

-- hop
map("n", "\\", ":HopPattern<CR>")
map("n", "s", ":HopChar1<CR>")

-- toggle nvim-tree
map("n", "<C-t>", ":NvimTreeToggle<CR>")

-- r
map("v", "<Return>", "<Plug>RDSendSection")
map("n", "<Return>", "<Plug>RDSendLine")
map("n", "<A-l>", "<Plug>RClearConsole")
map("n", "<A-o>", "<LocalLeader>ro")
map("v", "<A-o>", "<LocalLeader>ro")
map("n", "<LocalLeader>tt", ":call RAction('tail', ', n = 20')<CR>")
map("n", "<LocalLeader>hh", ":call RAction('head', ', n = 20')<CR>")
map("n", "<LocalLeader>ss", ":call RAction('str')<CR>")

-- window movement
map("n", "<A-m>",  "<C-w>h")
map("n", "<A-n>", "<C-w>j")
map("n", "<A-e>",  "<C-w>k")
map("n", "<A-i>", "<C-w>l")

-- window resize 
map("n", "<S-A-m>", ":vertical resize -2<CR>")
map("n", "<S-A-n>", ":resize +2<CR>")
map("n", "<S-A-e>", ":resize -2<CR>")
map("n", "<S-A-i>", ":vertical resize +2<CR>")

-- buffers 
map("n", "<A-s>", ":bprev<CR>")
map("n", "<A-t>", ":bnext<CR>")
map("n", "tt", ":Buffers<CR>")

-- fzf 
map("n", "<A-f>", "<cmd>FZF<CR>")
map("n", "<A-h>", "<cmd>FZF ~<CR>")

----------------------------------------------------------------------------------------------------
-- LSP via lsp-zero 
----------------------------------------------------------------------------------------------------

local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({buffer = bufnr})
end)

lsp.setup()

local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()

cmp.setup({
	sources = {
		{name = 'path'},
		{name = 'nvim_lsp'},
		{name = 'buffer', keyword_length = 3},
		{name = 'luasnip', keyword_length = 2},
	},
	preselect = 'item',
	mapping = {
		['<CR>'] = cmp.mapping.confirm({select = true}),
		['<Tab>'] = cmp_action.luasnip_supertab(),
		['<S-Tab>'] = cmp_action.luasnip_shift_supertab(),
  }
})

----------------------------------------------------------------------------------------------------
-- commands 
----------------------------------------------------------------------------------------------------

-- highlighted yank
cmd 'au TextYankPost * lua vim.highlight.on_yank {on_visual = false}'

-- quit r when exiting nvim
cmd([[ autocmd VimLeave * if exists("g:SendCmdToR") && string(g:SendCmdToR) != "function('SendCmdToR_fake')" | call RQuit("nosave") | endif ]])
