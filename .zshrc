export ZSH="/Users/chrisforte/.oh-my-zsh"

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"
plugins=(git)

source $ZSH/oh-my-zsh.sh

source /usr/local/share/zsh/site-functions/cw.zsh
export PATH="/Applications/Postgres.app/Contents/Versions/latest/bin:$PATH"
source ~/.amperrc

# Command line shortcuts
alias act='source .venv/bin/activate'
alias aws='aws2'
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
alias mig='psql -U postgres -h localhost -p 5432 'factory_dev' -a -f '
alias invser='-s local invoke local -f '
alias local_pgcli='pgcli -h localhost -p 5432 -d factory_dev'
alias test-schema='inv schema-dump-local ~/Support/sheik'
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

export NVM_DIR="$HOME/.nvm"
  [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
eval "$(pyenv init -)"

pyenvVirtualenvUpdatePrompt() {
    RED='\[\e[0;31m\]'
    GREEN='\[\e[0;32m\]'
    BLUE='\[\e[0;34m\]'
    RESET='\[\e[0m\]'
    [ -z "$PYENV_VIRTUALENV_ORIGINAL_PS1" ] && export PYENV_VIRTUALENV_ORIGINAL_PS1="$PS1"
    [ -z "$PYENV_VIRTUALENV_GLOBAL_NAME" ] && export PYENV_VIRTUALENV_GLOBAL_NAME="$(pyenv global)"
    VENV_NAME="$(pyenv version-name)"
    VENV_NAME="${VENV_NAME##*/}"
    GLOBAL_NAME="$PYENV_VIRTUALENV_GLOBAL_NAME"

    # non-global versions:
    COLOR="$BLUE"
    # global version:
    [ "$VENV_NAME" == "$GLOBAL_NAME" ] && COLOR="$RED"
    # virtual envs:
    [ "${VIRTUAL_ENV##*/}" == "$VENV_NAME" ] && COLOR="$GREEN"

    if [ -z "$COLOR" ]; then
        PS1="$PYENV_VIRTUALENV_ORIGINAL_PS1"
    else
        PS1="($COLOR${VENV_NAME}$RESET)$PYENV_VIRTUALENV_ORIGINAL_PS1"
    fi
    export PS1
}

export PROMPT_COMMAND="$PROMPT_COMMAND pyenvVirtualenvUpdatePrompt;"
