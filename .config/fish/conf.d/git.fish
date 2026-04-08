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
git config --global commit.gpgsign true

if not test -d $HOME/pigweed
    cd $HOME
    git clone https://pigweed.googlesource.com/pigweed/pigweed
    cd pigweed
    set -l f (git rev-parse --git-dir)/hooks/commit-msg
    mkdir -p (dirname $f)
    curl -Lo $f https://gerrit-review.googlesource.com/tools/hooks/commit-msg
    chmod +x $f
    echo "TODO: go/pigweed-onboarding#git-config"
    git config --local user.email "kayce@google.com"
    git config --local commit.gpgsign false
    cd -
end	
