parse_git_branch () {
    branch=$(git branch --show-current 2>/dev/null)
    if [ -n "$branch" ]; then
        echo -n -e "[branch: $branch]"
    fi
}

PROMPT="%B%F{043}%n%f %F{038}/%2~%f %F{229}$(parse_git_branch) %f%#%b "
