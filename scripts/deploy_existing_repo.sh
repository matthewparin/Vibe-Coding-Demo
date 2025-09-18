#!/usr/bin/env bash
set -euo pipefail

echo "🚀 Deploying FP&A app to GitHub Pages from existing repo..."

# Check if we're in a git repo
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    echo "❌ Not in a git repository. Run this from your project root."
    exit 1
fi

# Check if we have uncommitted changes
if ! git diff-index --quiet HEAD --; then
    echo "📝 You have uncommitted changes. Adding them..."
    git add .
    git commit -m "feat: add GitHub Pages hosting setup"
fi

# Get current remote URL to determine repo name
REMOTE_URL=$(git remote get-url origin)
echo "📡 Current remote: $REMOTE_URL"

# Push to main branch
echo "📤 Pushing to main branch..."
git push origin main

# Enable GitHub Pages via GitHub CLI if available
if command -v gh >/dev/null; then
    echo "⚙️  Enabling GitHub Pages..."
    gh api repos/{owner}/{repo}/pages \
        --method POST \
        --field source='{"branch":"main","path":"/"}' \
        --field build_type="workflow" || echo "Pages might already be enabled"
    
    echo "🎯 Triggering GitHub Pages workflow..."
    gh workflow run "Deploy to GitHub Pages" || echo "Workflow triggered (may already be running)"
else
    echo "⚠️  GitHub CLI not found. Please enable Pages manually:"
    echo "   1. Go to your repo Settings → Pages"
    echo "   2. Source: GitHub Actions"
    echo "   3. The workflow will auto-deploy on the next push"
fi

echo ""
echo "✅ Setup complete!"
echo "🌐 Your app will be available at:"
echo "   https://$(gh api user --jq .login 2>/dev/null || echo 'YOUR-USERNAME').github.io/$(basename -s .git $(git remote get-url origin))"
echo ""
echo "📊 Check deployment status:"
echo "   gh run list --workflow='Deploy to GitHub Pages'"
