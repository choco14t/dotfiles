export LANG=en_US.UTF-8

export FZF_DEFAULT_OPTS='--no-height --reverse --border'
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"

declare -A ZINIT
ZINIT[BIN_DIR]="$HOME/zinit/bin"
ZINIT[HOME_DIR]="$HOME/zinit"
ZINIT[ZCOMPDUMP_PATH]="$HOME/.zcompdump"

ZSH_DIR="$HOME/.zsh"

HISTFILE=$HOME/.zsh-history
HISTSIZE=10000
SAVEHIST=50000

# directory
setopt auto_cd

# suggestion
setopt list_packed

# hist
setopt inc_append_history
setopt share_history
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_no_store
setopt hist_reduce_blanks
setopt ignore_eof

# I/O
unsetopt flow_control
