PACKAGES=bash vim zsh screen
.PHONY: $(PACKAGES)

all: $(PACKAGES)

list:
	@echo $(PACKAGES)

bash: bash/.bash_profile
	stow bash

vim: vim/.vimrc
	stow vim
	mkdir -p ~/.vim/bundle
	rm -rf ~/.vim/bundle/vundle
	git clone https://github.com/gmarik/vundle ~/.vim/bundle/vundle
	vim +PluginInstall +qall

zsh: zsh/.zshrc
	# Oh My Zsh for good default shell setup
	#sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
	curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh

	# Additional shell setup
	cp aliases.zsh ~/.oh-my-zsh/custom

	# Required for rbenv to work properly
	cp rbenv.zsh ~/.oh-my-zsh/custom
	stow zsh

screen: screen/.screenrc
	stow screen

clean:
	for package in $(PACKAGES) ; do \
		stow -D $$package ; \
	done
	rm -rf ~/.vim
