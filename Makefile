bash_files := ~/.bashrc ~/.bashrc.local ~/.bashrc.secret
vim_files := ~/.vimrc ~/.vimrc.local

user_files := bashrc.local bashrc.secret vimrc.local
linked_files := vimrc bashrc

.PHONY: $(vim_files) $(bash_files) $(linked_files) $(user_files)

define restore
	unlink $(1) 2>/dev/null;
	mv $(1).original $(1) 2>/dev/null || true;
endef

define link_dotfile
	ln -sf $(PWD)/$(1) $(HOME)/.$(1)
endef

# Back up existing dotfiles
back_up: $(vim_files) $(bash_files)
	$(foreach filename,$^,cp $(filename) $(filename).original 2>/dev/null || true;)

# Back up and install dotfiles
install: back_up
	# Link each dotfile
	$(foreach filename,$(linked_files),ln -sf $(PWD)/$(filename) $(HOME)/.$(filename);)
	# Copy examples of local configs
	$(foreach filename,$(user_files),cp -n $(PWD)/example.$(filename) $(HOME)/.$(filename);)

# Restore previously backed-up dotfiles
restore: $(vim_files) $(bash_files)
	$(foreach filename,$^,$(call restore,$(filename)))
