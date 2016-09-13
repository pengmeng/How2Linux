#!/bin/bash

# Script for installing tmux on systems where you don't have root access.
# tmux will be installed in $LOCAL_PATH.
# It's assumed that wget and a C/C++ compiler are installed.

# exit on error
set -e

TMUX_VERSION=2.2
LOCAL_PATH=$HOME/local

# create our directories
mkdir -p $LOCAL_PATH $HOME/tmux_tmp
cd $HOME/tmux_tmp

# download source files for tmux, libevent, and ncurses
wget -O tmux-${TMUX_VERSION}.tar.gz --no-check-certificate https://github.com/tmux/tmux/releases/download/${TMUX_VERSION}/tmux-${TMUX_VERSION}.tar.gz
wget -O libevent-2.0.22-stable.tar.gz --no-check-certificate https://github.com/libevent/libevent/releases/download/release-2.0.22-stable/libevent-2.0.22-stable.tar.gz
curl -O http://ftp.gnu.org/gnu/ncurses/ncurses-6.0.tar.gz

# extract files, configure, and compile

############
# libevent #
############
tar xvzf libevent-2.0.22-stable.tar.gz
cd libevent-2.0.22-stable
./configure --prefix=$LOCAL_PATH --disable-shared
make
make install
cd ..

############
# ncurses  #
############
tar xvzf ncurses-6.0.tar.gz
cd ncurses-6.0
./configure --prefix=$LOCAL_PATH
make
make install
cd ..

############
# tmux     #
############
tar xvzf tmux-${TMUX_VERSION}.tar.gz
cd tmux-${TMUX_VERSION}
./configure CFLAGS="-I$LOCAL_PATH/include -I$LOCAL_PATH/include/ncurses" LDFLAGS="-L$LOCAL_PATH/lib -L$LOCAL_PATH/include/ncurses -L$LOCAL_PATH/include"
CPPFLAGS="-I$LOCAL_PATH/include -I$LOCAL_PATH/include/ncurses" LDFLAGS="-static -L$LOCAL_PATH/include -L$LOCAL_PATH/include/ncurses -L$LOCAL_PATH/lib" make
cp tmux $LOCAL_PATH/bin

# go back to home to make sure the deletion of tmux_tmp could be sucessfully
cd ~

# cleanup
rm -rf $HOME/tmux_tmp

echo "$LOCAL_PATH/bin/tmux is now available. You can optionally add $LOCAL_PATH/bin to your PATH."
