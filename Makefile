SHELL := bash
.SHELLFLAGS := -eu -o pipefail -c
.ONESHELL := true
.DELETE_ON_ERROR := true
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules

ifeq ($(origin .RECIPEPREFIX), undefined)
>$(error This Make does not support .RECIPEPREFIX. Please use GNU Make 4.0 or later (i.e. gmake not make))
endif
.RECIPEPREFIX = >

PACKAGES=bash vim screen hammerspoon git
.PHONY: $(PACKAGES)

all: $(PACKAGES)

list:
>@echo $(PACKAGES)

check:
>@type brew >/dev/null 2>&1 || $(MAKE) homebrew
>@type stow >/dev/null 2>&1 || brew install stow

homebrew-installer:
>/usr/bin/curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install -o homebrew-installer

homebrew: homebrew-installer
>/usr/bin/ruby homebrew-installer

git-prompt:
>brew install bash-git-prompt

nvm:
>if [ ! -d ~/.nvm ]; then mkdir ~/.nvm; fi
>curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.6/install.sh | bash

yarn:
>brew install yarn

bash: bash/.bash_profile bash/.git-completion.bash
>stow -t ~ bash

vim: vim/.vimrc
>stow -t ~ vim
>mkdir -p ~/.vim/bundle
>git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
>vim +PluginInstall +qall

vim-clean:
>stow -D vim
>rm -rf ~/.vim

zsh: zsh/.zshrc
># Oh My Zsh for good default shell setup
>#sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
>curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh

># Additional shell setup
>cp aliases.zsh ~/.oh-my-zsh/custom

># Required for rbenv to work properly
>cp rbenv.zsh ~/.oh-my-zsh/custom
>stow zsh

screen: screen/.screenrc screen/.screen/fast screen/.screen/slow
>stow -t ~ screen

hammerspoon: hammerspoon/.hammerspoon/init.lua
>stow -t ~ hammerspoon

git: git/.gitconfig git/.gitignore_global
>stow -t ~ git

git-hooks: git-hooks/.git/hooks/prepare-commit-msg git-hooks/.git/hooks/pre-push
>git config --global init.templatedir '~/dotfiles/git-hooks'
>cd ~/src/handshake
>git init

clean:
>for package in $(PACKAGES) ; do \
>	stow -D $$package ; \
>done
>rm -rf ~/.vim
