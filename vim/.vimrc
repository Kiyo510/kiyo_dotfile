if &compatible
  set nocompatible
endif
" Add the dein installation directory into runtimepath
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')

  call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')
  call dein#add('Shougo/deoplete.nvim')
  if !has('nvim')
    call dein#add('roxma/nvim-yarp')
    call dein#add('roxma/vim-hug-neovim-rpc')
    call dein#add('vim-skk/skk.vim')
  endif

  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

inoremap <silent> jj <ESC>

"SKKの辞書ファイルの場所
let skk_large_jisyo = '~/SKK-JISYO.L'
"ユーザ辞書を自動で保存する（お好みで）
let skk_auto_save_jisyo = 1

"自動改行させないように
set textwidth=0
