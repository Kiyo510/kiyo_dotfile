ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

SCRIPT_DIR=$HOME/dotfiles
export ZDOTDIR=$HOME/dotfiles

source "$SCRIPT_DIR"/zsh/plugins.zsh
source "$SCRIPT_DIR"/zsh/config.zsh
fpath+=${ZDOTDIR:-~}/.zsh_functions
export PATH="/opt/homebrew/opt/avr-gcc@8/bin:$PATH"
