#!/bin/bash

# CivicTechWR Project Setup Script
# This script sets up the development environment for new contributors

set -e  # Exit on any error

echo "🚀 Setting up CivicTechWR Project Development Environment"
echo "=================================================="

# Check if we're in the right directory
if [ ! -f "README.md" ]; then
    echo "❌ Error: Please run this script from the project root directory"
    exit 1
fi

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to prompt for user input
prompt_user() {
    read -p "$1 (y/n): " -n 1 -r
    echo
    [[ $REPLY =~ ^[Yy]$ ]]
}

echo "🔍 Checking system requirements..."

# Check for Git
if ! command_exists git; then
    echo "❌ Git is required but not installed. Please install Git first."
    exit 1
fi
echo "✅ Git found"

# Detect project type and set up accordingly
echo "🔍 Detecting project type..."

if [ -f "package.json" ]; then
    PROJECT_TYPE="node"
    echo "📦 Node.js project detected"
elif [ -f "requirements.txt" ] || [ -f "setup.py" ] || [ -f "pyproject.toml" ]; then
    PROJECT_TYPE="python"
    echo "🐍 Python project detected"
elif [ -f "Gemfile" ]; then
    PROJECT_TYPE="ruby"
    echo "💎 Ruby project detected"
elif [ -f "pubspec.yaml" ]; then
    PROJECT_TYPE="flutter"
    echo "🐦 Flutter project detected"
else
    PROJECT_TYPE="static"
    echo "📄 Static site project detected"
fi

# Node.js setup
if [ "$PROJECT_TYPE" = "node" ]; then
    if ! command_exists node; then
        echo "❌ Node.js is required but not installed."
        echo "Please install Node.js from https://nodejs.org/"
        exit 1
    fi

    if ! command_exists npm; then
        echo "❌ npm is required but not installed."
        exit 1
    fi

    echo "✅ Node.js $(node --version) found"
    echo "✅ npm $(npm --version) found"

    echo "📦 Installing Node.js dependencies..."
    npm install

    # Check for common civic tech dependencies
    if npm list | grep -q "accessibility"; then
        echo "♿ Accessibility tools detected"
    fi

    echo "🔧 Setting up development tools..."
    if [ -f ".eslintrc.js" ] || [ -f ".eslintrc.json" ]; then
        echo "✅ ESLint configuration found"
    fi

    if [ -f ".prettierrc" ] || [ -f "prettier.config.js" ]; then
        echo "✅ Prettier configuration found"
    fi
fi

# Python setup
if [ "$PROJECT_TYPE" = "python" ]; then
    if ! command_exists python3; then
        echo "❌ Python 3 is required but not installed."
        echo "Please install Python 3 from https://python.org/"
        exit 1
    fi

    echo "✅ Python $(python3 --version) found"

    # Create virtual environment if it doesn't exist
    if [ ! -d "venv" ]; then
        echo "🐍 Creating Python virtual environment..."
        python3 -m venv venv
    fi

    echo "🐍 Activating virtual environment..."
    source venv/bin/activate

    echo "📦 Installing Python dependencies..."
    if [ -f "requirements.txt" ]; then
        pip install -r requirements.txt
    fi

    if [ -f "requirements-dev.txt" ]; then
        pip install -r requirements-dev.txt
    fi

    # Check for common civic tech dependencies
    if pip list | grep -q "django"; then
        echo "🌐 Django framework detected"
    fi

    if pip list | grep -q "flask"; then
        echo "🌐 Flask framework detected"
    fi
fi

# Ruby setup
if [ "$PROJECT_TYPE" = "ruby" ]; then
    if ! command_exists ruby; then
        echo "❌ Ruby is required but not installed."
        exit 1
    fi

    if ! command_exists bundle; then
        echo "❌ Bundler is required but not installed."
        echo "Run: gem install bundler"
        exit 1
    fi

    echo "✅ Ruby $(ruby --version) found"
    echo "✅ Bundler found"

    echo "💎 Installing Ruby dependencies..."
    bundle install

    # Check for Jekyll (common in civic tech static sites)
    if bundle list | grep -q "jekyll"; then
        echo "📄 Jekyll static site generator detected"
    fi
fi

# Flutter setup
if [ "$PROJECT_TYPE" = "flutter" ]; then
    if ! command_exists flutter; then
        echo "❌ Flutter is required but not installed."
        echo "Please install Flutter from https://flutter.dev/"
        exit 1
    fi

    echo "✅ Flutter found"
    flutter doctor

    echo "🐦 Getting Flutter dependencies..."
    flutter pub get
fi

# Create development environment file if it doesn't exist
if [ ! -f ".env" ] && [ ! -f ".env.example" ]; then
    echo "🔧 Creating environment configuration..."
    cat > .env.example << EOF
# Environment Configuration for Development
# Copy this file to .env and fill in your values

# Development settings
NODE_ENV=development
DEBUG=true

# Database (if applicable)
# DATABASE_URL=postgresql://localhost:5432/your_db_name

# External APIs (if applicable)
# EXTERNAL_API_KEY=your_api_key_here

# Security (generate strong secrets for production)
# SECRET_KEY=your_secret_key_here

# Civic Tech specific settings
# ORGANIZATION_NAME=CivicTechWR
# SEASON=Season_X
EOF
    echo "📄 Created .env.example - copy to .env and customize for your setup"
fi

# Set up pre-commit hooks for code quality
echo "🔧 Setting up development tools..."

# Create simple pre-commit hook
if [ ! -f ".git/hooks/pre-commit" ]; then
    cat > .git/hooks/pre-commit << 'EOF'
#!/bin/bash
# Pre-commit hook for CivicTechWR projects

echo "🔍 Running pre-commit checks..."

# Check for secrets in staged files
if git diff --cached --name-only | xargs grep -l "password\|secret\|key\|token" 2>/dev/null; then
    echo "❌ Potential secrets detected in staged files!"
    echo "Please review and remove any sensitive data before committing."
    exit 1
fi

# Run project-specific linting
if [ -f "package.json" ] && command -v npm >/dev/null; then
    if npm run lint --silent 2>/dev/null; then
        echo "✅ JavaScript linting passed"
    fi
fi

if [ -f "requirements.txt" ] && command -v flake8 >/dev/null; then
    if flake8 . 2>/dev/null; then
        echo "✅ Python linting passed"
    fi
fi

echo "✅ Pre-commit checks completed"
EOF
    chmod +x .git/hooks/pre-commit
    echo "✅ Pre-commit hooks installed"
fi

# Create basic project structure if missing
echo "📁 Checking project structure..."

# Create essential directories
mkdir -p assets/images
mkdir -p docs
mkdir -p tests

# Create .gitignore if it doesn't exist
if [ ! -f ".gitignore" ]; then
    cat > .gitignore << 'EOF'
# Development environment
.env
.env.local

# Dependencies
node_modules/
venv/
vendor/

# Build outputs
dist/
build/
_site/

# IDE files
.vscode/
.idea/
*.swp
*.swo
*~

# OS files
.DS_Store
Thumbs.db

# Logs
*.log
logs/

# Temporary files
*.tmp
*.temp

# Civic tech specific
# Add any sensitive data patterns here
EOF
    echo "📄 Created .gitignore file"
fi

# Verify accessibility tools
echo "♿ Checking accessibility tools..."
if command_exists npm && [ -f "package.json" ]; then
    if npm list @axe-core/cli &>/dev/null || npm list lighthouse &>/dev/null; then
        echo "✅ Accessibility testing tools available"
    else
        echo "💡 Consider adding accessibility testing tools:"
        echo "   npm install --save-dev @axe-core/cli lighthouse"
    fi
fi

# Check for Docker setup
if [ -f "Dockerfile" ] || [ -f "docker-compose.yml" ]; then
    echo "🐳 Docker configuration detected"
    if command_exists docker; then
        echo "✅ Docker is available"
    else
        echo "💡 Docker is configured but not installed. Install Docker for containerized development."
    fi
fi

echo ""
echo "🎉 Setup completed successfully!"
echo "=================================================="
echo ""
echo "📋 Next steps:"
echo "1. Copy .env.example to .env and customize settings"
echo "2. Review the project documentation in docs/"
echo "3. Check our DVF scorecard in docs/DVF_SCORECARD.md"
echo "4. Start contributing! Check issues labeled 'good first issue'"
echo ""

# Project-specific startup instructions
case $PROJECT_TYPE in
    "node")
        echo "🚀 To start development:"
        echo "   npm start"
        if [ -f "package.json" ] && grep -q "dev" package.json; then
            echo "   npm run dev"
        fi
        ;;
    "python")
        echo "🚀 To start development:"
        echo "   source venv/bin/activate"
        if [ -f "manage.py" ]; then
            echo "   python manage.py runserver"
        elif [ -f "app.py" ]; then
            echo "   python app.py"
        fi
        ;;
    "ruby")
        echo "🚀 To start development:"
        if bundle list | grep -q "jekyll"; then
            echo "   bundle exec jekyll serve"
        else
            echo "   bundle exec [your-command]"
        fi
        ;;
    "flutter")
        echo "🚀 To start development:"
        echo "   flutter run"
        ;;
    "static")
        echo "🚀 To start development:"
        echo "   Open index.html in your browser"
        echo "   Or use a local server like 'python -m http.server'"
        ;;
esac

echo ""
echo "🤝 Welcome to CivicTechWR! Let's build technology that serves our community."
echo ""
echo "Need help? Join our weekly meetings or reach out on our communication channels."
echo "Check CONTRIBUTING.md for more details on how to get involved."
EOF