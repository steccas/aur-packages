#!/bin/bash
# Cleanup script after testing AUR packages

set -e

echo "=== AUR Package Cleanup ==="
echo ""

# Function to clean a package directory
clean_package() {
    local dir=$1
    if [ -d "$dir" ]; then
        echo "Cleaning $dir..."
        cd "$dir"
        rm -rf src/ pkg/ *.tar.gz *.tar.xz *.tar.zst *.log 2>/dev/null || true
        cd ..
    fi
}

# Clean all package directories
echo "1. Cleaning build artifacts..."
clean_package "voxd"
clean_package "voxd-bin"
clean_package "voxd-git"
clean_package "windsurf-marketplace"
clean_package "windsurf-features"
clean_package "pkgbase"

echo "✓ Build artifacts cleaned"
echo ""

# Ask about removing installed packages
echo "2. Remove installed test packages?"
echo ""
echo "Installed voxd packages:"
pacman -Qs voxd || echo "  (none)"
echo ""
echo "Installed windsurf packages:"
pacman -Qs windsurf-marketplace || echo "  (none)"
pacman -Qs windsurf-features || echo "  (none)"
echo ""

read -p "Remove voxd packages? (y/N) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    # Remove all voxd variants
    sudo pacman -R voxd voxd-bin voxd-git 2>/dev/null || true
    echo "✓ voxd packages removed"
fi

read -p "Remove windsurf packages? (y/N) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    sudo pacman -R windsurf-marketplace windsurf-features 2>/dev/null || true
    echo "✓ windsurf packages removed"
fi

echo ""
echo "=== Cleanup Complete ==="
echo ""
echo "Remaining installed packages:"
pacman -Qs "voxd|windsurf-marketplace|windsurf-features" || echo "  (none - all cleaned up!)"
