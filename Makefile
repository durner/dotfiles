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
	yay -Syyu curl neovim clang nvm llvm gcc python python-pip cmake clang-format libclang-dev cmake-curses-gui
#---------------------------------------------------------------------------
install-desktop:
	yay -Syyu vlc thunderbird chromium-browser texlive tlp aspell-de aspell-en hunspell-de-de hunspell-en-us
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
install-symlinks:
	@mkdir -p ~/.config
	@mkdir -p ~/.local
	@sh -c "[ ! -L ~/.bashrc ] || rm ~/.bashrc;"
	@sh -c "[ ! -L ~/.clang-format ] || rm ~/.clang-format;"
	@sh -c "[ ! -L ~/.tmux ] || rm -rf ~/.tmux;"
	@sh -c "[ ! -L ~/.tmux.conf ] || rm ~/.tmux.conf;"
	@sh -c "[ ! -L ~/.vim ] || rm -rf ~/.vim;"
	@sh -c "[ ! -L ~/.config/nvim ] || rm -rf ~/.config/nvim;"
	@sh -c "[ ! -L ~/.vimrc ] || rm ~/.vimrc;"
	@sh -c "[ ! -L ~/.shell_prompt.sh ] || rm ~/.shell_prompt.sh;"
	@cp ${MAKEFILE_DIR}.bashrc ~/
	@cp ${MAKEFILE_DIR}.clang-format ~/
	@cp -a ${MAKEFILE_DIR}.tmux ~/
	@cp ${MAKEFILE_DIR}.tmux.conf ~/
	@cp -a ${MAKEFILE_DIR}.vim ~/.config/nvim
	@cp ${MAKEFILE_DIR}.shell_prompt.sh ~/
#---------------------------------------------------------------------------
install-ls: install-ls-general install-ls-ts install-ls-ccls install-ls-scala
#---------------------------------------------------------------------------
install: install-minimal install-fzf install-symlinks install-ls
#---------------------------------------------------------------------------
install-gui: install install-desktop
