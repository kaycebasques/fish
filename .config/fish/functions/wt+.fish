function wt+ -d "Create a new worktree + branch and cd into it"
    set -l name $argv[1]
    git worktree add -b $name $HOME/wt/$name
    cd $HOME/wt/$name
end
