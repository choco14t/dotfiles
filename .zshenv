export LANG=en_US.UTF-8
export FZF_DEFAULT_OPTS='--height 40% --reverse --border'

export PATH="$HOME/.anyenv/bin:$PATH"

declare -A ZPLGM
ZPLGM[BIN_DIR]="$HOME/zplugin/bin"
ZPLGM[HOME_DIR]="$HOME/zplugin"
ZPLGM[ZCOMPDUMP_PATH]="$HOME/.zcompdump"

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
