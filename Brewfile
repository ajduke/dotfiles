# Modern Dotfiles Brewfile
# VP Engineering - Development Environment
# Node/Python managed by mise (not brew)

# Taps
tap "homebrew/bundle"
tap "homebrew/cask"
tap "homebrew/cask-fonts"
tap "jesseduffield/lazygit"
tap "charmbracelet/tap"

# Version Management (replaces nvm/pyenv)
brew "mise"                   # Universal version manager

# Modern Shell & Prompt
brew "starship"               # Modern shell prompt
brew "zsh-autosuggestions"    # Command suggestions
brew "zsh-syntax-highlighting" # Syntax highlighting

# Essential CLI Replacements
brew "exa"                    # Modern ls → alias: l, ll
brew "bat"                    # Better cat → alias: c
brew "ripgrep"                # Better grep → alias: g
brew "fd"                     # Better find → alias: f
brew "fzf"                    # Fuzzy finder → alias: z
brew "zoxide"                 # Smart cd → alias: j
brew "atuin"                  # Shell history sync → alias: h

# Git & Version Control
brew "git"
brew "gh"                     # GitHub CLI → alias: gh
brew "lazygit"                # Git TUI → alias: lg
brew "git-delta"              # Better git diff
brew "gitmoji-cli"            # Git commit emojis → alias: gm

# Development Tools
brew "jq"                     # JSON processor → alias: jq
brew "yq"                     # YAML processor → alias: yq
brew "httpie"                 # Better curl → alias: http
brew "tldr"                   # Better man pages → alias: tl
brew "tree"                   # Directory tree → alias: tr

# Database Tools
brew "postgresql"
brew "sqlite"
brew "mongodb/brew/mongodb-community"
brew "pgcli"                  # Better PostgreSQL CLI → alias: pg
brew "sqlite-utils"           # SQLite utilities → alias: sq

# Container Tools (Podman preferred over Docker)
brew "podman"                 # Docker alternative → alias: p
brew "podman-compose"         # Docker-compose for podman → alias: pc

# Productivity Tools
brew "glow"                   # Markdown viewer → alias: md
brew "charm"                  # Note-taking CLI → alias: n

# System Monitoring
brew "htop"                   # Process monitor → alias: ht
brew "btop"                   # Modern system monitor → alias: bt
brew "ncdu"                   # Disk usage → alias: du

# AI Tools
brew "aichat"                 # AI CLI tool → alias: ai

# Applications
cask "cursor"                 # Primary editor
cask "webstorm"               # Secondary IDE  
cask "iterm2"                 # Terminal
cask "raycast"                # Spotlight replacement
cask "tableplus"              # Database client

# Fonts
cask "font-fira-code-nerd-font"
cask "font-jetbrains-mono-nerd-font"

# Deployment Tools
brew "vercel-cli"             # Vercel → alias: v
brew "railway"                # Railway → alias: r
