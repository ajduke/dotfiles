# Notes System with Notion Integration - Modern Dotfiles 2024
# Ultra-short commands for note-taking and knowledge management

# ==========================================
# NOTES CONFIGURATION
# ==========================================

# Notes directory structure
export NOTES_DIR="$HOME/notes"
export NOTES_DAILY_DIR="$NOTES_DIR/daily"
export NOTES_MEETINGS_DIR="$NOTES_DIR/meetings"
export NOTES_DECISIONS_DIR="$NOTES_DIR/decisions"
export NOTES_IDEAS_DIR="$NOTES_DIR/ideas"
export NOTES_PROJECTS_DIR="$NOTES_DIR/projects"

# Notion integration (set these in your .zshrc)
# export NOTION_API_KEY="your-notion-integration-key"
# export NOTION_DATABASE_ID="your-database-id"

# Initialize notes directory structure
init-notes() {
    echo "📝 Initializing notes system..."
    
    mkdir -p "$NOTES_DAILY_DIR"
    mkdir -p "$NOTES_MEETINGS_DIR"
    mkdir -p "$NOTES_DECISIONS_DIR"
    mkdir -p "$NOTES_IDEAS_DIR"
    mkdir -p "$NOTES_PROJECTS_DIR"
    
    # Create templates directory
    mkdir -p "$NOTES_DIR/templates"
    
    # Create default templates
    _create_templates
    
    echo "✅ Notes system initialized at $NOTES_DIR"
}

# Create note templates
_create_templates() {
    # Meeting template
    cat > "$NOTES_DIR/templates/meeting.md" << 'EOF'
# Meeting: {{TITLE}}

**Date:** {{DATE}}
**Time:** {{TIME}}
**Attendees:** 
- 

## Agenda
- 

## Discussion
- 

## Action Items
- [ ] 
- [ ] 

## Next Steps
- 

---
**Tags:** #meeting #{{PROJECT}}
EOF

    # Decision template
    cat > "$NOTES_DIR/templates/decision.md" << 'EOF'
# Decision: {{TITLE}}

**Date:** {{DATE}}
**Status:** [Proposed/Accepted/Rejected/Superseded]
**Decision Maker:** 

## Context
What is the issue that we're seeing that is motivating this decision or change?

## Decision
What is the change that we're proposing or have agreed to implement?

## Consequences
What becomes easier or more difficult to do and any risks introduced by this change?

## Alternatives Considered
- 
- 

---
**Tags:** #decision #architecture #{{PROJECT}}
EOF

    # Daily note template
    cat > "$NOTES_DIR/templates/daily.md" << 'EOF'
# Daily Notes - {{DATE}}

## 🎯 Today's Goals
- [ ] 
- [ ] 
- [ ] 

## 📝 Notes
- 

## 💡 Ideas
- 

## 🚀 Wins
- 

## 🔄 For Tomorrow
- 

---
**Tags:** #daily
EOF

    # Project template
    cat > "$NOTES_DIR/templates/project.md" << 'EOF'
# Project: {{TITLE}}

**Status:** [Planning/In Progress/On Hold/Completed]
**Start Date:** {{DATE}}
**Owner:** 
**Stakeholders:** 

## Objective
What are we trying to achieve?

## Key Results
- 
- 
- 

## Resources
- **Repository:** 
- **Documentation:** 
- **Slack Channel:** 

## Timeline
| Phase | Description | Due Date | Status |
|-------|-------------|----------|--------|
|       |             |          |        |

## Notes
- 

---
**Tags:** #project #{{PROJECT}}
EOF
}

# ==========================================
# QUICK NOTE FUNCTIONS (n commands)
# ==========================================

# General note function (n command)
note() {
    local note_text="$*"
    local note_file="$NOTES_DAILY_DIR/$(date +%Y-%m-%d).md"
    
    # Create daily note if it doesn't exist
    if [[ ! -f "$note_file" ]]; then
        _create_daily_note "$note_file"
    fi
    
    if [[ -z "$note_text" ]]; then
        # Open daily note in editor
        cursor "$note_file"
    else
        # Append quick note
        echo "" >> "$note_file"
        echo "## $(date '+%H:%M') - Quick Note" >> "$note_file"
        echo "$note_text" >> "$note_file"
        echo "✅ Note added to $(basename "$note_file")"
        
        # Sync to Notion if configured
        _sync_to_notion "$note_file" "daily"
    fi
}

# Meeting note (nm command)
note-meeting() {
    local meeting_title="$1"
    local date=$(date +%Y-%m-%d)
    local time=$(date +%H%M)
    
    if [[ -z "$meeting_title" ]]; then
        echo "❌ Meeting title required"
        echo "Usage: note-meeting 'Architecture Review'"
        return 1
    fi
    
    local filename="$NOTES_MEETINGS_DIR/${date}-${meeting_title// /-}.md"
    
    # Create meeting note from template
    sed "s/{{TITLE}}/$meeting_title/g; s/{{DATE}}/$date/g; s/{{TIME}}/$time/g; s/{{PROJECT}}/${PROJECT_CONTEXT:-general}/g" \
        "$NOTES_DIR/templates/meeting.md" > "$filename"
    
    echo "📅 Created meeting note: $(basename "$filename")"
    cursor "$filename"
    
    # Sync to Notion
    _sync_to_notion "$filename" "meeting"
}

# Decision note (nd command)
note-decision() {
    local decision_title="$1"
    local date=$(date +%Y-%m-%d)
    
    if [[ -z "$decision_title" ]]; then
        echo "❌ Decision title required"
        echo "Usage: note-decision 'Use React Query for API state'"
        return 1
    fi
    
    local filename="$NOTES_DECISIONS_DIR/${date}-${decision_title// /-}.md"
    
    # Create decision note from template
    sed "s/{{TITLE}}/$decision_title/g; s/{{DATE}}/$date/g; s/{{PROJECT}}/${PROJECT_CONTEXT:-general}/g" \
        "$NOTES_DIR/templates/decision.md" > "$filename"
    
    echo "🎯 Created decision note: $(basename "$filename")"
    cursor "$filename"
    
    # Sync to Notion
    _sync_to_notion "$filename" "decision"
}

# Idea note (ni command)
note-idea() {
    local idea_text="$*"
    local timestamp=$(date +%Y-%m-%d_%H%M)
    local filename="$NOTES_IDEAS_DIR/${timestamp}-idea.md"
    
    if [[ -z "$idea_text" ]]; then
        echo "❌ Idea text required"
        echo "Usage: note-idea 'Use AI for automated code reviews'"
        return 1
    fi
    
    cat > "$filename" << EOF
# Idea: $idea_text

**Date:** $(date)
**Project Context:** ${PROJECT_CONTEXT:-general}

## Description
$idea_text

## Why this matters
- 

## Implementation thoughts
- 

## Next steps
- [ ] Research feasibility
- [ ] Create proof of concept
- [ ] Discuss with team

---
**Tags:** #idea #${PROJECT_CONTEXT:-general}
EOF
    
    echo "💡 Created idea note: $(basename "$filename")"
    
    # Sync to Notion
    _sync_to_notion "$filename" "idea"
}

# Project note (np command)
note-project() {
    local project_name="$1"
    local date=$(date +%Y-%m-%d)
    
    if [[ -z "$project_name" ]]; then
        echo "❌ Project name required"
        echo "Usage: note-project 'User Authentication System'"
        return 1
    fi
    
    local filename="$NOTES_PROJECTS_DIR/${project_name// /-}.md"
    
    # Create project note from template
    sed "s/{{TITLE}}/$project_name/g; s/{{DATE}}/$date/g; s/{{PROJECT}}/${project_name// /-}/g" \
        "$NOTES_DIR/templates/project.md" > "$filename"
    
    echo "📦 Created project note: $(basename "$filename")"
    cursor "$filename"
    
    # Sync to Notion
    _sync_to_notion "$filename" "project"
}

# Create daily note from template
_create_daily_note() {
    local note_file=$1
    local date=$(date +%Y-%m-%d)
    
    sed "s/{{DATE}}/$date/g" "$NOTES_DIR/templates/daily.md" > "$note_file"
}

# ==========================================
# NOTION INTEGRATION
# ==========================================

# Check Notion configuration
check-notion() {
    if [[ -z "$NOTION_API_KEY" ]]; then
        echo "❌ NOTION_API_KEY not set"
        echo "💡 Get your integration key from: https://www.notion.so/my-integrations"
        echo "💡 Add to your .zshrc: export NOTION_API_KEY='your-key-here'"
        return 1
    fi
    
    if [[ -z "$NOTION_DATABASE_ID" ]]; then
        echo "❌ NOTION_DATABASE_ID not set"
        echo "💡 Create a database in Notion and get the ID from the URL"
        echo "💡 Add to your .zshrc: export NOTION_DATABASE_ID='your-database-id'"
        return 1
    fi
    
    echo "✅ Notion integration configured"
    return 0
}

# Sync note to Notion
_sync_to_notion() {
    local note_file=$1
    local note_type=$2
    
    if ! check-notion > /dev/null 2>&1; then
        return 0  # Silently skip if not configured
    fi
    
    echo "🔄 Syncing to Notion..."
    
    # Extract title and content
    local title=$(head -1 "$note_file" | sed 's/^# //')
    local content=$(tail -n +2 "$note_file")
    
    # Create Notion page via API
    local notion_response=$(curl -s -X POST \
        "https://api.notion.com/v1/pages" \
        -H "Authorization: Bearer $NOTION_API_KEY" \
        -H "Content-Type: application/json" \
        -H "Notion-Version: 2022-06-28" \
        -d "{
            \"parent\": {
                \"database_id\": \"$NOTION_DATABASE_ID\"
            },
            \"properties\": {
                \"Name\": {
                    \"title\": [{
                        \"text\": {
                            \"content\": \"$title\"
                        }
                    }]
                },
                \"Type\": {
                    \"select\": {
                        \"name\": \"$note_type\"
                    }
                },
                \"Date\": {
                    \"date\": {
                        \"start\": \"$(date +%Y-%m-%d)\"
                    }
                }
            },
            \"children\": [{
                \"object\": \"block\",
                \"type\": \"paragraph\",
                \"paragraph\": {
                    \"rich_text\": [{
                        \"type\": \"text\",
                        \"text\": {
                            \"content\": \"$content\"
                        }
                    }]
                }
            }]
        }")
    
    if echo "$notion_response" | grep -q '"object":"page"'; then
        echo "✅ Synced to Notion"
    else
        echo "⚠️  Notion sync failed (check configuration)"
    fi
}

# Manual sync all notes to Notion
note-sync() {
    local force=${1:-false}
    
    if ! check-notion; then
        return 1
    fi
    
    echo "🔄 Syncing all notes to Notion..."
    
    local synced=0
    
    # Sync recent daily notes
    for note in "$NOTES_DAILY_DIR"/*.md; do
        if [[ -f "$note" ]]; then
            _sync_to_notion "$note" "daily"
            ((synced++))
        fi
    done
    
    # Sync meeting notes
    for note in "$NOTES_MEETINGS_DIR"/*.md; do
        if [[ -f "$note" ]]; then
            _sync_to_notion "$note" "meeting"
            ((synced++))
        fi
    done
    
    # Sync decision notes
    for note in "$NOTES_DECISIONS_DIR"/*.md; do
        if [[ -f "$note" ]]; then
            _sync_to_notion "$note" "decision"
            ((synced++))
        fi
    done
    
    echo "✅ Synced $synced notes to Notion"
}

# ==========================================
# SEARCH & ORGANIZATION
# ==========================================

# Search notes (ns command - note-search)
note-search() {
    local search_term="$1"
    
    if [[ -z "$search_term" ]]; then
        echo "❌ Search term required"
        echo "Usage: note-search 'authentication'"
        return 1
    fi
    
    echo "🔍 Searching notes for: $search_term"
    echo "====================================="
    
    # Search using ripgrep if available, otherwise grep
    if command -v rg > /dev/null 2>&1; then
        rg -i --type md "$search_term" "$NOTES_DIR" --heading --line-number
    else
        grep -r -i -n --include="*.md" "$search_term" "$NOTES_DIR"
    fi
}

# List recent notes (nl command - note-list)
note-list() {
    local days=${1:-7}
    
    echo "📋 Recent notes (last $days days):"
    echo "=================================="
    
    find "$NOTES_DIR" -name "*.md" -mtime -"$days" -type f | \
    sort -r | \
    while read note; do
        local relative_path=${note#$NOTES_DIR/}
        local modified=$(date -r "$note" "+%Y-%m-%d %H:%M")
        echo "  $modified - $relative_path"
    done
}

# Open notes directory (no command)
note-open() {
    echo "📂 Opening notes directory..."
    cursor "$NOTES_DIR"
}

# ==========================================
# ALIASES FOR NOTE FUNCTIONS
# ==========================================
alias n=note                 # Quick note
alias nm=note-meeting        # Meeting note
alias nd=note-decision       # Decision note
alias ni=note-idea           # Idea note
alias np=note-project        # Project note
alias ns=note-search         # Search notes
alias nl=note-list           # List recent notes
alias no=note-open           # Open notes directory
alias nsync=note-sync        # Sync to Notion
alias ncheck=check-notion    # Check Notion config
