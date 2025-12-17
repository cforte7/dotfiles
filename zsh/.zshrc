# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH=$HOME/.oh-my-zsh
source $ZSH/oh-my-zsh.sh
ZSH_THEME="powerlevel10k/powerlevel10k"
source $ZSH/custom/themes/powerlevel10k/powerlevel10k.zsh-theme
source $HOME/.p10k.zsh
export EDITOR="nvim"
plugins=(git zsh-npm-scripts-autocomplete zsh-autosuggestions zsh-syntax-highlighting)

# git aliases
alias pm="git pull --ff-only origin master 2> /dev/null || git pull --ff-only origin main"
alias cm="gco master -- 2> /dev/null || gco main --"
alias gs="git status"
alias gco="git checkout"
alias glo='git log --oneline --decorate'
alias gcm="git commit -m "
alias glom='glo master..'
alias glo1='glo -n1'
alias glo5='glo -n5'
alias glo10='glo -n10'
alias grbi='git rebase -i'
alias gdc='git diff --cached'
alias cival='circleci config validate'
alias gcob='git checkout -b '
alias gaa="git add ."
alias gp='git push origin "$(git rev-parse --abbrev-ref HEAD)"'
alias gd='git diff'
function gpb() {
  branch=$(pbpaste)
  read -qs "tmp?Create branch: $branch ? Y/n"
  if [[ $tmp =~ ^[Yy]$ ]]
  then
    echo ""
    git checkout -b "$branch"
  else
    echo ""
    echo "Exiting!"
  fi
}
# dev aliases
alias act='source .venv/bin/activate'

# meta aliases
alias get-aliases='cat ~/.zshrc | grep alias'
alias ezsh='code ~/.zshrc'
alias sz='. ~/.zshrc'

