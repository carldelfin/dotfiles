-----------------------------------------------------------
-- Neovim settings
-----------------------------------------------------------

-----------------------------------------------------------
-- Neovim API aliases
-----------------------------------------------------------
--local map = vim.api.nvim_set_keymap  -- set global keymap
local cmd = vim.cmd     				-- execute Vim commands
local exec = vim.api.nvim_exec 	-- execute Vimscript
local fn = vim.fn       				-- call Vim functions
local g = vim.g         				-- global variables
local opt = vim.opt         		-- global/buffer/windows-scoped options

-----------------------------------------------------------
-- General
-----------------------------------------------------------
opt.mouse = 'a'               -- enable mouse support
opt.clipboard = 'unnamedplus' -- copy/paste to system clipboard
opt.swapfile = false          -- don't use swapfile

-----------------------------------------------------------
-- Neovim UI
-----------------------------------------------------------
opt.relativenumber = true
opt.showmatch = true
opt.foldmethod = 'marker'
opt.colorcolumn = '100'
opt.cursorline = true
opt.splitright = true
opt.splitbelow = true
opt.ignorecase = true
opt.smartcase = true
opt.linebreak = true
opt.incsearch = true
opt.backup = false
opt.swapfile = false
opt.scrolloff = 8
opt.showmatch = true
opt.lazyredraw = true
opt.splitbelow = true
opt.splitright = true

-- spelling and language
opt.spelllang = { 'en_us', 'sv' }

--set nofoldenable
--set splitright

--------------------------

-- pencil
vim.g.pencil = { wrapModeDefault = 'soft' }

-- hexokinase should highlight background
vim.g.Hexokinase_highlighters = { 'backgroundfull' }

cmd[[
  augroup pencil
  autocmd!
  autocmd FileType text,rmarkdown,markdown,mkd call pencil#init()
  augroup END
]]

-- use zathura to view tex output
vim.g.vimtex_view_method = 'zathura'

-- no folding on startup with vim-pandoc
vim.g['pandoc#modules#disabled'] = { "folding" }
vim.g['pandoc#syntax#conceal#use'] = 0

-- remove whitespace on save
cmd [[au BufWritePre * :%s/\s\+$//e]]

-- highlight on yank
exec([[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=700}
  augroup end
]], false)

-----------------------------------------------------------
-- Memory, CPU
-----------------------------------------------------------
opt.hidden = true         -- enable background buffers
opt.history = 100         -- remember n lines in history
opt.lazyredraw = true     -- faster scrolling
opt.synmaxcol = 240       -- max column for syntax highlight

-----------------------------------------------------------
-- Colorscheme
-----------------------------------------------------------
opt.termguicolors = true      -- enable 24-bit RGB colors
--cmd [[colorscheme onedark]]
--cmd [[source ~/dotfiles/config/nvim_/colors/oner.vim]]

-----------------------------------------------------------
-- Tabs, indent
-----------------------------------------------------------
opt.expandtab = true      -- use spaces instead of tabs
opt.shiftwidth = 4        -- shift 4 spaces when tab
opt.tabstop = 4           -- 1 tab == 4 spaces
opt.smartindent = true    -- autoindent new lines

-- don't auto commenting new lines
cmd [[au BufEnter * set fo-=c fo-=r fo-=o]]

-- remove line lenght marker for selected filetypes
cmd [[autocmd FileType text,markdown,html,xhtml,javascript setlocal cc=0]]

-- 2 spaces for selected filetypes
cmd [[
  autocmd FileType xml,html,xhtml,css,scss,javascript,lua,yaml setlocal shiftwidth=2 tabstop=2
]]

-----------------------------------------------------------
-- Autocompletion
-----------------------------------------------------------

opt.completeopt="menuone,noinsert,noselect"
opt.shortmess = vim.o.shortmess .. "c"
opt.updatetime=300
opt.timeoutlen=500
vim.g['mucomplete#enable_auto_at_startup'] = 1
vim.g.completion_chain_complete_list = {
            default = {
              default = {
                  { complete_items = { 'lsp', 'snippet' }},
                  { mode = '<c-p>'},
                  { mode = '<c-n>'}},
              comment = {},
              string = { { complete_items = { 'path' }} }}}


--
-- R
--

vim.g.rrst_syn_hl_chunk = 1
vim.g.rmd_syn_hl_chunk = 1
vim.g.R_hi_fun = 1
vim.g.R_hi_fun_paren = 0
vim.g.R_hi_fun_globenv = 0

-- don't expand a dataframe to show columns
vim.g.R_objbr_opendf = 0

-- make sure R follows colorscheme
vim.g.rout_follow_colorscheme = 1
vim.g.Rout_more_colors = 1

-- quit R automatically when closing nvim
cmd [[
  autocmd VimLeave * if exists("g:SendCmdToR") && string(g:SendCmdToR) != "function('SendCmdToR_fake')" | call RQuit("nosave") | endif
]]

-- " don't allow syntax folding
-- let r_syntax_folding = 0
--
-- quietly open R
vim.g.R_args = { '--no-save', '--quiet' }
vim.g.R_rconsole_width = 100
--
-- R may open PDFs once, using zathura, then update that window
vim.g.R_openpdf = 1
vim.g.R_pdfviewer = "zathura"
--
-- << turns into <-
vim.g.R_assign = 1
vim.g.R_assign_map = '<<'

-- >> turns into %>%
cmd [[
  autocmd FileType r inoremap <buffer> >> <Esc>:normal! a %>%<CR>a
  autocmd FileType rnoweb inoremap <buffer> >> <Esc>:normal! a %>%<CR>a
  autocmd FileType rmd inoremap <buffer> >> <Esc>:normal! a %>%<CR>a
]]

-----------------------------------------------------------
-- Terminal
-----------------------------------------------------------
-- open a terminal pane on the right using :Term
cmd [[command Term :botright vsplit term://$SHELL]]

-- Terminal visual tweaks
--- enter insert mode when switching to terminal
--- close terminal buffer on process exit
cmd [[
    autocmd TermOpen * setlocal listchars= nonumber norelativenumber nocursorline
    autocmd TermOpen * startinsert
    autocmd BufLeave term://* stopinsert
]]

-----------------------------------------------------------
-- Startup
-----------------------------------------------------------
-- disable builtins plugins
local disabled_built_ins = {
    "netrw",
    "netrwPlugin",
    "netrwSettings",
    "netrwFileHandlers",
    "gzip",
    "zip",
    "zipPlugin",
    "tar",
    "tarPlugin",
    "getscript",
    "getscriptPlugin",
    "vimball",
    "vimballPlugin",
    "2html_plugin",
    "logipat",
    "rrhelper",
    "spellfile_plugin",
    "matchit"
}

for _, plugin in pairs(disabled_built_ins) do
    g["loaded_" .. plugin] = 1
end

-- disable nvim intro
opt.shortmess:append "sI"
