set editing-mode vi

export EDITOR="/usr/local/bin/vim"
export ASDF_DATA_DIR="/home/spinlock/.asdf"
export PATH="$ASDF_DATA_DIR/asdf:$ASDF_DATA_DIR/shims:$HOME/bin:$HOME/.local/bin:./bin:$PATH"

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
