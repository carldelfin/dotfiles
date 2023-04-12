let g:nvim_config_root = stdpath('config')
let g:config_file_list = ['plugins.vim', 'statusline.vim', 'settings.vim', 'configs.vim', 'configs.lua', 'keybindings.vim']

for f in g:config_file_list
    execute 'source ' . g:nvim_config_root . '/' . f
endfor

syntax on

if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

"source ~/dotfiles/config/nvim/colors/oner.vim
"set background=dark
colorscheme nightfox
