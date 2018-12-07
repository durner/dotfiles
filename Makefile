#---------------------------------------------------------------------------
MAKEFILE_PATH := $(abspath $(lastword ${MAKEFILE_LIST}))
MAKEFILE_DIR := $(dir ${MAKEFILE_PATH})
#---------------------------------------------------------------------------
REPO_DIR := ~/.repos/
FZF_DIR := $(REPO_DIR)fzf
CCLS_REPO_DIR := $(REPO_DIR)ccls/repo
CCLS_BUILD_DIR := $(REPO_DIR)ccls/build
CCLS_INSTALL_PREFIX := ~/.local
#---------------------------------------------------------------------------
install-fzf:
	if [ ! -d $(FZF_DIR) ]; then \
		git clone --depth 1 https://github.com/junegunn/fzf.git $(FZF_DIR); \
	fi
	$(FZF_DIR)/install --bin
#---------------------------------------------------------------------------
install-ls:
	rm -rf $(CCLS_REPO_DIR) $(CCLS_BUILD_DIR)
	git clone --recursive https://github.com/MaskRay/ccls $(CCLS_REPO_DIR)
	mkdir -p $(CCLS_INSTALL_PREFIX) $(CCLS_BUILD_DIR)
	cd $(CCLS_BUILD_DIR) && cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$(CCLS_INSTALL_PREFIX) $(CCLS_REPO_DIR)
	cd $(CCLS_BUILD_DIR) && make -j4
	cd $(CCLS_BUILD_DIR) && make install
	pip3 install neovim python-language-server
#---------------------------------------------------------------------------
install-symlinks:
	@mkdir -p ~/.config
	@mkdir -p ~/.local
	@sh -c "[ ! -L ~/.bashrc ] || rm ~/.bashrc;"
	@sh -c "[ ! -L ~/.clang-format ] || rm ~/.clang-format;"
	@sh -c "[ ! -L ~/.tmux.conf ] || rm ~/.tmux.conf;"
	@sh -c "[ ! -L ~/.vim ] || rm -rf ~/.vim;"
	@sh -c "[ ! -L ~/.vimrc ] || rm ~/.vimrc;"
	@sh -c "[ ! -L ~/.shell_prompt.sh ] || rm ~/.shell_prompt.sh;"
	@ln -sf ${MAKEFILE_DIR}.bashrc ~/.bashrc
	@ln -sf ${MAKEFILE_DIR}.clang-format ~/.clang-format
	@ln -sf ${MAKEFILE_DIR}.tmux.conf ~/.tmux.conf
	@ln -sf ${MAKEFILE_DIR}.vim ~/.vim
	@ln -sf ${MAKEFILE_DIR}.vimrc ~/.vimrc
	@ln -sf ${MAKEFILE_DIR}.shell_prompt.sh ~/.shell_prompt.sh
#---------------------------------------------------------------------------
install: install-fzf install-symlinks install-ls
#---------------------------------------------------------------------------
