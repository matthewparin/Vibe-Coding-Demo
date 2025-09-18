#!/usr/bin/env bash
set -euo pipefail

echo "🚀 Deploying FP&A app to Netlify (works with private repos)..."

# Check if netlify CLI is installed
if ! command -v netlify >/dev/null; then
    echo "📦 Installing Netlify CLI..."
    npm install -g netlify-cli
fi

# Deploy to Netlify
echo "🌐 Deploying to Netlify..."
netlify deploy --prod --dir .

echo ""
echo "✅ Deployment complete!"
echo "🔗 Your app URL will be shown above"
echo ""
echo "💡 Next time you can just run: netlify deploy --prod --dir ."
