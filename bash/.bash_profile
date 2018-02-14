source "$HOME/.profile"
export EDITOR="/usr/local/bin/vim"
#enables color in the terminal bash shell export
CLICOLOR=1
#sets up the color scheme for list export
export LSCOLORS=gxfxcxdxbxegedabagacad
##enables color for iTerm
export TERM=screen-256color
#sets up proper alias commands when called
alias ls='ls -G'
alias ll='ls -hl'

# alias grep to ignore vim swp files
alias grep='grep --exclude=*.swp'

# brew install bash-git-prompt
if [ -f "/usr/local/opt/bash-git-prompt/share/gitprompt.sh" ]; then
  __GIT_PROMPT_DIR="/usr/local/opt/bash-git-prompt/share"
  source "/usr/local/opt/bash-git-prompt/share/gitprompt.sh"
fi

source ~/.git-completion.bash

export NVM_DIR="$HOME/.nvm"
. "/usr/local/opt/nvm/nvm.sh"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
