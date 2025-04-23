set editing-mode vi

PATH=$HOME/.local/bin:$PATH # Gigalixir tools
PATH=$HOME/bin:$PATH # dotfiles tools
export PATH=./bin:$PATH
export EDITOR="/usr/local/bin/vim"
#enables color in the terminal bash shell export
CLICOLOR=1
#sets up the color scheme for list export
export LSCOLORS=gxfxcxdxbxegedabagacad
##enables color for iTerm
export TERM=screen-256color
#sets up proper alias commands when called
alias ls='ls -G --color=auto'
alias ll='ls -hl'

# alias grep to ignore vim swp files
alias grep='grep --exclude=*.swp'

## brew configure bash shell completions
#if type brew 2&>/dev/null; then
#  for completion_file in $(brew --prefix)/etc/bash_completion.d/*; do
#    source "$completion_file"
#  done
#fi
#
## homebrew bash completions
#HOMEBREW_PREFIX=$(brew --prefix)
#if type brew &>/dev/null; then
#  if [[ -r "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" ]]; then
#    source "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
#  else
#    for COMPLETION in "${HOMEBREW_PREFIX}/etc/bash_completion.d/"*; do
#      [[ -r "$COMPLETION" ]] && source "$COMPLETION"
#    done
#  fi
#fi
#
## brew install bash-git-prompt
#if [ -f "/usr/local/opt/bash-git-prompt/share/gitprompt.sh" ]; then
#  __GIT_PROMPT_DIR="/usr/local/opt/bash-git-prompt/share"
#  source "/usr/local/opt/bash-git-prompt/share/gitprompt.sh"
#fi
#
#source ~/.git-completion.bash

#export NVM_DIR="$HOME/.nvm"
#. "$NVM_DIR/nvm.sh"

#[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
#eval "$(rbenv init -)"

#
# ASDF
#
. "$HOME/.asdf/asdf.sh"
. "$HOME/.asdf/completions/asdf.bash"
