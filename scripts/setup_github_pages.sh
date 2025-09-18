#!/usr/bin/env bash
set -euo pipefail
REPO_NAME="${1:-fpa-close-app}"
VISIBILITY="${2:-private}"   # private|public
CUSTOM_DOMAIN="${3:-}"       # optional, e.g., fpaclose.example.com

command -v gh >/dev/null || { echo "Please install GitHub CLI (gh)"; exit 1; }
git init
git add .
git commit -m "chore: initial commit"
gh repo create "$REPO_NAME" --source=. --"$VISIBILITY" --push

if [ -n "$CUSTOM_DOMAIN" ]; then
  echo "$CUSTOM_DOMAIN" > CNAME
  git add CNAME && git commit -m "chore: add CNAME" && git push
fi

gh workflow run "Deploy to GitHub Pages" || true
echo "If first run is queued, push a no-op to 'main' to trigger:"
echo "  git commit --allow-empty -m 'chore: trigger pages' && git push"
