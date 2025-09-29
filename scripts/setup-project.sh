#!/bin/bash

# CivicTechWR Project Setup Script
# Creates a GitHub Project with DVF tracking for a new CTWR season project.
#
# Requirements:
#   * GitHub CLI (`gh`) installed and authenticated (run `gh auth login`).
#   * Access to the CivicTechWR GitHub organization with project creation rights.
#   * `project` scope granted to the CLI token (`gh auth refresh -s project --hostname github.com`).
#   * Network access to GitHub's API.
#
# For CI or dry-runs set `CTWR_SKIP_SCOPE_CHECK=1` to bypass the scope validation.

set -euo pipefail # Exit on error, undefined var, or failed pipeline

require_command() {
    local cmd="$1"
    local label=${2:-$1}
    local help=${3:-}

    if ! command -v "$cmd" >/dev/null 2>&1; then
        echo "❌ ${label} is required but not installed."
        if [[ -n "${help}" ]]; then
            echo "${help}"
        fi
        exit 1
    fi
}

echo "🚀 Setting up CivicTechWR Project Management"
echo "============================================"

# Check for GitHub CLI
require_command gh "GitHub CLI (gh)" "Please install it from https://cli.github.com/"

# Check authentication while preserving `set -e`
if gh auth status >/dev/null 2>&1; then :; else
    echo "❌ You must be authenticated with GitHub CLI."
    echo "Run: gh auth login"
    exit 1
fi

# Check for project scope unless explicitly skipped (useful for automated smoke tests)
if [[ "${CTWR_SKIP_SCOPE_CHECK:-0}" != "1" ]]; then
    AUTH_STATUS=$(gh auth status 2>&1 || true)
    if grep -qi "project" <<<"${AUTH_STATUS}"; then
        :
    else
        echo "❌ Missing required 'project' scope for GitHub Projects."
        echo "Run: gh auth refresh -s project --hostname github.com"
        echo "Then follow the device authorization flow."
        exit 1
    fi
else
    echo "⚠️  Skipping GitHub scope validation because CTWR_SKIP_SCOPE_CHECK=1"
fi

# Determine repository defaults
remote_url=$(git config --get remote.origin.url 2>/dev/null || true)
remote_owner=""
remote_repo=""
if [[ -n "${remote_url}" && ${remote_url} =~ github\.com[:/]([^/]+)/([^/]+)(\.git)?$ ]]; then
    remote_owner=${BASH_REMATCH[1]}
    remote_repo=${BASH_REMATCH[2]}
    remote_repo=${remote_repo%.git}
fi

OWNER=${CTWR_PROJECT_OWNER:-${remote_owner:-CivicTechWR}}

# Get project details
echo "📋 Project Setup Information"
echo "============================"

# Prompt for project name
read -r -p "Enter project name (e.g., 'Accessible Transit App'): " PROJECT_NAME
if [[ -z "${PROJECT_NAME}" ]]; then
    echo "❌ Project name is required."
    exit 1
fi

# Prompt for season
read -r -p "Enter CTWR season (e.g., 'Season 6'): " SEASON
if [[ -z "${SEASON}" ]]; then
    SEASON="Season X"
fi

# Confirm organization
echo "🏢 Organization: ${OWNER}"
echo "📋 Project: ${PROJECT_NAME}"
echo "📅 Season: ${SEASON}"
echo ""

read -p "Create this project? (y/n): " -n 1 -r
echo
if [[ ! ${REPLY} =~ ^[Yy]$ ]]; then
    echo "❌ Project creation cancelled."
    exit 1
fi

echo "🔧 Creating GitHub Project..."

# Create the project and capture the project number directly from gh output
PROJECT_NUMBER=$(gh project create \
    --owner "${OWNER}" \
    --title "${PROJECT_NAME} - ${SEASON}" \
    --format json \
    --jq '.number') || {
    echo "❌ Failed to create project."
    exit 1
}

if [[ -z "${PROJECT_NUMBER}" || "${PROJECT_NUMBER}" == "null" ]]; then
    echo "❌ Could not determine project number from GitHub CLI response."
    exit 1
fi

# Fetch the canonical project URL for display purposes
PROJECT_URL=$(gh project view "${PROJECT_NUMBER}" --owner "${OWNER}" --format json --jq '.url' 2>/dev/null)
if [[ -z "${PROJECT_URL}" || "${PROJECT_URL}" == "null" ]]; then
    PROJECT_URL="https://github.com/orgs/${OWNER}/projects/${PROJECT_NUMBER}"
fi

echo "✅ Project created with ID: ${PROJECT_NUMBER}"

echo "🔧 Setting up DVF tracking fields..."

# Create DVF fields
echo "  📊 Creating DVF Community Partner field..."
gh project field-create "${PROJECT_NUMBER}" --owner "${OWNER}" \
    --data-type SINGLE_SELECT \
    --name "DVF Community Partner" \
    --single-select-options "1 - Poor,2 - Weak,3 - Good,4 - Strong,5 - Exceptional"

echo "  👥 Creating DVF Talent Team field..."
gh project field-create "${PROJECT_NUMBER}" --owner "${OWNER}" \
    --data-type SINGLE_SELECT \
    --name "DVF Talent Team" \
    --single-select-options "1 - Poor,2 - Weak,3 - Good,4 - Strong,5 - Exceptional"

echo "  💻 Creating DVF Technically Exciting field..."
gh project field-create "${PROJECT_NUMBER}" --owner "${OWNER}" \
    --data-type SINGLE_SELECT \
    --name "DVF Technically Exciting" \
    --single-select-options "1 - Poor,2 - Weak,3 - Good,4 - Strong,5 - Exceptional"

echo "  🏛️ Creating DVF Civic Exciting field..."
gh project field-create "${PROJECT_NUMBER}" --owner "${OWNER}" \
    --data-type SINGLE_SELECT \
    --name "DVF Civic Exciting" \
    --single-select-options "1 - Poor,2 - Weak,3 - Good,4 - Strong,5 - Exceptional"

echo "  🔢 Creating DVF Total Score field..."
gh project field-create "${PROJECT_NUMBER}" --owner "${OWNER}" \
    --data-type NUMBER \
    --name "DVF Total Score"

echo "  📅 Creating Season Week field..."
gh project field-create "${PROJECT_NUMBER}" --owner "${OWNER}" \
    --data-type SINGLE_SELECT \
    --name "Season Week" \
    --single-select-options "Week 1,Week 2,Week 3,Week 4,Week 5,Week 6,Week 7,Week 8,Week 9,Week 10,Week 11,Week 12"

echo "  🎯 Creating Project Phase field..."
gh project field-create "${PROJECT_NUMBER}" --owner "${OWNER}" \
    --data-type SINGLE_SELECT \
    --name "Project Phase" \
    --single-select-options "Pitch,Breakout,Development,Testing,Demo Prep,Demo Day,Completed"

echo "🔗 Linking project to repository..."

# Get current repository name if we're in a git repo
if git rev-parse --git-dir >/dev/null 2>&1; then
    REPO_NAME=${remote_repo:-$(basename "$(git config --get remote.origin.url)" .git)}
    if [[ "${REPO_NAME}" =~ ^[a-zA-Z0-9._-]+$ ]]; then
        echo "  📁 Linking to repository: ${REPO_NAME}"
        if gh project link "${PROJECT_NUMBER}" --owner "${OWNER}" --repo "${OWNER}/${REPO_NAME}"; then
            echo "✅ Project linked to repository: ${OWNER}/${REPO_NAME}"
        else
            echo "  ⚠️ Failed to link repository automatically."
            echo "     Run: gh project link ${PROJECT_NUMBER} --owner ${OWNER} --repo ${OWNER}/${REPO_NAME}"
        fi
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
echo "   Name: ${PROJECT_NAME} - ${SEASON}"
echo "   ID: ${PROJECT_NUMBER}"
echo "   URL: ${PROJECT_URL}"
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
