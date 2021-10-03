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
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# ruby
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init - zsh)"

# docker
alias dc='docker-compose'
alias docker-purge='docker stop $(docker ps -q) && docker rmi $(docker images -q) -f'
alias dumpmonita='docker exec -it scrp_tabelog_monita_db_1 mysqldump -u root  monita_development'
alias drm='docker system prune'
export DOCKER_CONTENT_TRUST=1

# git
alias gs='git status'
alias gb='git branch'
alias gcob='git checkout -b'

# zsh
function jump_middle() {
    CURSOR=$((${#BUFFER} / 2))
    zle redisplay
}
zle -N jump_middle
bindkey "^j" jump_middle

# manual
function mm() {
    if [[ $1 ]]; then
        printf "\033[36m%-20s\033[0m %-20s %-30s\n" "[main:sub]" "[Command]" "[Description]"
        cat $HOME/.manurc | grep $1 | awk -F " *?## *?" '{printf "\033[36m%-20s\033[0m %-20s %-30s\n", $1, $2, $3}'
    else
        echo "mm iterm[:line, :window, ...]"
        echo "mm alias[:docker, ...]"
        echo "mm vscode[:terminal, ...]"
    fi
}
