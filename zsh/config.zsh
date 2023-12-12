export DEFAULT_USER=$(whoami)

# End the prompt, closing any open segments
prompt_end() {
    if [[ -n $CURRENT_BG ]]; then
        print -n "%{%k%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR"
    else
        print -n "%{%k%}"
    fi
    print -n "\n→%{%f%}"
    CURRENT_BG=''
}

# Z
. ~/z/z.sh

# python
export PATH="$HOME/.pyenv/shims:$PATH"
# export PYENV_ROOT="$HOME/.pyenv"
# export PATH="$PYENV_ROOT/bin:$PATH"
# eval "$(pyenv init -)"

# ruby
export PATH="$HOME/.rbenv/bin:$PATH"
if which rbenv >/dev/null; then eval "$(rbenv init -)"; fi

# docker
alias dc='docker compose'
alias docker-purge='docker stop $(docker ps -q) && docker rmi $(docker images -q) -f'
alias dumpmonita='docker exec -it scrp_tabelog_monita_db_1 mysqldump -u root  monita_development'
alias drm='docker system prune'
export DOCKER_CONTENT_TRUST=0

# git
alias gs='git status'
alias gb='git branch'
alias gcob='git checkout -b'
alias -g B='`git branch -a | peco --prompt "GIT BRANCH>" | head -n 1 | sed -e "s/^\*\s*//g"`'
alias -g H='`curl -sL https://api.github.com/users/Kiyo510/repos | jq -r ".[].full_name" | peco --prompt "GITHUB REPOS>" | head -n 1`'
alias gbdgr='(){git branch | grep $1 | xargs git branch -d}'
alias gad='git rm $(git ls-files --deleted)'
# terminalでは動くのに何故かaliasでは動かないがとりあえずメモ程度に書いておく 
alias ghprco='gh pr list | peco | awk "{print $1}" | xargs gh pr checkout'

# heroku
alias hegitremote='(){heroku git:remote --app $1}'
alias hessh='heroku run bash'

# dateをGUN Linux仕様にしたので、エイリアスを貼る
# ref https://tatsuno-system.co.jp/2016/06/27/mac%E3%81%A7date%E3%82%B3%E3%83%9E%E3%83%B3%E3%83%89%E3%81%8C%E9%81%95%E3%81%86%E4%BB%B6%E3%81%AB%E3%81%A4%E3%81%84%E3%81%A6/
alias date=/opt/homebrew/bin/gdate
alias ls='ls -G'

#Linuxコマンド
if type trash-put &> /dev/null
then
    alias rm='trash-put'
    alias sudo='sudo '
fi

# zsh
function jump_middle() {
    CURSOR=$((${#BUFFER} / 2))
    zle redisplay
}
zle -N jump_middle
bindkey "^j" jump_middle

# 失敗したコマンドは履歴に保存しない
autoload -Uz add-zsh-hook

remove_last_history_if_not_needed () {
  local last_status="$?"
  local HISTFILE=~/.zsh_history
  if [[ ${last_status} -ne 0 ]]; then
    fc -W
    ed -s ${HISTFILE} <<EOF >/dev/null
d
w
q
EOF
    fc -R
  fi
}
add-zsh-hook precmd remove_last_history_if_not_needed

# 履歴ファイルの保存先
HISTFILE=~/.zsh_history

# メモリに保存される履歴の件数
export HISTSIZE=50000

# 履歴ファイルに保存される履歴の件数
export SAVEHIST=500000000

# 重複を除外して履歴を保持
setopt HIST_IGNORE_ALL_DUPS 
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_BEEP

# 開始と終了を記録
setopt EXTENDED_HISTORY

# 余分な空白は詰めて記録
setopt HIST_REDUCE_BLANKS

## 他のzshと履歴を共有
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY

## パスを直接入力してもcdする
setopt AUTO_CD

## 環境変数を補完
setopt AUTO_PARAM_KEYS

# manual
function mm() {
    if [[ $1 ]]; then
        printf "\033[36m%-20s\033[0m %-20s %-30s\n" "[main:sub]" "[Command]" "[Description]"
        cat $HOME/.manurc | grep $1 | awk -F " *?## *?" '{printf "\033[36m%-20s\033[0m %-20s %-30s\n", $1, $2, $3}'
    else
        echo "mm iterm[:line, :window, ...]"
        echo "mm alias[:docker, :git...]"
        echo "mm vscode[:terminal, ...]"
    fi
}

# ##### 補完関連 #######
zinit ice wait'0'
zinit light zsh-users/zsh-completions
autoload -Uz compinit && compinit
## 補完で小文字でも大文字にマッチさせる
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
## 補完候補を一覧表示したとき、Tabや矢印で選択できるようにする
zstyle ':completion:*:default' menu select=1
# 補完候補に色つける
autoload -U colors
# colors
zstyle ':completion:*' list-colors "${LS_COLORS}"
# 単語の入力途中でもTab補完を有効化
setopt complete_in_word
# 補完候補をハイライト
zstyle ':completion:*:default' menu select=1
# キャッシュの利用による補完の高速化
zstyle ':completion::complete:*' use-cache true
# 補完リストの表示間隔を狭くする
setopt list_packed
# github-cliの補完
eval "$(gh completion -s zsh)"
# ##### 補完関連 #######

# direnv
export EDITOR=code
eval "$(direnv hook zsh)"

# GitHub CLI
export GIT_EDITOR=vim

# node
export PATH=$HOME/.nodebrew/current/bin:$PATH

# mattermost
ulimit -n 8096

# rust
export PATH=$HOME/.cargo/bin:$PATH

# gRPC
export PATH=$PATH:$(go env GOPATH)/bin
