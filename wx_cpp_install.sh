#!/bin/bash
set -e
set -u
current=$(pwd)
gtkbuild=$current'/gtk-build/wxWidgets-3.0.5'
boldgreen='\033[1;32m'
normal='\033[0m'
boldred='\033[1;31m'

say() {
    printf "%b\n" "${boldgreen:-}wx-install:${normal:-} $1"
}

download_dependencies() {
    sudo apt update -y
    sudo apt-get install -y build-essential libgtk2.0-dev libgtk-3-dev 
}

get_wx() {
    wget https://github.com/wxWidgets/wxWidgets/releases/download/v3.0.5/wxWidgets-3.0.5.tar.bz2
    mkdir $current/wx
    cd $current
    echo "\n\ndecompressing....\n\n"
    tar -xf $current/wxWidgets-3.0.5.tar.bz2 -C $current/wx
    cd $current/wx
    
}
make_wx() {
    cd $current/wx/wxWidgets-3.0.5/build
    ../configure --with-gtk=3 --with-opengl --enable-debug
    make -j3
    sudo make install
    sudo make clean
    sudo ldconfig    
}
echo "\n\n getting dependencies... \n\n"
download_dependencies
echo "\n\n getting wx widgets"
get_wx
echo "\n\n making wx widgets \n\n"
make_wx
tput bel
echo "\n\n $boldgreen append $normal\n"
sleep 0.5
echo " $boldred export PATH=$PATH:/home/$USER/wx/wxWidgets-3.1.3/lib/gtk3_so/bin $normal "
sleep 0.5
echo " to your $boldgreen .bashrc $normal file "
tput bel