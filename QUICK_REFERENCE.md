# ⚡ Quick Reference - Modern Dotfiles

## 🔥 Essential Commands (1-2 chars)

### Development
```bash
ds          # Start dev server (auto-port)
dp          # Show dev ports  
dt          # Run tests
db          # Build project
```

### Git (Pain Point Solved!)
```bash
send "msg"  # Commit + push (no PR)
ship "msg"  # Commit + push + create PR  
sync        # Fetch + rebase + cleanup
```

### Worktree (Monorepo)
```bash
wn name     # New worktree
wl          # List worktrees
ws name     # Switch worktree  
wr name     # Remove worktree
```

### AI Tools
```bash
ar file     # AI code review (Gemini)
ac          # AI commit message
ai "ask"    # AI chat
```

### Notes
```bash
n "text"    # Quick note
nm "title"  # Meeting note
nd "title"  # Decision note
ns "term"   # Search notes
```

### Quick Nav
```bash
j dir       # Smart cd (zoxide)
l           # Better ls (exa)
c file      # Better cat (bat)
g term      # Better grep (ripgrep)
f name      # Better find (fd)
```

## 🎯 Typical Workflows

### New Feature
```bash
wn feature/auth frontend  # New worktree
ds                       # Start dev server
# ... code ...
ar src/                  # AI review
ship "Add authentication" # Ship it!
```

### Daily Standup
```bash
git standup             # Your commits
git team               # Team activity
n "Standup: working on auth feature"
```

### Code Review
```bash
ar src/components/      # AI review
# Fix issues, then:
send "Fix review feedback"
```

---
*VP Engineering Edition - Built for speed* 🚀
