#!/bin/bash
# Modern Dotfiles Setup Script - VP Engineering Edition 2024
# Ultra-productive development environment with AI integration

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# ==========================================
# HELPER FUNCTIONS
# ==========================================

print_header() {
    echo -e "${PURPLE}🚀 $1${NC}"
    echo "=================================="
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

check_command() {
    if command -v "$1" > /dev/null 2>&1; then
        return 0
    else
        return 1
    fi
}

# ==========================================
# MAIN SETUP FUNCTIONS
# ==========================================

check_requirements() {
    print_header "Checking Requirements"
    
    # Check if we're on macOS
    if [[ "$OSTYPE" != "darwin"* ]]; then
        print_error "This setup is designed for macOS"
        exit 1
    fi
    
    # Check if Homebrew is installed
    if ! check_command brew; then
        print_warning "Homebrew not found. Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        
        # Add Homebrew to PATH for current session
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
    
    print_success "Requirements check complete"
}

install_packages() {
    print_header "Installing Modern Development Tools"
    
    # Update Homebrew
    print_info "Updating Homebrew..."
    brew update
    
    # Install packages from Brewfile
    print_info "Installing packages from Brewfile..."
    cd ~/dotfiles
    brew bundle install
    
    print_success "Package installation complete"
}

setup_shell() {
    print_header "Configuring Modern Shell Environment"
    
    # Install oh-my-zsh if not present
    if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
        print_info "Installing oh-my-zsh..."
        sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    fi
    
    # Install zsh plugins
    print_info "Installing zsh plugins..."
    
    # zsh-autosuggestions
    if [[ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" ]]; then
        git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    fi
    
    # zsh-syntax-highlighting
    if [[ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting" ]]; then
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    fi
    
    print_success "Shell configuration complete"
}

setup_version_managers() {
    print_header "Setting Up Version Managers"
    
    # Configure mise
    print_info "Configuring mise for Node.js and Python..."
    
    # Install latest LTS Node.js
    mise install node@lts
    mise use -g node@lts
    
    # Install Python 3.11 and 3.12
    mise install python@3.11 python@3.12
    mise use -g python@3.11
    
    print_success "Version managers configured"
}

setup_git() {
    print_header "Configuring Modern Git Environment"
    
    # Backup existing git config
    if [[ -f "$HOME/.gitconfig" ]]; then
        print_info "Backing up existing .gitconfig..."
        cp "$HOME/.gitconfig" "$HOME/.gitconfig.backup.$(date +%Y%m%d_%H%M%S)"
    fi
    
    # Link modern git config
    ln -sf "$HOME/dotfiles/git/modern_gitconfig" "$HOME/.gitconfig"
    
    # Install GitHub CLI if not present
    if ! check_command gh; then
        print_info "Installing GitHub CLI..."
        brew install gh
    fi
    
    print_success "Git configuration complete"
}

setup_starship() {
    print_header "Configuring Starship Prompt"
    
    # Create starship config directory
    mkdir -p "$HOME/.config"
    
    # Link starship configuration
    ln -sf "$HOME/dotfiles/starship/starship.toml" "$HOME/.config/starship.toml"
    
    print_success "Starship prompt configured"
}

setup_dotfiles() {
    print_header "Setting Up Dotfiles Symlinks"
    
    # Create backup directory
    backup_dir="$HOME/.dotfiles_backup_$(date +%Y%m%d_%H%M%S)"
    mkdir -p "$backup_dir"
    
    # Backup and link zshrc
    if [[ -f "$HOME/.zshrc" ]]; then
        mv "$HOME/.zshrc" "$backup_dir/.zshrc"
    fi
    ln -sf "$HOME/dotfiles/zsh/modern_zshrc" "$HOME/.zshrc"
    
    # Link other dotfiles
    declare -a files_to_link=(
        "tmux/tmux.conf .tmux.conf"
        "node/npmrc .npmrc"
    )
    
    for entry in "${files_to_link[@]}"; do
        read -r source dest <<< "$entry"
        source_path="$HOME/dotfiles/$source"
        dest_path="$HOME/$dest"
        
        if [[ -f "$dest_path" ]] || [[ -h "$dest_path" ]]; then
            mv "$dest_path" "$backup_dir/"
        fi
        
        ln -sf "$source_path" "$dest_path"
        print_info "Linked $source -> $dest"
    done
    
    print_success "Dotfiles symlinks created (backup: $backup_dir)"
}

setup_notes_system() {
    print_header "Initializing Notes System"
    
    # Create notes directory structure
    mkdir -p "$HOME/notes"/{daily,meetings,decisions,ideas,projects,templates}
    
    print_info "Notes system initialized at $HOME/notes"
    print_info "Configure Notion integration by setting NOTION_API_KEY and NOTION_DATABASE_ID"
    
    print_success "Notes system ready"
}

setup_ai_tools() {
    print_header "Setting Up AI Tools Integration"
    
    # Install aichat if not present
    if ! check_command aichat; then
        print_info "Installing aichat..."
        brew install aichat
    fi
    
    print_info "AI tools configured"
    print_warning "Set GEMINI_API_KEY in your ~/.zsh_secrets file for AI features"
    
    print_success "AI tools integration ready"
}

final_setup() {
    print_header "Final Configuration"
    
    # Create secrets file template
    if [[ ! -f "$HOME/.zsh_secrets" ]]; then
        cat > "$HOME/.zsh_secrets" << 'EOF'
# AI Configuration
# export GEMINI_API_KEY="your-gemini-api-key"

# Notion Integration
# export NOTION_API_KEY="your-notion-api-key"
# export NOTION_DATABASE_ID="your-notion-database-id"

# Work-specific environment variables
# export WORK_VAR="value"
EOF
        print_info "Created ~/.zsh_secrets template"
    fi
    
    # Set up FZF
    if check_command fzf && [[ ! -f "$HOME/.fzf.zsh" ]]; then
        print_info "Setting up FZF..."
        $(brew --prefix)/opt/fzf/install --all
    fi
    
    print_success "Final configuration complete"
}

show_next_steps() {
    print_header "🎉 Modern Dotfiles Installation Complete!"
    
    echo -e "${GREEN}Next Steps:${NC}"
    echo "1. Restart your terminal or run: source ~/.zshrc"
    echo "2. Set up API keys in ~/.zsh_secrets:"
    echo "   - GEMINI_API_KEY for AI code review"
    echo "   - NOTION_API_KEY for notes integration"
    echo "3. Run 'gh auth login' to authenticate GitHub CLI"
    echo ""
    echo -e "${CYAN}Ultra-Short Commands Available:${NC}"
    echo "• ds        - Start development server (auto-port)"
    echo "• ar        - AI code review with Gemini"
    echo "• n         - Quick note taking"
    echo "• wn        - Create new git worktree"
    echo "• send      - Git commit + push (no PR)"
    echo "• ship      - Git commit + push + create PR"
    echo "• sync      - Git fetch + rebase + cleanup"
    echo ""
    echo -e "${PURPLE}Development Workflow:${NC}"
    echo "• Use 'wn feature-name' for new features in monorepo"
    echo "• Use 'ar src/' for AI code reviews"
    echo "• Use 'nm \"meeting title\"' for structured meeting notes"
    echo "• Use 'nd \"decision title\"' for architecture decisions"
    echo ""
    echo -e "${YELLOW}VP-Specific Features:${NC}"
    echo "• team     - Team activity overview"
    echo "• standup  - Your commits since yesterday"
    echo "• ctx      - Project context management"
    echo ""
    print_success "Welcome to your modern development environment! 🚀"
}

# ==========================================
# MAIN EXECUTION
# ==========================================

main() {
    clear
    echo -e "${PURPLE}"
    echo "╔══════════════════════════════════════════════════════╗"
    echo "║           Modern Dotfiles Setup - VP Edition        ║"
    echo "║                                                      ║"
    echo "║  Ultra-productive development environment with       ║"
    echo "║  AI integration, worktree management, and more!     ║"
    echo "╚══════════════════════════════════════════════════════╝"
    echo -e "${NC}"
    echo ""
    
    # Confirm before proceeding
    read -p "Continue with modern dotfiles installation? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        print_info "Installation cancelled"
        exit 0
    fi
    
    # Run setup functions
    check_requirements
    install_packages
    setup_shell
    setup_version_managers
    setup_git
    setup_starship
    setup_dotfiles
    setup_notes_system
    setup_ai_tools
    final_setup
    show_next_steps
}

# Run the main function
main "$@"
