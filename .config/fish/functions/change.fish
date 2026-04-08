function change -d "Fetch and create worktree for a Pigweed Gerrit change"
    set change_id $argv[1]
    set branch_name $argv[2]

    # Check usage
    if test -z "$change_id"
        echo "Usage: pw_checkout <number> <name>"
        return 1
    end
    if test -z "$branch_name"
        echo "Usage: pw_checkout <number> <name>"
        return 1
    end

    set remote_url "https://pigweed.googlesource.com/pigweed/pigweed"

    # Gerrit shards references by the last two digits of the change number
    # We use printf to ensure single-digit changes are 0-padded (e.g., "05")
    set change_padded (printf "%02d" $change_id)
    set suffix (string sub -s -2 $change_padded)

    echo "=> Querying latest patchset for change $change_id..."

    # 1. git ls-remote fetches all refs for this change
    # 2. string match uses regex (-r) and capture groups (-g) to extract just the patchset numbers
    # 3. sort -n sorts them numerically, and tail -n1 grabs the highest number
    set latest_ps (git ls-remote $remote_url "refs/changes/$suffix/$change_id/*" \
        | string match -rg "refs/changes/$suffix/$change_id/([0-9]+)" \
        | sort -n \
        | tail -n1)

    if test -z "$latest_ps"
        echo "Error: Could not find any patchsets for change $change_id."
        return 1
    end

    echo "=> Found latest patchset: $latest_ps"
    set fetch_ref "refs/changes/$suffix/$change_id/$latest_ps"

    echo "=> Fetching $fetch_ref..."
    git fetch $remote_url $fetch_ref

    if test $status -ne 0
        echo "Error: git fetch failed."
        return 1
    end

    echo "=> Creating worktree at ../$branch_name..."
    git worktree add -b $branch_name ../$branch_name FETCH_HEAD
end

