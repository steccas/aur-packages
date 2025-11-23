#!/bin/bash
# Quick setup script for GitHub + AUR automation

set -e

echo "=== AUR Packages - GitHub Setup ==="
echo ""

# Check if we're in the right directory
if [ ! -f "README.md" ] || [ ! -d "voxd" ]; then
    echo "Error: Please run this script from the aur directory"
    exit 1
fi

# Check if git is initialized
if [ ! -d ".git" ]; then
    echo "Initializing git repository..."
    git init
    git add .
    git commit -m "Initial commit: AUR packages collection"
else
    echo "✓ Git repository already initialized"
fi

# Check for GitHub CLI
if command -v gh &> /dev/null; then
    # Get the actual GitHub username
    GH_USER=$(gh api user --jq .login 2>/dev/null || echo "")
    
    if [ -n "$GH_USER" ]; then
        echo ""
        echo "GitHub CLI detected. Would you like to create the GitHub repo now? (y/n)"
        read -r response
        if [[ "$response" =~ ^[Yy]$ ]]; then
            gh repo create "$GH_USER/aur-packages" --public --source=. --remote=origin --push
            echo "✓ GitHub repository created and pushed"
        fi
    else
        echo ""
        echo "GitHub CLI detected but not authenticated. Run: gh auth login"
    fi
else
    echo ""
    echo "To create GitHub repository manually:"
    echo "1. Go to https://github.com/new"
    echo "2. Create repo named 'aur-packages'"
    echo "3. Then run:"
    echo "   git remote add origin git@github.com:YOUR_USERNAME/aur-packages.git"
    echo "   git branch -M main"
    echo "   git push -u origin main"
fi

echo ""
echo "=== Next Steps ==="
echo ""
echo "1. Generate SSH key for AUR automation:"
echo "   ssh-keygen -t ed25519 -C 'aur-automation' -f ~/.ssh/aur_automation"
echo ""
echo "2. Add public key to AUR account:"
echo "   cat ~/.ssh/aur_automation.pub"
echo "   Then go to: https://aur.archlinux.org/account/"
echo ""
echo "3. Add private key to GitHub Secrets:"
echo "   cat ~/.ssh/aur_automation"
echo "   Then go to: https://github.com/YOUR_USERNAME/aur-packages/settings/secrets/actions"
echo "   Create secret named: AUR_SSH_KEY"
echo ""
echo "4. Follow AUTOMATION.md for detailed setup instructions"
echo ""
echo "Setup script complete!"
