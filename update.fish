#!/usr/bin/env fish

set dir (status dirname)

cp $dir/.bashrc $HOME/.bashrc
cp $dir/.config/user-dir.dirs $HOME/.config/user-dir.dirs
cp $dir/.config/fish/conf.d/* $HOME/.config/fish/conf.d/
cp $dir/.config/fish/functions/* $HOME/.config/fish/functions/
