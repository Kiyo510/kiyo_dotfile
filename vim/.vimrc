let $CACHE = expand('~/.cache')
if !($CACHE->isdirectory())
  call mkdir($CACHE, 'p')
endif
if &runtimepath !~# '/dein.vim'
  let s:dir = 'dein.vim'->fnamemodify(':p')
  if !(s:dir->isdirectory())
    let s:dir = $CACHE .. '/dein/repos/github.com/Shougo/dein.vim'
    if !(s:dir->isdirectory())
      execute '!git clone https://github.com/Shougo/dein.vim' s:dir
    endif
  endif
  execute 'set runtimepath^='
        \ .. s:dir->fnamemodify(':p')->substitute('[/\\]$', '', '')
endif

if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')
  call dein#add('tyru/eskk.vim')
  call dein#end()
endif

inoremap <silent> jj <ESC>

"SKKの辞書ファイルの場所
let g:eskk#directory = "~/.cache/dein/repos/github.com/tyru/eskk.vim"
let g:eskk#large_dictionary = {'path': "~/SKK-JISYO.L", 'sorted': 1, 'encoding': 'euc-jp',}

"自動改行させないように
autocmd FileType gitcommit :set formatoptions=q

autocmd FileType gitcommit setlocal spell

set clipboard+=unnamed
