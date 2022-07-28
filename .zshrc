[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

if [[ ! -d "$ZINIT[BIN_DIR]" ]]; then
  git clone https://github.com/zdharma-continuum/zinit "$ZINIT[BIN_DIR]"
fi
source "$ZINIT[BIN_DIR]/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

zinit light "zsh-users/zsh-autosuggestions"
zinit light "zsh-users/zsh-completions"
zinit light "zsh-users/zsh-syntax-highlighting"

zinit ice lucid wait \
  multisrc"shell/{completion,key-bindings}.zsh" \
  pick"/dev/null"
zinit light junegunn/fzf

autoload -U compinit; compinit -d "$ZINIT[ZCOMPDUMP_PATH]"

if [ "$(uname)" = 'Darwin' ] && [ -e $(brew --prefix asdf)/libexec/asdf.sh ]; then
  . $(brew --prefix asdf)/libexec/asdf.sh
fi

if [ "$(uname)" = 'Linux' ] && [ -e $HOME/.asdf/asdf.sh ]; then
  . $HOME/.asdf/asdf.sh
fi

if [ -d $ZSH_DIR ] && [ -r $ZSH_DIR ] && [ -x $ZSH_DIR ]; then
  for i in $ZSH_DIR/*; do
    [[ ${i##*/} = *.zsh ]] && [ \( -f $i -o -h $i \) -a -r $i ] && . $i
  done
fi

alias ls="exa"
alias ll="ls -lhF"
alias rm="rm -ri"

alias nv="nvim"

alias sts="git status -s"
alias cho="git checkout"
alias crb="git checkout -b"
alias pso="git push origin HEAD"
alias psu="git push -u origin HEAD"
alias po="git pull origin"
alias fe="git fetch"
alias fea="git fetch --all"
alias lg="git log --graph"
alias sths="git stash save"
alias sthp="git stash pop"
alias sthl="git stash list"
alias cmt="git commit"
alias cln="git clone"

alias dc="docker compose"

eval "$(starship init zsh)"

fbr() {
    local branches branch
    branches=$(git branch | grep -v \*) &&
    branch=$(echo "$branches" | fzf +m) &&
    git checkout $(echo "$branch" | awk '{print $1}')
}

fbrt() {
    local branches branch
    branches=$(git branch -vv) &&
    branch=$(echo "$branches" | fzf +m) &&
    git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}

fadd() {
  local out q n addfiles
  while out=$(
      git status --short |
      awk '{if (substr($0,2,1) !~ / /) print $2}' |
      fzf --multi --exit-0 --expect=ctrl-d); do
    q=$(head -1 <<< "$out")
    n=$[$(wc -l <<< "$out") - 1]
    addfiles=(`echo $(tail "-$n" <<< "$out")`)
    [[ -z "$addfiles" ]] && continue
    if [ "$q" = ctrl-d ]; then
      git diff --color=always $addfiles | less -R
    else
      git add $addfiles
    fi
  done
}

fres() {
  local out q n resetfiles
  while out=$(
      git status --short |
      awk '{if (substr($0,1,1) !~ / /) print $2}' |
      fzf --multi --exit-0 --expect=ctrl-d); do
    q=$(head -1 <<< "$out")
    n=$[$(wc -l <<< "$out") - 1]
    resetfiles=(`echo $(tail "-$n" <<< "$out")`)
    [[ -z "$resetfiles" ]] && continue
    if [ "$q" = ctrl-d ]; then
      git diff --color=always $resetfiles | less -R
    else
      git reset HEAD $resetfiles
    fi
  done
}

f7() {
  local out q n discardfiles
  while out=$(
      git status --short |
      awk '{if (substr($0,2,1) !~ /[ ?]/) print $2}' |
      fzf --multi --exit-0 --expect=ctrl-d); do
    q=$(head -1 <<< "$out")
    n=$[$(wc -l <<< "$out") - 1]
    resetfiles=(`echo $(tail "-$n" <<< "$out")`)
    [[ -z "$resetfiles" ]] && continue
    if [ "$q" = ctrl-d ]; then
      git diff --color=always $resetfiles | less -R
    else
      git checkout HEAD -- $resetfiles
    fi
  done
}

fdel() {
  local branches branch
  branches=$(git branch | grep -v \*) &&
  branch=$(echo "$branches" | fzf --multi --exit-0) &&
  git branch -D $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}
