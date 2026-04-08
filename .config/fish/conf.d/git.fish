#!/usr/bin/fish

if not command -s git > /dev/null
    sudo apt install git
end

if not test -e $HOME/.ssh/id_ed25519.pub
    echo "SSH key not found. Run `fish ~/cli/ssh.fish` to set up."
end

if not test -n "$(gpg --list-secret-keys --keyid-format=long 2>/dev/null)"
    echo "GPG key not found. Run `fish ~/cli/gpg.fish` to set up."
end

git config --global core.editor "vim"
git config --global user.name "Kayce Basques"
git config --global user.email "kaycebasques@gmail.com"
# pigweed has a test that breaks when signing is enabled
# globally. easier to just manually configure for personal repos.
git config --global commit.gpgsign false

if not test -d $HOME/pigweed
    echo "Pigweed repo not found. Run `fish ~/cli/repos.fish` to set up."
end

if not test -d $HOME/wt
    mkdir $HOME/wt
end
