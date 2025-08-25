# AI Functions - Modern Dotfiles 2024
# Gemini CLI integration for code review and AI assistance

# ==========================================
# GEMINI CLI SETUP & CONFIGURATION
# ==========================================

# Check if Gemini CLI is installed and configured
check-gemini() {
    if ! command -v gemini > /dev/null 2>&1; then
        echo "❌ Gemini CLI not found"
        echo "💡 Install with: npm install -g @google-ai/generativelanguage"
        echo "💡 Or: pip install google-generativeai"
        return 1
    fi
    
    if [[ -z "$GEMINI_API_KEY" ]]; then
        echo "❌ GEMINI_API_KEY not set"
        echo "💡 Get your API key from: https://makersuite.google.com/app/apikey"
        echo "💡 Add to your .zshrc: export GEMINI_API_KEY='your-key-here'"
        return 1
    fi
    
    echo "✅ Gemini CLI configured"
    return 0
}

# ==========================================
# AI CODE REVIEW (ar = ai-review)
# ==========================================

ai-review() {
    local target=${1:-.}
    local review_type=${2:-"comprehensive"}
    
    if ! check-gemini; then
        return 1
    fi
    
    echo "🤖 Starting AI code review with Gemini..."
    echo "📂 Target: $target"
    echo "🔍 Review type: $review_type"
    echo ""
    
    # Prepare review prompt based on type
    local prompt=""
    case $review_type in
        "security"|"sec"|"s")
            prompt="Perform a security-focused code review. Look for vulnerabilities, security anti-patterns, exposed secrets, and potential attack vectors."
            ;;
        "performance"|"perf"|"p")
            prompt="Perform a performance-focused code review. Identify bottlenecks, inefficient algorithms, memory leaks, and optimization opportunities."
            ;;
        "best-practices"|"bp"|"b")
            prompt="Review code for best practices, clean code principles, maintainability, and adherence to coding standards."
            ;;
        "architecture"|"arch"|"a")
            prompt="Review the code architecture, design patterns, separation of concerns, and overall system design."
            ;;
        *)
            prompt="Perform a comprehensive code review covering security, performance, best practices, and architecture."
            ;;
    esac
    
    # Add context about your tech stack
    prompt+=" The codebase uses Node.js, Express, Python, Next.js, React, Tailwind CSS, and PostgreSQL/SQLite. Focus on patterns and issues relevant to this tech stack."
    
    # Handle different target types
    if [[ -f "$target" ]]; then
        # Single file review
        echo "📄 Reviewing file: $target"
        _review_file "$target" "$prompt"
    elif [[ -d "$target" ]]; then
        # Directory review
        echo "📁 Reviewing directory: $target"
        _review_directory "$target" "$prompt"
    else
        echo "❌ Target not found: $target"
        return 1
    fi
}

# Review a single file
_review_file() {
    local file=$1
    local prompt=$2
    
    # Get file extension for context
    local ext="${file##*.}"
    local language=""
    
    case $ext in
        "js"|"jsx"|"ts"|"tsx") language="JavaScript/TypeScript" ;;
        "py") language="Python" ;;
        "json") language="JSON configuration" ;;
        "sql") language="SQL" ;;
        "md") language="Markdown documentation" ;;
        *) language="code" ;;
    esac
    
    # Create temp file with review request
    local temp_file=$(mktemp)
    cat > "$temp_file" << EOF
$prompt

Please review this $language file:

File: $file
\`\`\`$ext
$(cat "$file")
\`\`\`

Provide specific, actionable feedback with:
1. Security concerns (if any)
2. Performance improvements
3. Code quality suggestions
4. Best practice recommendations

Focus on the most important issues first.
EOF
    
    # Call Gemini CLI
    if command -v gemini > /dev/null 2>&1; then
        gemini -f "$temp_file"
    else
        # Fallback to curl if gemini CLI not available
        _gemini_api_call "$temp_file"
    fi
    
    rm "$temp_file"
}

# Review a directory (focus on key files)
_review_directory() {
    local dir=$1
    local prompt=$2
    
    echo "🔍 Scanning directory for reviewable files..."
    
    # Find important files to review
    local files=($(find "$dir" -type f \( -name "*.js" -o -name "*.jsx" -o -name "*.ts" -o -name "*.tsx" -o -name "*.py" \) | head -10))
    
    if [[ ${#files[@]} -eq 0 ]]; then
        echo "❌ No reviewable files found in $dir"
        return 1
    fi
    
    echo "📋 Found ${#files[@]} files to review"
    
    for file in "${files[@]}"; do
        echo ""
        echo "🔍 Reviewing: $file"
        echo "=================================="
        _review_file "$file" "$prompt"
        echo ""
    done
}

# Fallback API call using curl
_gemini_api_call() {
    local prompt_file=$1
    local prompt_content=$(cat "$prompt_file")
    
    curl -s -X POST \
        "https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=$GEMINI_API_KEY" \
        -H "Content-Type: application/json" \
        -d "{
            \"contents\": [{
                \"parts\": [{
                    \"text\": \"$prompt_content\"
                }]
            }]
        }" | jq -r '.candidates[0].content.parts[0].text' 2>/dev/null || echo "❌ API call failed"
}

# ==========================================
# AI COMMIT MESSAGES (ac = ai-commit)
# ==========================================

ai-commit() {
    local custom_message="$*"
    
    if ! check-gemini; then
        return 1
    fi
    
    # Get git diff
    local diff_output=$(git diff --cached)
    
    if [[ -z "$diff_output" ]]; then
        echo "❌ No staged changes found"
        echo "💡 Stage your changes with: git add ."
        return 1
    fi
    
    echo "🤖 Generating AI commit message..."
    
    # Create prompt for commit message
    local temp_file=$(mktemp)
    cat > "$temp_file" << EOF
Generate a concise, meaningful git commit message for these changes. Follow conventional commit format when appropriate.

Staged changes:
\`\`\`diff
$diff_output
\`\`\`

Requirements:
1. Start with a verb (Add, Fix, Update, Remove, etc.)
2. Be specific about what changed
3. Keep under 72 characters for the title
4. Use imperative mood
5. Don't end with period

${custom_message:+Additional context: $custom_message}

Respond with ONLY the commit message, no explanation.
EOF
    
    local commit_msg=""
    if command -v gemini > /dev/null 2>&1; then
        commit_msg=$(gemini -f "$temp_file" | head -1)
    else
        commit_msg=$(_gemini_api_call "$temp_file" | head -1)
    fi
    
    rm "$temp_file"
    
    if [[ -n "$commit_msg" ]]; then
        echo "💡 Suggested commit message:"
        echo "   $commit_msg"
        echo ""
        read -p "🤔 Use this message? (Y/n): " confirm
        
        if [[ "$confirm" =~ ^[Nn]$ ]]; then
            echo "❌ Commit cancelled"
            return 1
        else
            git commit -m "$commit_msg"
            echo "✅ Committed with AI-generated message"
        fi
    else
        echo "❌ Failed to generate commit message"
        return 1
    fi
}

# ==========================================
# AI DOCUMENTATION (ad = ai-docs)
# ==========================================

ai-docs() {
    local target=${1:-"README.md"}
    local doc_type=${2:-"readme"}
    
    if ! check-gemini; then
        return 1
    fi
    
    echo "📝 Generating AI documentation..."
    
    case $doc_type in
        "readme"|"r")
            _generate_readme "$target"
            ;;
        "api"|"a")
            _generate_api_docs "$target"
            ;;
        "changelog"|"c")
            _generate_changelog "$target"
            ;;
        *)
            echo "❌ Unknown documentation type: $doc_type"
            echo "💡 Available types: readme (r), api (a), changelog (c)"
            return 1
            ;;
    esac
}

_generate_readme() {
    local readme_file=$1
    
    # Analyze project structure
    local project_info=""
    if [[ -f "package.json" ]]; then
        project_info+="Package.json: $(cat package.json | jq -r '.name + " - " + .description')\n"
        project_info+="Dependencies: $(cat package.json | jq -r '.dependencies | keys | join(", ")')\n"
    fi
    
    if [[ -f "requirements.txt" ]]; then
        project_info+="Python requirements: $(head -5 requirements.txt | tr '\n' ', ')\n"
    fi
    
    local temp_file=$(mktemp)
    cat > "$temp_file" << EOF
Generate a comprehensive README.md for this project based on the codebase analysis.

Project Information:
$project_info

Project Structure:
$(find . -maxdepth 2 -type f -name "*.js" -o -name "*.py" -o -name "*.ts" -o -name "*.json" | head -10)

Include sections for:
1. Project Title and Description
2. Features
3. Prerequisites
4. Installation
5. Usage
6. API Documentation (if applicable)
7. Contributing
8. License

Make it professional and comprehensive for a VP of Engineering's project.
EOF
    
    local content=""
    if command -v gemini > /dev/null 2>&1; then
        content=$(gemini -f "$temp_file")
    else
        content=$(_gemini_api_call "$temp_file")
    fi
    
    if [[ -n "$content" ]]; then
        echo "$content" > "$readme_file"
        echo "✅ Generated README.md"
        echo "💡 Review and edit: cursor $readme_file"
    else
        echo "❌ Failed to generate README"
    fi
    
    rm "$temp_file"
}

# ==========================================
# AI CHAT (ai = ai-chat)
# ==========================================

ai-chat() {
    local question="$*"
    
    if ! check-gemini; then
        return 1
    fi
    
    if [[ -z "$question" ]]; then
        echo "❌ Question required"
        echo "Usage: ai-chat <your question>"
        echo "Example: ai-chat 'How do I optimize this React component?'"
        return 1
    fi
    
    echo "🤖 Asking Gemini: $question"
    echo ""
    
    # Add context about current project
    local context=""
    if [[ -f "package.json" ]]; then
        context+="Current project context: $(cat package.json | jq -r '.name // "Unknown"') - $(cat package.json | jq -r '.description // "No description"')\n"
    fi
    
    local temp_file=$(mktemp)
    cat > "$temp_file" << EOF
$context

Question: $question

Provide a helpful, technical answer suitable for a VP of Engineering who codes. Be specific and actionable.
EOF
    
    if command -v gemini > /dev/null 2>&1; then
        gemini -f "$temp_file"
    else
        _gemini_api_call "$temp_file"
    fi
    
    rm "$temp_file"
}

# ==========================================
# ALIASES FOR AI FUNCTIONS
# ==========================================
alias ar=ai-review           # AI code review
alias ac=ai-commit           # AI commit message
alias ad=ai-docs             # AI documentation
alias ai=ai-chat             # AI chat
alias aic=check-gemini       # Check AI configuration
