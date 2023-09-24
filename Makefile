install:
	./install.sh
    @mkdir -p "$$HOME/.config"
	@mkdir -p "$$HOME/.gnuconf"
    ln -sf "$(abspath gitconfig)" "$$HOME/.gitconfig"
    ln -sf "$(abspath gitignore)" "$$HOME/.gitignore"
	ln -sf "$(abspath ssh_config)" "$$HOME/.ssh/config"
	ln -sf "$(abspath gpg.conf)" "$$HOME/.gnupg/gpg.conf"
	ln -sf "$(abspath gpg-agent.conf)" "$$HOME/.gnupg/gpg-agent.conf"
	ln -sf "$(abspath zshrc)" "$$HOME/.zshrc"

# Rule to remove the symbolic links
uninstall:
    rm "$$HOME/.gitconfig"
    rm "$$HOME/.gitignore"
	rm "$$HOME/.ssh/config"
	rm "$$HOME/.gnupg/gpg.conf"
	rm "$$HOME/.gnupg/gpg-agent.conf"
	rm "$$HOME/.zshrc"

.PHONY: install uninstall
