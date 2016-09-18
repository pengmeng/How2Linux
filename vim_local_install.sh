#!/bin/bash

# Install vim to local path without root access
# Require git and c/c++ compiler

# exit on error
set -e

LOCAL_PATH=$HOME/local

# make temp working dir
mkdir -p $LOCAL_PATH $HOME/vim_tmp
cd $HOME/vim_tmp

# clone vim source code from github
# must have git install
git clone https://github.com/vim/vim.git

# compile and install vim
cd vim

# edit this line to enable more vim feature
./configure --with-features=huge --enable-pythoninterp --prefix=$LOCAL_PATH
make
make install
cd ..

# go back home and delete temp dir
cd ~
rm -rf $HOME/vim_tmp

echo "$LOCAL_PATH/bin/vim is now available. You can optionally add $LOCAL_PATH/bin to your PATH"
