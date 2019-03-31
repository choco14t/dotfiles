export LANG=en_US.UTF-8
export FZF_DEFAULT_OPTS='--height 40% --reverse --border'
export PATH="$HOME/.anyenv/bin:$PATH"
eval "$(anyenv init -)"

PURE_CMD_MAX_EXEC_TIME=2629746

HISTFILE=$HOME/.zsh-history
HISTSIZE=10000
SAVEHIST=50000

setopt inc_append_history
setopt share_history
setopt auto_cd

