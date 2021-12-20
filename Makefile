#---------------------------------------------------------------------------
MAKEFILE_PATH := $(abspath $(lastword ${MAKEFILE_LIST}))
MAKEFILE_DIR := $(dir ${MAKEFILE_PATH})
#---------------------------------------------------------------------------
REPO_DIR := ~/.repos/
FZF_DIR := $(REPO_DIR)fzf
CCLS_VERSION := master
CCLS_REPO_DIR := $(REPO_DIR)ccls/repo
CCLS_BUILD_DIR := $(REPO_DIR)ccls/build
CCLS_INSTALL_PREFIX := ~/.local
SCALA_METALS := org.scalameta:metals_2.12:0.9.8
#---------------------------------------------------------------------------
install-minimal:
	@sh -c "[ -f /etc/arch-release ] && yay -Syyu --needed curl neovim clang llvm gcc python python-pip cmake tmux git ccache ninja cgdb rr || echo 'OS is not Arch';"
	@sh -c "[ -f /etc/lsb-release ] && sudo apt install curl neovim clang llvm llvm-dev gcc python3 python3-pip cmake tmux cmake-curses-gui git ninja-build ccache cgdb || echo 'OS is not Ubuntu';"
	#yay -Syyu nvm
	#nvm install node
#---------------------------------------------------------------------------
install-desktop:
	@sh -c "[ -f /etc/arch-release ] && yay -Syyu --needed vlc inkscape gimp thunderbird chromium texlive-core libreoffice aspell-de aspell-en hunspell-de hunspell-en_us || echo 'OS is not Arch';"
	@sh -c "[ -f /etc/lsb-release ] && sudo apt install vlc inkscape gimp thunderbird chromium-browser texlive libreoffice aspell-de aspell-en hunspell-de-de hunspell-en-us || echo 'OS is not Ubuntu';"
#---------------------------------------------------------------------------
install-fzf:
	if [ ! -d $(FZF_DIR) ]; then \
		git clone --depth 1 https://github.com/junegunn/fzf.git $(FZF_DIR); \
	fi
	$(FZF_DIR)/install --bin
#---------------------------------------------------------------------------
install-ls-ccls:
	rm -rf $(CCLS_REPO_DIR) $(CCLS_BUILD_DIR)
	git clone --recursive https://github.com/MaskRay/ccls $(CCLS_REPO_DIR)
	cd $(CCLS_REPO_DIR) && git checkout $(CCLS_VERSION)
	mkdir -p $(CCLS_INSTALL_PREFIX) $(CCLS_BUILD_DIR)
	cd $(CCLS_BUILD_DIR) && cmake -DCLANG_LINK_CLANG_DYLIB=on -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$(CCLS_INSTALL_PREFIX) $(CCLS_REPO_DIR)
	cd $(CCLS_BUILD_DIR) && make -j8
	cd $(CCLS_BUILD_DIR) && make install
#---------------------------------------------------------------------------
install-ls-general:
	pip3 install neovim python-language-server compiledb
#---------------------------------------------------------------------------
install-ls-ts:
	sudo npm i -g typescript-language-server
#---------------------------------------------------------------------------
install-ls-scala:
	curl -fLo coursier https://git.io/coursier-cli-linux
	chmod +x coursier
	./coursier bootstrap \
  		--java-opt -Xss4m \
  		--java-opt -Xms100m \
  		--java-opt -Dmetals.client=LanguageClient-neovim \
		${SCALA_METALS} \
  		-r bintray:scalacenter/releases \
  		-r sonatype:snapshots \
  		-o  ~/.local/bin/metals-vim -f
	rm coursier
#---------------------------------------------------------------------------
install-vim:
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
#---------------------------------------------------------------------------
install-vscode:
	@sh -c "[ -f /etc/arch-release ] && yay -Syyu visual-studio-code-bin || echo 'OS is not Arch';"
	@mkdir -p ~/.config/Code/User
	@sh -c "[ ! -f ~/.config/Code/User/settings.json ] || rm ~/.config/Code/User/settings.json;"
	@sh -c "[ ! -f ~/.config/Code/User/keybindings.json ] || rm ~/.config/Code/User/keybindings.json;"
	@cp ${MAKEFILE_DIR}vscode/settings.json ~/.config/Code/User/
	@cp ${MAKEFILE_DIR}vscode/keybindings.json ~/.config/Code/User/
	cat ${MAKEFILE_DIR}vscode/extensions_list.txt | xargs -n 1 code --install-extension
#---------------------------------------------------------------------------
install-symlinks:
	@mkdir -p ~/.local
	@sh -c "rm -f ~/.bashrc;"
	@sh -c "rm -f ~/.clang-format;"
	@sh -c "rm -rf ~/.tmux;"
	@sh -c "rm -f ~/.tmux.conf;"
	@sh -c "rm -rf ~/.vim;"
	@sh -c "rm -rf ~/.config/nvim;"
	@sh -c "rm -f ~/.shell_prompt.sh;"
	@mkdir -p ~/.config/nvim
	@cp ${MAKEFILE_DIR}.bashrc ~/
	@cp ${MAKEFILE_DIR}.clang-format ~/
	@cp -a ${MAKEFILE_DIR}.tmux ~/
	@cp ${MAKEFILE_DIR}.tmux.conf ~/
	@cp -a ${MAKEFILE_DIR}.vim/* ~/.config/nvim/
	@cp ${MAKEFILE_DIR}.shell_prompt.sh ~/
#---------------------------------------------------------------------------
install-vim-deoplete:
	@mkdir -p ~/.vim/plugged/deoplete.nvim/rplugin/python3/deoplete/filter/
	@mv ~/.config/nvim/converter_truncate_abbr_cpp.py ~/.vim/plugged/deoplete.nvim/rplugin/python3/deoplete/filter/
#---------------------------------------------------------------------------
install-ls: install-ls-general install-ls-ccls install-ls-scala
#---------------------------------------------------------------------------
install: install-minimal install-fzf install-symlinks install-vim install-ls
#---------------------------------------------------------------------------
install-gui: install install-desktop
