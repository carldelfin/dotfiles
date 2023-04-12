" leader keys
let mapleader = ","
let maplocalleader="\<space>"

" completion
" inoremap <C-Space> <C-x><C-o>

" sensible defaults
nnoremap Y y$
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z

inoremap , ,<C-g>u
inoremap . .<C-g>u
inoremap ! !<C-g>u
inoremap ? ?<C-g>u

vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" save and quit
nnoremap <C-s> :w<CR>
nnoremap <C-q> :Bdelete<CR>

" toggle netrw 
"nnoremap <C-t> :NvimTreeToggle<CR>
nnoremap <C-t> :Lexplore <CR>
"nnoremap <C-t> :Lexplore %:p:h<CR>

" start Voom
" nnoremap <C-v> :Voom<CR>

" switch window orientation
nnoremap <A-w> :wincmd H<CR>
nnoremap <S-A-w> :wincmd J<CR>

" fzf
nnoremap <A-f> <cmd>FZF<cr>
nnoremap <A-h> <cmd>FZF $HOME/<cr>

" window movement
nnoremap <A-m> <C-w>h " left
nnoremap <A-n> <C-w>j " down
nnoremap <A-e> <C-w>k " up
nnoremap <A-i> <C-w>l " right

" window resize 
nnoremap <S-A-m> :vertical resize -2<CR> " left
nnoremap <S-A-n> :resize +2<CR> " down
nnoremap <S-A-e> :resize -2<CR> " up
nnoremap <S-A-i> :vertical resize +2<CR> " right

" hop 
"nnoremap <A-c> <cmd>HopChar2<cr>
nnoremap <\\> <cmd>HopPattern<cr>
nnoremap s <cmd>HopChar1<cr>
omap s <cmd>HopChar1<cr>

" buffer control 
nnoremap <silent> tt :Buffers<CR>

" output the current syntax group 
nnoremap jj :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<cr>

" reload config
nnoremap ll :so%<CR>

" mark word as correct
" nnoremap <A-g> zg

" send R code
vmap <Return> <Plug>RDSendSection
nmap <Return> <Plug>RDSendLine

" clear R console
nmap <A-l> <Plug>RClearConsole

" Nvim-R object browser
vmap <A-o> <LocalLeader>ro
nmap <A-o> <LocalLeader>ro



