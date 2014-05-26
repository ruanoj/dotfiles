# Where my dotfiles are
DFDIR=$(HOME)/dotfiles
# path where Vundle lives
VUNDLEDIR=~/.vim/bundle/vundle
# path where ycm lives
YCMDIR=~/.vim/bundle/YouCompleteMe

all: symlinks clone_vundle ycm
	@echo "Reminder- Vim plugins are managed within Vim with Vundle."
	@echo "          Run :BundleInstall from Vim."

symlinks:
	@if [ ! -L ~/.vimrc ]; then \
		make real_symlinks; \
	fi

real_symlinks:
	@ln -nsf $(DFDIR)/zsh/zsh ~/.zsh
	@ln -sf $(DFDIR)/zsh/zshenv ~/.zshenv
	@ln -sf $(DFDIR)/zsh/zshrc ~/.zshrc
	@ln -nsf $(DFDIR)/vim/vim ~/.vim
	@ln -sf $(DFDIR)/vim/vimrc ~/.vimrc
	@ln -nsf $(DFDIR)/vim/plugin ~/.vim/plugin
	@ln -sf $(DFDIR)/tmux/tmux.conf ~/.tmux.conf
	@ln -sf $(DFDIR)/git/gitconfig ~/.gitconfig
	@ln -sf $(DFDIR)/git/gitignore_global ~/.gitignore_global
	@ln -sf $(DFDIR)/ctags/ctags ~/.ctags

clone_vundle: 
	@if [ ! -d $(VUNDLEDIR) ]; \
	then git clone https://github.com/gmarik/Vundle.vim.git $(VUNDLEDIR); \
	fi

ycm:
	@if [ -d $(YCMDIR) ]; \
	then \
		if [ ! -e $(YCMDIR)/third_party/ycmd/ycm_core.so ]; \
		then cd $(YCMDIR) && ./install.sh; \
		fi; \
	else echo "Remember to re-run make once Vim plugins are installed"; \
	fi

