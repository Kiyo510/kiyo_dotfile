.PHONY: setup
setup: 
	@echo	"--------------------Start setup--------------------"
	@./setup.sh
	@echo "--------------------Finished Successfully.--------------------"

.PHONY: sync-vscode
sync-vscode:
	@echo "------------------Start Sync VSCode Settings.-----------------"
	@cd vscode/ && ./sync.sh
	@echo "--------------------Finished Successfully.--------------------"

.PHONY: sync-alacritty
sync-alacritty:
	@echo "------------------Start Sync Alacritty Settings.-----------------"
	@cd alacritty/ && ./sync.sh
	@echo "--------------------Finished Successfully.--------------------"

.PHONY: brew-bundle
brew-bundle:
	brew bundle --file=$(HOME)/dotfiles/Brewfile

.PHONY: deploy
deploy:
	@echo "---------------Start setting dotfiles symbolic link.---------------"
	@./link.sh
	@echo "---------------Finished Successfully.---------------"

# .PHONY: shellcheck
# shellcheck:
# 	shellcheck ./vscode/*.sh ./zsh/.zprofile ./zsh/.zshenv .zshrc
