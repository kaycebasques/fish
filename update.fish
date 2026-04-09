#!/usr/bin/env fish

set dir (status dirname)

cp $dir/.bashrc $HOME/.bashrc
cp $dir/.config/user-dir.dirs $HOME/.config/user-dir.dirs
cp $dir/.config/fish/conf.d/* $HOME/.config/fish/conf.d/
cp $dir/.config/fish/functions/* $HOME/.config/fish/functions/

# TODO move this
set default_dirs "Documents" "Downloads" "Music" "Pictures" "Public" "Templates" "Videos"
for default_dir in $default_dirs
    set default_dir "$HOME/$default_dir"
    if not test -d $default_dir
        continue
    end	
    rmdir $default_dir
end

# TODO move this
if not test -f $HOME/bazelisk
    curl -L https://github.com/bazelbuild/bazelisk/releases/latest/download/bazelisk-linux-amd64 -o $HOME/bazelisk
    chmod +x $HOME/bazelisk
end
