export EDITOR="/usr/local/bin/vim"
export C_INCLUDE_PATH="/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.8.sdk/usr/include/" 
# tmux
alias tmux="TERM=screen-256color-bce tmux"

#
# git bash completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi
## homebrew completion
#source `brew --repository`/Library/Contributions/brew_bash_completion.sh
if [ -f /Applications/Xcode.app/Contents/Developer/usr/share/git-core/git-completion.bash ]; then
  . /Applications/Xcode.app/Contents/Developer/usr/share/git-core/git-completion.bash
fi

source /Applications/Xcode.app/Contents/Developer/usr/share/git-core/git-prompt.sh

#enables color in the terminal bash shell export
CLICOLOR=1
#sets up the color scheme for list export
export LSCOLORS=gxfxcxdxbxegedabagacad
#sets up the prompt color (currently a green similar to linux terminal)
export PS1='\[\033[01;32m\]\u\[\033[01;36m\]\w\[\033[00m\]$(__git_ps1)\$'
##enables color for iTerm
export TERM=xterm-color
#sets up proper alias commands when called
alias ls='ls -G'
alias ll='ls -hl'

# ssh to ec2 instance:
alias ec2='ssh -l spinlock 54.68.136.14'

# alias grep to ignore vim swp files
alias grep='grep --exclude=*.swp'

# tex
export PATH="/usr/texbin":$PATH

# my custom scripts and stuff
export PATH="~/bin":$PATH

# Vdebug setup
export RUBYDB_LIB=/Users/spinlock/lib/dbgp
export RUBYDB_OPTS="HOST=localhost PORT=9000"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

export NVM_DIR="/Users/spinlock/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
