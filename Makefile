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

PACKAGES=bash vim screen git keyd
.PHONY: $(PACKAGES)

ASDF=~/.asdf
VUNDLE=~/.vim/bundle

all: $(PACKAGES)

list:
>@echo $(PACKAGES)

check:
>@type stow >/dev/null 2>&1 || sudo apt install stow

bash: bash/.bashrc bash/.bash_profile bash/.git-completion.bash
>stow -t ~ bash

git: git/.gitconfig git/.gitignore_global
>stow -t ~ git

vim: vim/.vimrc
>stow -t ~ vim
ifeq (,$(wildcard $(VUNDLE)))
>mkdir -p $(VUNDLE)
>git clone https://github.com/VundleVim/Vundle.vim.git $(VUNDLE)/Vundle.vim
endif
>vim +PluginInstall +qall

vim-clean:
>stow -D vim
>rm -rf ~/.vim

screen: screen/.screenrc screen/.screen/fast screen/.screen/slow
>stow -t ~ screen

keyd: keyd/default.conf
>sudo apt update
>sudo apt install keyd
>sudo stow -t /etc/keyd/ keyd
>sudo service keyd restart

asdf: bash
ifeq (,$(wildcard $(ASDF)))
>mkdir -p ~/.asdf
>cd ~/.asdf && git clone https://github.com/asdf-vm/asdf.git --branch v0.18.0
>cd ~/.asdf/asdf && make
endif

asdf-clean:
>rm -rf $(ASDF)

node: asdf
>asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
>asdf install nodejs latest

erlang: asdf
>sudo apt install curl build-essential autoconf m4 libncurses-dev libwxgtk3.2-dev libwxgtk-webview3.2-dev libgl1-mesa-dev libglu1-mesa-dev libpng-dev libssh-dev unixodbc-dev xsltproc fop libxml2-utils openjdk-21-jdk
>asdf plugin add erlang https://github.com/asdf-vm/asdf-erlang.git
>asdf install erlang latest

elixir: erlang
>asdf plugin add elixir https://github.com/asdf-vm/asdf-elixir.git
>asdf install elixir master

clean:
>for package in $(PACKAGES) ; do \
>	stow -D $$package ; \
>done
>rm -rf ~/.vim
