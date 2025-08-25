# Development Functions - Modern Dotfiles 2024
# Ultra-short commands for development workflow

# ==========================================
# SMART PORT MANAGEMENT (ds = dev-start)
# ==========================================

# Find next available port starting from given port
find-available-port() {
    local start_port=${1:-3000}
    local port=$start_port
    local max_attempts=100
    local attempts=0
    
    while [[ $attempts -lt $max_attempts ]]; do
        if ! lsof -i :$port > /dev/null 2>&1; then
            echo $port
            return 0
        fi
        ((port++))
        ((attempts++))
    done
    
    echo "No available ports found in range $start_port-$((start_port + max_attempts))" >&2
    return 1
}

# Smart development server starter (ds command)
dev-start() {
    local port_start=${1:-3000}
    local project_type=""
    
    # Auto-detect project type
    if [[ -f "next.config.js" ]] || [[ -f "next.config.ts" ]] || [[ -f "next.config.mjs" ]]; then
        project_type="nextjs"
    elif [[ -f "package.json" ]] && grep -q "vite" package.json; then
        project_type="vite"
    elif [[ -f "package.json" ]] && grep -q "react-scripts" package.json; then
        project_type="cra"
    elif [[ -f "package.json" ]]; then
        project_type="node"
    else
        project_type="static"
    fi
    
    local available_port=$(find-available-port $port_start)
    
    if [[ $? -eq 0 ]]; then
        echo "🚀 Starting $project_type development server on port $available_port"
        
        case $project_type in
            "nextjs")
                npm run dev -- --port $available_port
                ;;
            "vite")
                npm run dev -- --port $available_port
                ;;
            "cra")
                PORT=$available_port npm start
                ;;
            "node")
                PORT=$available_port npm start
                ;;
            "static")
                echo "📁 Starting static file server..."
                python3 -m http.server $available_port
                ;;
        esac
    else
        echo "❌ Could not find available port"
        return 1
    fi
}

# Show all development ports in use (dp command)
dev-ports() {
    echo "🔍 Development ports currently in use:"
    echo "=====================================

"
    lsof -i -P -n | grep LISTEN | grep -E ':(3[0-9]{3}|4[0-9]{3}|5[0-9]{3}|8[0-9]{3})' | \
    awk '{print $9 " - " $1 " (PID: " $2 ")"}' | \
    sort -t: -k2 -n | \
    while read line; do
        port=$(echo $line | cut -d: -f2 | cut -d' ' -f1)
        process=$(echo $line | cut -d' ' -f3-)
        echo "  Port $port: $process"
    done
}

# Quick test runner (dt command)
dev-test() {
    local test_type=${1:-"all"}
    
    echo "🧪 Running tests: $test_type"
    
    case $test_type in
        "unit"|"u")
            npm run test:unit 2>/dev/null || npm test -- --testPathPattern=unit
            ;;
        "integration"|"i")
            npm run test:integration 2>/dev/null || npm test -- --testPathPattern=integration
            ;;
        "e2e"|"e")
            npm run test:e2e 2>/dev/null || npx playwright test
            ;;
        "watch"|"w")
            npm test -- --watch
            ;;
        *)
            npm test
            ;;
    esac
}

# Quick build (db command)
dev-build() {
    local build_type=${1:-"production"}
    
    echo "🔨 Building project: $build_type"
    
    case $build_type in
        "dev"|"development")
            npm run build:dev 2>/dev/null || npm run build
            ;;
        "staging")
            NODE_ENV=staging npm run build
            ;;
        *)
            npm run build
            ;;
    esac
}

# Development logs (dl command)
dev-logs() {
    local service=${1:-"app"}
    
    case $service in
        "vercel"|"v")
            vercel logs
            ;;
        "railway"|"r")
            railway logs
            ;;
        "docker"|"d")
            docker logs -f $(docker ps --format "table {{.Names}}" | tail -n +2 | head -1)
            ;;
        "podman"|"p")
            podman logs -f $(podman ps --format "table {{.Names}}" | tail -n +2 | head -1)
            ;;
        *)
            echo "📋 Available log sources: vercel (v), railway (r), docker (d), podman (p)"
            ;;
    esac
}

# ==========================================
# PROJECT QUICK SETUP
# ==========================================

# Quick project creation with auto-setup
create-project() {
    local name=$1
    local template=${2:-"nextjs"}
    local port=${3:-3000}
    
    if [[ -z "$name" ]]; then
        echo "❌ Project name required"
        echo "Usage: create-project <name> [template] [port]"
        echo "Templates: nextjs, express, vite, static"
        return 1
    fi
    
    echo "🎯 Creating $template project: $name"
    
    case $template in
        "nextjs"|"next")
            npx create-next-app@latest "$name" --typescript --tailwind --eslint --app
            ;;
        "express"|"api")
            mkdir "$name" && cd "$name"
            npm init -y
            npm install express cors helmet morgan
            npm install -D nodemon @types/node typescript tsx
            ;;
        "vite"|"react")
            npm create vite@latest "$name" -- --template react-ts
            ;;
        "static"|"html")
            mkdir "$name" && cd "$name"
            echo "<!DOCTYPE html><html><head><title>$name</title></head><body><h1>$name</h1></body></html>" > index.html
            ;;
        *)
            echo "❌ Unknown template: $template"
            return 1
            ;;
    esac
    
    if [[ $template != "static" ]]; then
        cd "$name"
        
        # Initialize git
        git init
        git add .
        git commit -m "🎉 Initial commit"
        
        # Set up mise for version management
        mise local node@lts
        
        echo "✅ Project created: $name"
        echo "💡 Run 'ds' to start development server"
    fi
}

# ==========================================
# ENVIRONMENT MANAGEMENT
# ==========================================

# Quick environment switcher
env-switch() {
    local env=${1:-"development"}
    
    case $env in
        "dev"|"development")
            export NODE_ENV=development
            echo "🔧 Switched to development environment"
            ;;
        "staging"|"stage")
            export NODE_ENV=staging  
            echo "🚀 Switched to staging environment"
            ;;
        "prod"|"production")
            export NODE_ENV=production
            echo "🏭 Switched to production environment"
            ;;
        *)
            echo "Current environment: ${NODE_ENV:-development}"
            echo "Available: dev, staging, prod"
            ;;
    esac
}

# ==========================================
# ALIASES FOR FUNCTIONS
# ==========================================
alias ds=dev-start           # Your requested ds command
alias dp=dev-ports
alias dt=dev-test
alias db=dev-build
alias dl=dev-logs
alias cp=create-project
alias env=env-switch
