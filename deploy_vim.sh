#!/bin/bash

# Install pre-requisites
sudo apt install libncurses5-dev libgnome2-dev libgnomeui-dev \
libgtk2.0-dev libatk1.0-dev libbonoboui2-dev \
libcairo2-dev libx11-dev libxpm-dev libxt-dev python-dev python3-dev

# Remove previous versions of vim
sudo apt remove vim vim-runtime gvim

# Pull source
cd ~
git clone https://github.com/vim/vim.git

# Build and install vim
cd vim
./configure --with-features=huge \
            --enable-multibyte \
	    --enable-pythoninterp=yes \
	    --with-python-config-dir=$(find /usr/lib/python2.7/ -name "config*" -type d) \
            --enable-gui=gtk2 \
            --enable-cscope \
	    --prefix=/usr/local

make VIMRUNTIMEDIR=/usr/local/share/vim/vim82
cd ~/vim
sudo make install

# Make vim default editor
sudo update-alternatives --install /usr/bin/editor editor /usr/local/bin/vim 1
sudo update-alternatives --set editor /usr/local/bin/vim
sudo update-alternatives --install /usr/bin/vi vi /usr/local/bin/vim 1
sudo update-alternatives --set vi /usr/local/bin/vim

# Cleanup
cd ~
sudo rm -rf vim

# Install Vundle plugin manager
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# Get configuration files
cd ~
git clone https://github.com/simoncouture/dotfiles.git
cp ~/dotfiles/.vimrc ~/
cp -R ~/dotfiles/.vim/colors ~/.vim/
cp -R ~/dotfiles/.vim/ftplugin ~/.vim/
cp ~/dotfiles/sandboxpylint.vim ~/.vim/bundle/ale/ale_linters/python/
cp ~/dotfiles/doclint.vim ~/.vim/bundle/ale/ale_linters/python/
cp ~/dotfiles/flake8 ~/.config/

# Install fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# Install plugins using Vundle
vim -c VundleUpdate -c quitall

# Compile YouCompleteMe
sudo pip install --upgrade cryptography  # May have to do this 
sudo apt install build-essential cmake python3-dev
cd ~/.vim/bundle/YouCompleteMe
python install.py --clang-completer

# Install ctags
sudo apt install exuberant-ctags

# Install flake8
sudo pip install flake8

# Install sshpass
sudo apt install sshpass
