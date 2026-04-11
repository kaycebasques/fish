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

abbr --add ga "git add"
abbr --add ga. "git add ."
abbr --add gb "git branch"
abbr --add gcane "git commit --amend --no-edit"
abbr --add gcm "git commit -m"
abbr --add gd "git diff"
abbr --add gfo "git fetch origin"
abbr --add gl "git log"
abbr --add grom "git rebase origin/main"
abbr --add gp "git push"
abbr --add gs "git status"

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

set repos "technicalwriting.dev" "kaycebasques.net" "books" "sphinx" "fish-shell"
for repo in $repos
    if not test -d $HOME/$repo
        echo "$repo not found. Run `fish ~/cli/repos.fish` to set up."
    end
end
