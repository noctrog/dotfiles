# Shared shell aliases and interactive helper functions.

# Fetch a GitHub pull request, create a worktree for it, and enter it.
wt-pr() {
    if [ "$#" -ne 1 ] || [ -z "$1" ]; then
        printf 'Usage: wt-pr <pr-number>\n' >&2
        return 2
    fi

    pr_number="$1"

    git fetch origin "pull/$pr_number/head:pr/$pr_number" &&
        worktree create "pr-$pr_number" "pr/$pr_number" &&
        worktree jump "pr-$pr_number"
}
