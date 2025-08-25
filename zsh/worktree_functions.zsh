# Git Worktree Management - Modern Dotfiles 2024
# Ultra-short commands for monorepo management

# ==========================================
# WORKTREE MANAGEMENT (w commands)
# ==========================================

# Create new worktree with branch (wn command)
wt-new() {
    local branch_name=$1
    local base_branch=${2:-"main"}
    local project_suffix=${3:-""}
    
    if [[ -z "$branch_name" ]]; then
        echo "❌ Branch name required"
        echo "Usage: wt-new <branch-name> [base-branch] [project-suffix]"
        echo "Example: wt-new feature/auth main frontend"
        return 1
    fi
    
    # Get current repository name
    local repo_name=$(basename "$(git rev-parse --show-toplevel)")
    
    # Create worktree directory name
    local worktree_name="$repo_name-$branch_name"
    if [[ -n "$project_suffix" ]]; then
        worktree_name="$repo_name-$project_suffix-$branch_name"
    fi
    
    # Create worktree in parent directory
    local worktree_path="../$worktree_name"
    
    echo "🌳 Creating worktree: $worktree_path"
    echo "📦 Branch: $branch_name (from $base_branch)"
    
    # Create worktree
    if git worktree add "$worktree_path" -b "$branch_name" "$base_branch"; then
        echo "✅ Worktree created successfully"
        echo "📂 Path: $(realpath "$worktree_path")"
        
        # Switch to new worktree
        cd "$worktree_path"
        
        # Set up mise for version management if .mise.toml exists in main
        if [[ -f "../$repo_name/.mise.toml" ]]; then
            cp "../$repo_name/.mise.toml" .
            mise install
            echo "🔧 Copied mise configuration"
        fi
        
        # Show status
        echo "🎯 Current location: $(pwd)"
        echo "💡 Use 'wt-list' to see all worktrees"
        
        return 0
    else
        echo "❌ Failed to create worktree"
        return 1
    fi
}

# List all worktrees (wl command)
wt-list() {
    echo "🌳 Git Worktrees:"
    echo "================="
    
    local current_path=$(pwd)
    
    git worktree list --porcelain | while IFS= read -r line; do
        if [[ $line =~ ^worktree ]]; then
            local path=${line#worktree }
            local is_current=""
            
            # Check if this is the current worktree
            if [[ "$(realpath "$path")" == "$(realpath "$current_path")" ]]; then
                is_current=" 👈 CURRENT"
            fi
            
            echo "📂 $path$is_current"
        elif [[ $line =~ ^branch ]]; then
            local branch=${line#branch refs/heads/}
            echo "   └── 🌿 $branch"
        elif [[ $line =~ ^HEAD ]]; then
            local commit=${line#HEAD }
            echo "   └── 🔗 $commit"
        fi
        
        # Add empty line between worktrees
        if [[ $line == "" ]]; then
            echo ""
        fi
    done
}

# Switch to worktree (ws command)
wt-switch() {
    local target=$1
    
    if [[ -z "$target" ]]; then
        echo "❌ Target required"
        echo "Usage: wt-switch <branch-name|path|number>"
        echo ""
        wt-list
        return 1
    fi
    
    # Get list of worktrees
    local worktrees=($(git worktree list --porcelain | grep "^worktree" | cut -d' ' -f2))
    local branches=($(git worktree list --porcelain | grep "^branch" | cut -d'/' -f3))
    
    local target_path=""
    
    # Check if target is a number (index)
    if [[ "$target" =~ ^[0-9]+$ ]]; then
        if [[ $target -lt ${#worktrees[@]} ]]; then
            target_path="${worktrees[$target]}"
        else
            echo "❌ Invalid worktree index: $target"
            wt-list
            return 1
        fi
    else
        # Check if target is a branch name
        for i in "${!branches[@]}"; do
            if [[ "${branches[$i]}" == "$target" ]]; then
                target_path="${worktrees[$i]}"
                break
            fi
        done
        
        # Check if target is a path
        if [[ -z "$target_path" ]] && [[ -d "$target" ]]; then
            target_path="$target"
        fi
    fi
    
    if [[ -n "$target_path" ]] && [[ -d "$target_path" ]]; then
        echo "🔄 Switching to worktree: $target_path"
        cd "$target_path"
        echo "✅ Current location: $(pwd)"
        
        # Load project-specific environment if available
        if [[ -f ".envrc" ]] && command -v direnv > /dev/null; then
            direnv allow
        fi
        
        # Show git status
        git status --short
    else
        echo "❌ Worktree not found: $target"
        wt-list
        return 1
    fi
}

# Remove worktree (wr command)
wt-remove() {
    local target=$1
    local force=${2:-false}
    
    if [[ -z "$target" ]]; then
        echo "❌ Target required"
        echo "Usage: wt-remove <branch-name|path> [force]"
        wt-list
        return 1
    fi
    
    # Find worktree path
    local target_path=""
    if [[ -d "$target" ]]; then
        target_path="$target"
    else
        # Find by branch name
        target_path=$(git worktree list --porcelain | grep -B1 "branch.*$target" | grep "^worktree" | cut -d' ' -f2)
    fi
    
    if [[ -z "$target_path" ]]; then
        echo "❌ Worktree not found: $target"
        return 1
    fi
    
    echo "🗑️  Removing worktree: $target_path"
    
    # Check if worktree has uncommitted changes
    if [[ "$force" != "true" ]]; then
        cd "$target_path"
        if ! git diff --quiet || ! git diff --cached --quiet; then
            echo "⚠️  Worktree has uncommitted changes!"
            echo "💡 Use 'wt-remove $target true' to force removal"
            return 1
        fi
    fi
    
    # Remove worktree
    if git worktree remove "$target_path" ${force:+--force}; then
        echo "✅ Worktree removed successfully"
        
        # Remove directory if it still exists
        if [[ -d "$target_path" ]]; then
            rm -rf "$target_path"
            echo "🧹 Cleaned up directory"
        fi
    else
        echo "❌ Failed to remove worktree"
        return 1
    fi
}

# Clean up merged worktrees (wc command)
wt-clean() {
    local dry_run=${1:-false}
    
    echo "🧹 Cleaning up merged worktrees..."
    
    # Get merged branches
    local merged_branches=($(git branch --merged main | grep -v "main\|master" | tr -d ' '))
    
    if [[ ${#merged_branches[@]} -eq 0 ]]; then
        echo "✅ No merged branches found"
        return 0
    fi
    
    echo "📋 Found merged branches:"
    for branch in "${merged_branches[@]}"; do
        echo "   - $branch"
    done
    
    if [[ "$dry_run" == "true" ]]; then
        echo "🔍 Dry run completed. Use 'wt-clean false' to actually remove worktrees."
        return 0
    fi
    
    # Confirm before deletion
    echo ""
    read -p "🤔 Remove worktrees for these merged branches? (y/N): " confirm
    
    if [[ "$confirm" =~ ^[Yy]$ ]]; then
        for branch in "${merged_branches[@]}"; do
            wt-remove "$branch" true
        done
        
        # Prune worktrees
        git worktree prune
        echo "✅ Cleanup completed"
    else
        echo "❌ Cleanup cancelled"
    fi
}

# Show worktree status (wst command)  
wt-status() {
    echo "🌳 Worktree Status Report"
    echo "========================"
    echo ""
    
    # Current worktree info
    echo "📍 Current Worktree:"
    echo "   Path: $(pwd)"
    echo "   Branch: $(git branch --show-current)"
    echo "   Status: $(git status --porcelain | wc -l | tr -d ' ') changed files"
    echo ""
    
    # All worktrees summary
    echo "📊 All Worktrees:"
    git worktree list --porcelain | awk '
        /^worktree/ { path = substr($0, 10) }
        /^branch/ { branch = substr($0, 8); gsub(/refs\/heads\//, "", branch) }
        /^$/ { 
            if (path && branch) {
                printf "   %s -> %s\n", branch, path
                path = ""
                branch = ""
            }
        }
    '
    
    echo ""
    echo "💡 Commands: wn (new), wl (list), ws (switch), wr (remove), wc (clean)"
}

# Project context management for monorepos
project-context() {
    local context=${1:-""}
    
    if [[ -z "$context" ]]; then
        # Show current context
        echo "📦 Current Project Context: ${PROJECT_CONTEXT:-"none"}"
        echo "📂 Available contexts:"
        
        # Look for common project directories
        for dir in frontend backend api docs mobile; do
            if [[ -d "$dir" ]]; then
                echo "   - $dir"
            fi
        done
        
        return 0
    fi
    
    # Set context
    export PROJECT_CONTEXT="$context"
    echo "🎯 Project context set to: $context"
    
    # Change to context directory if it exists
    if [[ -d "$context" ]]; then
        cd "$context"
        echo "📂 Changed to directory: $(pwd)"
    fi
    
    # Load context-specific environment
    if [[ -f "$context/.envrc" ]] && command -v direnv > /dev/null; then
        direnv allow "$context/.envrc"
    fi
}

# ==========================================
# ALIASES FOR WORKTREE FUNCTIONS
# ==========================================
alias wn=wt-new              # Create new worktree
alias wl=wt-list             # List worktrees
alias ws=wt-switch           # Switch worktree
alias wr=wt-remove           # Remove worktree  
alias wc=wt-clean            # Clean merged worktrees
alias wst=wt-status          # Worktree status
alias ctx=project-context    # Project context
