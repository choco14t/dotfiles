[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

eval "$(anyenv init -)"
source ~/.zplug/init.zsh

zplug 'zplug/zplug', hook-build:'zplug --self-manage'
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-completions", lazy:true
zplug "zsh-users/zsh-autosuggestions"
zplug "junegunn/fzf", as:command, use:bin/fzf-tmux, if:'[ -x $(which tmux) ]'
zplug "junegunn/fzf-bin", as:command, from:gh-r, rename-to:fzf
zplug "kyoshidajp/ghkw", as:command, from:gh-r, lazy:true

if ! zplug check; then zplug install; fi
zplug load

autoload -U compinit; compinit -C

alias l="ls -lhAGF"
alias rm="rm -ri"

alias nv="nvim"

alias brname="git symbolic-ref --short HEAD"
alias chbrname="git branch -m"
alias sts="git status -s"
alias cho="git checkout"
alias chkob="git checkout -b"
alias pso="git push origin HEAD"
alias po="git pull origin"
alias fe="git fetch"
alias fep="git fetch --prune"
alias fea="git fetch --all"
alias lg="git log --graph"
alias sths="git stash save"
alias sthp="git stash pop"
alias sthl="git stash list"
alias cmt="git commit"
alias cln="git clone"
alias brvv="git branch -vv"
alias psuoh="git push -u origin HEAD"

eval "$(starship init zsh)"

fbr() {
    local branches branch
    branches=$(git branch | grep -v \*) &&
    branch=$(echo "$branches" | fzf +m) &&
    git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
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
  branches=$(git branch | awk '{if (substr($0,1,1) !~ /\*/) print $1}') &&
  branch=$(echo "$branches" | fzf --multi --exit-0) &&
  git branch -D $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}

