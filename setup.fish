#!/usr/bin/env fish

# Set up vars for key dirs
set my_conf (status dirname)
set fish_conf "$HOME/.config/fish"

# Update fish to use my configs
set dirs "conf.d" "functions"
for dir in $dirs
    set source "$my_conf/$dir"
    set target "$fish_conf/$dir"
    if not test -d $target
        mkdir -p $target
    end
    cp $source/* $target/
end
