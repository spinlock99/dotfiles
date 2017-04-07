PACKAGES=bash vim zsh screen hammerspoon git-hooks
.PHONY: $(PACKAGES)

all: $(PACKAGES)

list:
	@echo $(PACKAGES)

bash: bash/.bash_profile
	stow bash

vim: vim/.vimrc
	stow vim
	mkdir -p ~/.vim/bundle
	git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
	vim +PluginInstall +qall

vim-clean:
	stow -D vim
	rm -rf ~/.vim

zsh: zsh/.zshrc
	# Oh My Zsh for good default shell setup
	#sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
	curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh

	# Additional shell setup
	cp aliases.zsh ~/.oh-my-zsh/custom

	# Required for rbenv to work properly
	cp rbenv.zsh ~/.oh-my-zsh/custom
	stow zsh

screen: screen/.screenrc screen/.screen/fast screen/.screen/slow
	stow screen

hammerspoon: hammerspoon/.hammerspoon/init.lua
	stow hammerspoon

git-hooks: git-hooks/.git-hooks/prepare-commit-msg
	stow git-hooks

clean:
	for package in $(PACKAGES) ; do \
		stow -D $$package ; \
	done
	rm -rf ~/.vim
