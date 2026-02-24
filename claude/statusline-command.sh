#!/bin/sh
# Status line based on oh-my-zsh robbyrussell theme
# Receives JSON input via stdin from Claude Code

input=$(cat)
cwd=$(echo "$input" | jq -r '.cwd')

# Get the basename of the current directory (equivalent to %c / \W)
dir=$(basename "$cwd")

# Get git branch info (skip optional locks to avoid blocking)
git_branch=$(git --git-dir="$cwd/.git" --work-tree="$cwd" -c core.fsmonitor= symbolic-ref --short HEAD 2>/dev/null)
if [ -z "$git_branch" ]; then
  git_branch=$(git -C "$cwd" -c core.fsmonitor= symbolic-ref --short HEAD 2>/dev/null)
fi

# Check if git working tree is dirty
if [ -n "$git_branch" ]; then
  if git -C "$cwd" -c core.fsmonitor= diff --quiet --ignore-submodules HEAD 2>/dev/null; then
    git_info=$(printf "\033[1;34mgit:(\033[0;31m%s\033[1;34m)" "$git_branch")
  else
    git_info=$(printf "\033[1;34mgit:(\033[0;31m%s\033[1;34m) \033[0;33m✗" "$git_branch")
  fi
fi

# Build the prompt line
if [ -n "$git_branch" ]; then
  printf "\033[0;36m%s\033[0m %s\033[0m" "$dir" "$git_info"
else
  printf "\033[0;36m%s\033[0m" "$dir"
fi
