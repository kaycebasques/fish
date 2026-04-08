#!/usr/bin/fish

if not test -e $HOME/.ssh/id_ed25519.pub
    ssh-keygen -t ed25519 -C "kaycebasques@gmail.com"
    eval (ssh-agent -c)
    ssh-add $HOME/.ssh/id_ed25519
    echo "TODO: Add the following key to https://github.com/settings/ssh/new"
    cat $HOME/.ssh/id_ed25519.pub
end

if not test -n "$(gpg --list-secret-keys --keyid-format=long 2>/dev/null)"
    gpgconf --kill gpg-agent
    gpg --full-generate-key
    gpg --list-secret-keys --keyid-format=long
    read -P "Enter the ID (the part after `sec ed25519/`):" key_id
    gpg --armor --export $key_id
    echo "TODO: Add the key to https://github.com/settings/gpg/new"
end

git config --global core.editor "vim"
git config --global user.name "Kayce Basques"
git config --global user.email "kaycebasques@gmail.com"
