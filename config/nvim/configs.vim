" --------------------------------------------------------------------------------------------------
" Lua 
" --------------------------------------------------------------------------------------------------

lua << EOF

require('hop').setup{}
require('nvim_comment').setup{}
require('neoscroll').setup{}
require('nvim-tree').setup{}

require("indent_blankline").setup{
    char = "│",
    buftype_exclude = {"terminal"},
    space_char = ' ',
    show_first_indent_level = true,
    show_trailing_blankline_indent = false,
    char_highlight_list = {
        "IndentBlanklineIndent1",
        "IndentBlanklineIndent2",
        "IndentBlanklineIndent3",
        "IndentBlanklineIndent4",
        "IndentBlanklineIndent5",
        "IndentBlanklineIndent6"}}

require("bufferline").setup{
    options = {
        close_command = "Bdelete",
        separator_style = "thin",
        always_show_bufferline = true,
        offsets = {{
            filetype = "NvimTree",
            text = "File Explorer",
            highlight = "Directory",
            text_align = "left" }}}}

require'shade'.setup{
  overlay_opacity = 50,
  opacity_step = 1,
  keys = { toggle = '<A-v>' }}

require("nvim-treesitter.configs").setup {
  ensure_installed = { "r", "bash", "c", "bibtex", "css", "cpp", "dockerfile", "go",
                       "julia", "latex", "lua", "make", "markdown", "python", "regex",
                       "vim", "yaml", "toml", "rasi" },
  sync_install = false,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  }}

require('lspconfig').bashls.setup {}
require('lspconfig').pyright.setup {}
require('lspconfig').ltex.setup {}
require('lspconfig').r_language_server.setup {
  settings = {
    r = {
      lsp = {
        diagnostics = false,
      },
    },
  },
}

EOF

" --------------------------------------------------------------------------------------------------
" Vim 
" --------------------------------------------------------------------------------------------------

" mucomplete
let g:mucomplete#enable_auto_at_startup = 1
"let g:mucomplete#completion_delay = 50
"let g:mucomplete#reopen_immediately = 0
let g:mucomplete#chains = {
            \   'default': ['user', 'omni', 'keyn', 'c-n', 'path'],
            \   'vim': ['path', 'cmd', 'keyn'],
            \ }

" vimtex
let g:vimtex_view_method = 'zathura'

" vim-pandoc
let g:pandoc#modules#disabled = ["folding"]
let g:pandoc#syntax#conceal#use = 0

" pencil
let g:pencil#wrapModeDefault = 'soft'
augroup pencil
  autocmd!
  autocmd FileType text,rmarkdown,markdown,mkd call pencil#init()
augroup END

" hexokinase
let g:Hexokinase_highlighters = ['backgroundfull']

" ------------------------------------------------------------------------------------------------
" R specific settings
" ------------------------------------------------------------------------------------------------

let rrst_syn_hl_chunk = 1
let rmd_syn_hl_chunk = 1
let R_hi_fun = 1
let R_hi_fun_paren = 0
let R_hi_fun_globenv = 0

" don't expand a dataframe to show columns
let R_objbr_opendf = 0

" make sure R follows colorscheme
let g:rout_follow_colorscheme = 1
let g:Rout_more_colors = 1

" quit R automatically when closing nvim
autocmd VimLeave * if exists("g:SendCmdToR") && string(g:SendCmdToR) != "function('SendCmdToR_fake')" | call RQuit("nosave") | endif

" don't allow syntax folding
let r_syntax_folding = 0

" quietly open R
let R_args = ['--no-save', '--quiet']
let R_rconsole_width = 100

" R may open PDFs once, using zathura, then update that window
let R_openpdf = 1
let R_pdfviewer = "zathura"

" << turns into <-  
let R_assign = 1
let R_assign_map = '<<'

" >> turns into %>%
autocmd FileType r inoremap <buffer> >> <Esc>:normal! a %>%<CR>a 
autocmd FileType rnoweb inoremap <buffer> >> <Esc>:normal! a %>%<CR>a 
autocmd FileType rmd inoremap <buffer> >> <Esc>:normal! a %>%<CR>a 
