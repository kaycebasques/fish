function wt
    set -l subcmd $argv[1]
    set -l number $argv[2]

    switch $subcmd
        case create
            if test -z "$number"
                echo "Usage: wt create <change_number>"
                return 1
            end

            set -l shard (printf "%02d" (math "$number % 100"))
            
            # Get remote URL for origin
            set -l url (git remote get-url origin)
            if test $status -ne 0
                echo "Failed to get remote URL for origin"
                return 1
            end

            echo "Fetching refs for change $number from $url..."
            set -l lines (git ls-remote $url "refs/changes/$shard/$number/*")
            
            if test -z "$lines"
                echo "No refs found for change $number"
                return 1
            end
            
            set -l patchsets
            for line in $lines
                set -l ref (string split -m 1 \t $line)[2]
                set -l parts (string split / $ref)
                set -l ps $parts[-1]
                if test "$ps" != "meta"
                    set -a patchsets $ps
                end
            end
            
            set -l latest_ps (printf "%s\n" $patchsets | sort -n | tail -n1)
            echo "Latest patchset is $latest_ps"
            
            set -l ref "refs/changes/$shard/$number/$latest_ps"
            
            echo "Fetching $ref..."
            git fetch $url $ref
            if test $status -ne 0
                echo "Failed to fetch $ref"
                return 1
            end
            
            set -l wt_path "$HOME/wt/$number"
            set -l branch "$number"
            
            echo "Creating worktree at $wt_path..."
            git worktree add $wt_path -b $branch FETCH_HEAD
            
            if test $status -eq 0
                echo "Changing directory to $wt_path"
                cd $wt_path
            end
            
        case '*'
            echo "Unknown subcommand: $subcmd"
            return 1
    end
end
