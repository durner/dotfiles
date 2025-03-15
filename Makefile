#---------------------------------------------------------------------------
MAKEFILE_PATH := $(abspath $(lastword ${MAKEFILE_LIST}))
MAKEFILE_DIR := $(dir ${MAKEFILE_PATH})
#---------------------------------------------------------------------------
CCLS_VERSION := master
CCLS_REPO_DIR := $(REPO_DIR)ccls/repo
CCLS_BUILD_DIR := $(REPO_DIR)ccls/build
CCLS_INSTALL_PREFIX := ~/.local
REPO_DIR := ~/.repos/
FZF_DIR := $(REPO_DIR)fzf
#---------------------------------------------------------------------------
install-minimal:
	@sh -c "[ -f /etc/arch-release ] && yay -Syyu --needed curl neovim wl-clipboard clang llvm lldb gcc python python-pip cmake tmux git ccache ninja cgdb rr npm ufw zsh alacritty || echo 'OS is not Arch';"
	@sh -c "[ -f /etc/lsb-release ] && sudo apt install curl neovim wl-clipboard clang clangd llvm llvm-dev gcc python3 python3-pip cmake tmux cmake-curses-gui git ninja-build ccache cgdb libclang-dev lld liburing-dev npm ufw zsh tree-sitter-cli language-pack-en alacritty || echo 'OS is not Ubuntu';"
	@sh -c "curl -O https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh; chmod +x install.sh; ./install.sh --unattended; rm -f install.sh;"
	sudo chsh -s /bin/zsh durner
	sudo chsh -s /bin/zsh root
	#yay -Syyu nvm
	#nvm install node
#---------------------------------------------------------------------------
install-docker:
	@sh -c "[ -f /etc/arch-release ] && yay -Syyu --needed docker docker-compose containerd runc && sudo systemctl enable docker.service || echo 'OS is not Arch';"
	@sh -c "[ -f /etc/lsb-release ] && sudo apt install docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc || echo 'OS is not Ubuntu';"
	sudo usermod -aG docker durner
#---------------------------------------------------------------------------
install-firewall:
	sudo systemctl enable ufw
	sudo ufw default deny
	sudo ufw limit ssh
	sudo ufw enable
#---------------------------------------------------------------------------
install-desktop:
	@sh -c "[ -f /etc/arch-release ] && yay -Syyu --needed vlc inkscape gimp thunderbird chromium texlive-core texlive-bibtexextra texlive-latex texlive-latexextra texlive-fontsextra texlive-mathscience biber libreoffice aspell-de aspell-en hunspell-de hunspell-en_us borg butt || echo 'OS is not Arch';"
	@sh -c "[ -f /etc/lsb-release ] && sudo apt install vlc inkscape gimp thunderbird chromium-browser texlive libreoffice aspell-de aspell-en hunspell-de-de hunspell-en-us ufw || echo 'OS is not Ubuntu';"
	sudo cp ${MAKEFILE_DIR}/scripts/wifi-wired-exclusive.sh /etc/NetworkManager/dispatcher.d/70-wifi-wired-exclusive.sh
	sudo systemctl enable ufw
	sudo ufw default deny
	sudo ufw limit ssh
	sudo ufw enable
#---------------------------------------------------------------------------
install-laptop:
	@sh -c "[ -f /etc/arch-release ] && yay -Syyu --needed laptop-mode-tools ntfs-3g ttf-dejavu-nerd ttf-jetbrains-mono-nerd mattermost-desktop whatsapp-nativefier || echo 'OS is not Arch';"
	@sh -c "[ -f /etc/lsb-release ] && sudo apt install laptop-mode-tools ntfs-3g mattermost-desktop || echo 'OS is not Ubuntu';"
	sudo systemctl enable laptop-mode
	sudo systemctl enable bluetooth
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
	cd $(CCLS_BUILD_DIR) && cmake -DCMAKE_FIND_PACKAGE_SORT_ORDER=NATURAL -DCMAKE_FIND_PACKAGE_SORT_DIRECTION=DEC -DCLANG_LINK_CLANG_DYLIB=on -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$(CCLS_INSTALL_PREFIX) $(CCLS_REPO_DIR)
	cd $(CCLS_BUILD_DIR) && make -j8
	cd $(CCLS_BUILD_DIR) && make install
#---------------------------------------------------------------------------
install-ls-general:
	# pip3 install neovim python-language-server compiledb
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
	@sh -c "rm -f ~/.clangd;"
	@sh -c "rm -f ~/.zshrc;"
	@sh -c "rm -f ~/.gdbinit;"
	@sh -c "rm -f ~/.gitconfig;"
	@sh -c "rm -f ~/.clang-format;"
	@sh -c "rm -f ~/.clang-tidy;"
	@sh -c "rm -rf ~/.tmux;"
	@sh -c "rm -f ~/.tmux.conf;"
	@sh -c "rm -rf ~/.config/nvim;"
	@sh -c "rm -rf ~/.config/alacritty;"
	@sh -c "rm -f ~/.shell_prompt.sh;"
	@sh -c "rm -f ~/.ideavimrc;"
	@mkdir -p ~/.config/nvim
	@mkdir -p ~/.config/alacritty
	@cp ${MAKEFILE_DIR}.bashrc ~/
	@cp ${MAKEFILE_DIR}.clangd ~/
	@cp ${MAKEFILE_DIR}.gitconfig ~/
	@cp ${MAKEFILE_DIR}.zshrc ~/
	@cp ${MAKEFILE_DIR}.gdbinit ~/
	@cp ${MAKEFILE_DIR}.clang-format ~/
	@cp ${MAKEFILE_DIR}.clang-tidy ~/
	@cp -a ${MAKEFILE_DIR}.tmux ~/
	@cp ${MAKEFILE_DIR}.tmux.conf ~/
	@cp -a ${MAKEFILE_DIR}nvim/* ~/.config/nvim/
	@cp -a ${MAKEFILE_DIR}alacritty/* ~/.config/alacritty/
	@cp ${MAKEFILE_DIR}.shell_prompt.sh ~/
	@cp ${MAKEFILE_DIR}clion/ideavimrc ~/.ideavimrc
#---------------------------------------------------------------------------
install-ls: install-ls-general
#---------------------------------------------------------------------------
install: install-virtual install-firewall
#---------------------------------------------------------------------------
install-virtual: install-minimal install-fzf install-symlinks install-ls
#---------------------------------------------------------------------------
install-gui: install install-desktop install-laptop install-firewall
