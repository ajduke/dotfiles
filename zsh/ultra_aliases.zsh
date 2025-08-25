# Ultra-Short Aliases (1-2 characters)
# Modern Dotfiles 2024 - VP Engineering Setup

# ==========================================
# NAVIGATION & FILE OPERATIONS (j, l, c, f)
# ==========================================
alias j='zoxide'              # Smart cd (replaces z)
alias l='exa --icons --git'   # Modern ls
alias ll='exa -la --icons --git --header'  # Detailed list
alias c='bat'                  # Better cat
alias f='fd'                   # Better find
alias tr='tree'                # Directory tree (using exa --tree)

# ==========================================
# SEARCH & TEXT PROCESSING (g, h, z)
# ==========================================
alias g='ripgrep'             # Better grep
alias h='atuin search'        # Search shell history
alias z='fzf'                 # Fuzzy finder

# ==========================================
# GIT WORKFLOWS (ultra-short)
# ==========================================
alias gs='git status'         # Git status
alias ga='git add -A'         # Git add all
alias gc='git commit -m'      # Git commit with message
alias gp='git push'           # Git push
alias gl='git pull'           # Git pull

# Enhanced git workflows (addressing your pain points)
alias go='git checkout'       # Git checkout
alias gb='git branch'         # Git branch
alias gn='git checkout -b'    # New branch
alias gm='gitmoji -c'         # Gitmoji commit

# Your requested workflows
alias gx='git add -A && git commit -m'        # Commit (no push)
alias gs='git add -A && git commit -m "$1" && git push'  # Send (commit + push, no PR)
alias gk='git add -A && git commit -m "$1" && git push && gh pr create --web'  # Ship (commit + push + PR)

# ==========================================
# WORKTREE MANAGEMENT (w commands)
# ==========================================
alias wn='git worktree add'   # New worktree
alias wl='git worktree list'  # List worktrees  
alias wr='git worktree remove' # Remove worktree
alias wp='git worktree prune' # Prune worktrees

# ==========================================
# DEVELOPMENT SHORTCUTS (d commands)
# ==========================================
alias ds='dev-start'          # Start development server (your request)
alias dp='dev-ports'          # Show development ports
alias dt='dev-test'           # Run tests
alias db='dev-build'          # Build project
alias dl='dev-logs'           # Show logs

# ==========================================
# PACKAGE MANAGEMENT (n, b, p commands)  
# ==========================================
alias ni='npm install'       # NPM install
alias nr='npm run'            # NPM run
alias ns='npm start'          # NPM start
alias nt='npm test'           # NPM test
alias nb='npm run build'     # NPM build

alias bi='bun install'       # Bun install (faster)
alias br='bun run'           # Bun run
alias bs='bun start'         # Bun start

# ==========================================
# DATABASE SHORTCUTS (pg, sq, mg)
# ==========================================
alias pg='pgcli'             # PostgreSQL CLI
alias sq='sqlite3'           # SQLite CLI  
alias mg='mongosh'           # MongoDB shell

# Quick database connections
alias pgL='pgcli postgresql://localhost:5432'  # Local postgres
alias sqL='sqlite3'          # Local sqlite
alias mgL='mongosh mongodb://localhost:27017'  # Local mongo

# ==========================================
# CONTAINER MANAGEMENT (p commands - Podman)
# ==========================================
alias p='podman'             # Podman (Docker alternative)
alias pc='podman-compose'    # Podman compose
alias pl='podman ps'         # List containers
alias pi='podman images'     # List images
alias pr='podman run'        # Run container

# ==========================================
# AI TOOLS (ai, ar, an)
# ==========================================
alias ai='aichat'            # AI chat CLI
alias ar='ai-review'         # AI code review (Gemini CLI)
alias an='ai-note'           # AI note taking

# ==========================================
# NOTE TAKING (n commands)
# ==========================================
alias n='note'               # Quick note
alias nm='note-meeting'      # Meeting note
alias nd='note-decision'     # Decision note
alias ni='note-idea'         # Idea note
alias ns='note-sync'         # Sync notes to Notion

# ==========================================
# DEPLOYMENT (v, r commands)
# ==========================================
alias v='vercel'             # Vercel CLI
alias vd='vercel --prod'     # Deploy to production
alias vl='vercel logs'       # Vercel logs

alias r='railway'            # Railway CLI
alias rd='railway up'        # Railway deploy
alias rl='railway logs'      # Railway logs

# ==========================================
# SYSTEM MONITORING (bt, ht, du)
# ==========================================
alias bt='btop'              # Modern system monitor
alias ht='htop'              # Process monitor  
alias du='ncdu'              # Disk usage analyzer

# ==========================================
# QUICK UTILITIES (md, jq, yq, tl)
# ==========================================
alias md='glow'              # Markdown viewer
alias jq='jq'                # JSON processor
alias yq='yq'                # YAML processor
alias tl='tldr'              # Better man pages

# ==========================================
# TERMINAL ENHANCEMENTS
# ==========================================
alias cl='clear'             # Clear terminal
alias e='exit'               # Exit terminal
alias rr='source ~/.zshrc'   # Reload zsh config
alias lg='lazygit'           # Git TUI

# ==========================================
# PROJECT CONTEXT (ctx commands)
# ==========================================
alias ctx='project-context'  # Switch project context
alias ctxl='project-list'    # List available contexts
alias ctxs='project-status'  # Show current project status
