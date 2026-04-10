function wt- -d "Delete an existing worktree and branch"
    set -l name $argv[1]
    git worktree remove $HOME/wt/$name
    git branch -D $name
end
