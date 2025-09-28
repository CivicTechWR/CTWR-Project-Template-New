#!/bin/bash

# CivicTechWR Project Setup Script
# Creates a GitHub Project with DVF tracking for a new CTWR season project

set -e  # Exit on any error

echo "🚀 Setting up CivicTechWR Project Management"
echo "============================================"

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check for GitHub CLI
if ! command_exists gh; then
    echo "❌ GitHub CLI (gh) is required but not installed."
    echo "Please install it from https://cli.github.com/"
    exit 1
fi

# Check authentication
if ! gh auth status &>/dev/null; then
    echo "❌ You must be authenticated with GitHub CLI."
    echo "Run: gh auth login"
    exit 1
fi

# Check for project scope
if ! gh auth status 2>&1 | grep -q "project"; then
    echo "❌ Missing required 'project' scope for GitHub Projects."
    echo "Run: gh auth refresh -s project --hostname github.com"
    echo "Then follow the device authorization flow."
    exit 1
fi

# Get project details
echo "📋 Project Setup Information"
echo "============================"

# Prompt for project name
read -r -p "Enter project name (e.g., 'Accessible Transit App'): " PROJECT_NAME
if [ -z "$PROJECT_NAME" ]; then
    echo "❌ Project name is required."
    exit 1
fi

# Prompt for season
read -r -p "Enter CTWR season (e.g., 'Season 6'): " SEASON
if [ -z "$SEASON" ]; then
    SEASON="Season X"
fi

# Confirm organization
OWNER="CivicTechWR"
echo "🏢 Organization: $OWNER"
echo "📋 Project: $PROJECT_NAME"
echo "📅 Season: $SEASON"
echo ""

read -p "Create this project? (y/n): " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "❌ Project creation cancelled."
    exit 1
fi

echo "🔧 Creating GitHub Project..."

# Create the project
if ! gh project create --owner "$OWNER" --title "$PROJECT_NAME - $SEASON"; then
    echo "❌ Failed to create project."
    exit 1
fi

# Extract project number from the output (last part of the URL or ID)
PROJECT_NUMBER=$(gh project list --owner "$OWNER" | grep "$PROJECT_NAME" | head -1 | awk '{print $1}')

if [ -z "$PROJECT_NUMBER" ]; then
    echo "❌ Could not determine project number."
    exit 1
fi

echo "✅ Project created with ID: $PROJECT_NUMBER"

echo "🔧 Setting up DVF tracking fields..."

# Create DVF fields
echo "  📊 Creating DVF Community Partner field..."
gh project field-create "$PROJECT_NUMBER" --owner "$OWNER" \
  --data-type SINGLE_SELECT \
  --name "DVF Community Partner" \
  --single-select-options "1 - Poor,2 - Weak,3 - Good,4 - Strong,5 - Exceptional"

echo "  👥 Creating DVF Talent Team field..."
gh project field-create "$PROJECT_NUMBER" --owner "$OWNER" \
  --data-type SINGLE_SELECT \
  --name "DVF Talent Team" \
  --single-select-options "1 - Poor,2 - Weak,3 - Good,4 - Strong,5 - Exceptional"

echo "  💻 Creating DVF Technically Exciting field..."
gh project field-create "$PROJECT_NUMBER" --owner "$OWNER" \
  --data-type SINGLE_SELECT \
  --name "DVF Technically Exciting" \
  --single-select-options "1 - Poor,2 - Weak,3 - Good,4 - Strong,5 - Exceptional"

echo "  🏛️ Creating DVF Civic Exciting field..."
gh project field-create "$PROJECT_NUMBER" --owner "$OWNER" \
  --data-type SINGLE_SELECT \
  --name "DVF Civic Exciting" \
  --single-select-options "1 - Poor,2 - Weak,3 - Good,4 - Strong,5 - Exceptional"

echo "  🔢 Creating DVF Total Score field..."
gh project field-create "$PROJECT_NUMBER" --owner "$OWNER" \
  --data-type NUMBER \
  --name "DVF Total Score"

echo "  📅 Creating Season Week field..."
gh project field-create "$PROJECT_NUMBER" --owner "$OWNER" \
  --data-type SINGLE_SELECT \
  --name "Season Week" \
  --single-select-options "Week 1,Week 2,Week 3,Week 4,Week 5,Week 6,Week 7,Week 8,Week 9,Week 10,Week 11,Week 12"

echo "  🎯 Creating Project Phase field..."
gh project field-create "$PROJECT_NUMBER" --owner "$OWNER" \
  --data-type SINGLE_SELECT \
  --name "Project Phase" \
  --single-select-options "Pitch,Breakout,Development,Testing,Demo Prep,Demo Day,Completed"

echo "🔗 Linking project to repository..."

# Get current repository name if we're in a git repo
if git rev-parse --git-dir > /dev/null 2>&1; then
    REPO_NAME=$(basename "$(git config --get remote.origin.url)" .git)
    if [[ "$REPO_NAME" =~ ^[a-zA-Z0-9._-]+$ ]]; then
        echo "  📁 Linking to repository: $REPO_NAME"
        gh project link "$PROJECT_NUMBER" --owner "$OWNER" --repo "$REPO_NAME"
        echo "✅ Project linked to repository: $REPO_NAME"
    else
        echo "  ⚠️ Could not determine repository name. Link manually if needed."
    fi
else
    echo "  ⚠️ Not in a git repository. Link manually if needed."
fi

echo ""
echo "🎉 Project Setup Complete!"
echo "========================="
echo ""
echo "📋 Project Details:"
echo "   Name: $PROJECT_NAME - $SEASON"
echo "   ID: $PROJECT_NUMBER"
echo "   URL: https://github.com/orgs/$OWNER/projects/$PROJECT_NUMBER"
echo ""
echo "📊 DVF Fields Added:"
echo "   ✅ Community Partner (1-5 scale)"
echo "   ✅ Talent & Team (1-5 scale)"
echo "   ✅ Technically Exciting (1-5 scale)"
echo "   ✅ Civic Exciting (1-5 scale)"
echo "   ✅ Total Score (calculated field)"
echo "   ✅ Season Week (Week 1-12)"
echo "   ✅ Project Phase (Pitch → Demo Day)"
echo ""
echo "📋 Next Steps:"
echo "1. 📝 Complete your DVF scorecard assessment (Week 1-3)"
echo "2. 🎯 Create initial project issues and link them to the project"
echo "3. 📊 Update DVF scores regularly (Week 6 mid-season check)"
echo "4. 🚀 Track progress through the 12-week season workflow"
echo ""
echo "📖 Documentation:"
echo "   DVF Scorecard: docs/DVF_SCORECARD.md"
echo "   Project Workflow: docs/PROJECT_MANAGEMENT.md"
echo ""
echo "🤝 Need help? Ask in CTWR community channels or weekly meetings!"