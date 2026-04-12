#!/usr/bin/fish

if not test -d $HOME/pigweed
    cd $HOME
    git clone --depth 1 https://pigweed.googlesource.com/pigweed/pigweed
    cd pigweed
    set -l f (git rev-parse --git-dir)/hooks/commit-msg
    mkdir -p (dirname $f)
    curl -Lo $f https://gerrit-review.googlesource.com/tools/hooks/commit-msg
    chmod +x $f
    echo "TODO: go/pigweed-onboarding#git-config"
    git config --local user.email "kayce@google.com"
    git config --local commit.gpgsign false
    cd $HOME
end

set repos "technicalwriting.dev" "kaycebasques.net" "books" "sphinx" "fish-shell"
for repo in $repos
    if not test -d $HOME/$repo
        cd $HOME
        git clone --depth 1 git@github.com:kaycebasques/$repo.git
        cd $repo
        git config --local user.email "kaycebasques@gmail.com"
        git config --local commit.gpgsign true
        cd $HOME
    end
end


