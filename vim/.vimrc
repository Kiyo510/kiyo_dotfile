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

inoremap <silent> jj <ESC>

"SKKの辞書ファイルの場所
let skk_large_jisyo = '~/SKK-JISYO.L'
"ユーザ辞書を自動で保存する（お好みで）
let skk_auto_save_jisyo = 1

"自動改行させないように
autocmd FileType gitcommit :set formatoptions=q

autocmd FileType gitcommit setlocal spell
