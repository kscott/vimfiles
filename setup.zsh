#! /bin/sh

if [[ ( ! -e $HOME/.vim || -L $HOME/.vim ) && ( ! -e $HOME/.gvimrc || -L $HOME/.gvimrc ) && ( ! -e $HOME/.vimrc || -L $HOME/.vimrc ) ]];
then
	if [[ ! -e $PWD/$(basename $0) ]];
	then
		echo "Run this script from the git repository."
		exit
	fi

	if [[ -e $HOME/.vim ]];
	then
		rm $HOME/.vim
	fi
	ln -s $PWD/vim $HOME/.vim

	if [[ -e $HOME/.vimrc ]];
	then
		rm $HOME/.vimrc
	fi
	ln -s $PWD/vimrc $HOME/.vimrc

	if [[ -e $HOME/.vimrc.bundles ]];
	then
		rm $HOME/.vimrc.bundles
	fi
	ln -s $PWD/vimrc.bundles $HOME/.vimrc.bundles

	if [[ -e $HOME/.gvimrc ]];
	then
		rm $HOME/.gvimrc
	fi
	ln -s $PWD/gvimrc $HOME/.gvimrc

	git submodule update --init
	vim -u vimrc.bundles +BundleInstall +qall!

	if [[ -d vim/bundle/YouCompleteMe ]];
	then
		cd vim/bundle/YouCompleteMe && ./install.sh --clang-completer
	fi
else
	echo "Remove existing vim configuration files before running this script."
fi
