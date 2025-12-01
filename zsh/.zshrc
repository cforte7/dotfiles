# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source $ZSH/oh-my-zsh.sh
export ZSH="/Users/chrisforte/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
source ~/powerlevel10k/powerlevel10k.zsh-theme

export EDITOR="nvim"
source /usr/local/share/zsh/site-functions/cw.zsh

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
echo "source ${(q-)PWD}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ${ZDOTDIR:-$HOME}/.zshrc

plugins=(git zsh-syntax-highlighting zsh-npm-scripts-autocomplete)

# Command line shortcuts
alias act='source .venv/bin/activate'
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
alias ezsh='code ~/.zshrc'
alias sz='. ~/.zshrc'
alias get-aliases='cat ~/.zshrc | grep alias'
alias gdc='git diff --cached'
alias cival='circleci config validate'
alias gcob='git checkout -b '
unalias gp
alias gp='git push origin "$(git rev-parse --abbrev-ref HEAD)"'
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
