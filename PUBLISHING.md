# Publishing to AUR - Quick Guide

This guide explains how to publish each package variant to the AUR.

## Prerequisites

1. AUR account: https://aur.archlinux.org/register
2. SSH key added to your AUR account
3. Git configured with your name and email

## Publishing Steps

### Initial Setup (One-time)

```bash
# Configure git for AUR
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"

# Add your SSH key to AUR account at:
# https://aur.archlinux.org/account/
```

### Publishing voxd (Stable)

```bash
cd voxd

# Test build locally first
makepkg -si

# Update .SRCINFO
makepkg --printsrcinfo > .SRCINFO

# Initialize AUR repo (first time only)
git init
git remote add origin ssh://aur@aur.archlinux.org/voxd.git

# Commit and push
git add PKGBUILD .SRCINFO .gitignore
git commit -m "Initial commit: voxd 1.7.0"
git push -u origin master

# For updates:
# 1. Update pkgver in PKGBUILD
# 2. Run: updpkgsums
# 3. Run: makepkg --printsrcinfo > .SRCINFO
# 4. Test: makepkg -si
# 5. Commit and push
```

### Publishing voxd-bin (Binary)

```bash
cd voxd-bin

# Test build locally first
makepkg -si

# Update .SRCINFO
makepkg --printsrcinfo > .SRCINFO

# Initialize AUR repo (first time only)
git init
git remote add origin ssh://aur@aur.archlinux.org/voxd-bin.git

# Commit and push
git add PKGBUILD .SRCINFO .gitignore
git commit -m "Initial commit: voxd-bin 1.7.0"
git push -u origin master
```

### Publishing voxd-git (Development)

```bash
cd voxd-git

# Test build locally first
makepkg -si

# Update .SRCINFO
makepkg --printsrcinfo > .SRCINFO

# Initialize AUR repo (first time only)
git init
git remote add origin ssh://aur@aur.archlinux.org/voxd-git.git

# Commit and push
git add PKGBUILD .SRCINFO .gitignore
git commit -m "Initial commit: voxd-git"
git push -u origin master
```

## Important Notes

### Before Publishing

1. **Update maintainer info** in each PKGBUILD:
   ```bash
   # Change this line in all PKGBUILDs:
   # Maintainer: Your Name <your.email@example.com>
   ```

2. **Test each package**:
   ```bash
   cd <package-dir>
   makepkg -si
   voxd --version  # Verify it works
   ```

3. **Run namcap** (optional but recommended):
   ```bash
   namcap PKGBUILD
   makepkg
   namcap *.pkg.tar.zst
   ```

### Updating Packages

#### voxd (stable)
When a new version is released:
```bash
cd voxd
# Edit PKGBUILD: update pkgver
# Edit PKGBUILD: reset pkgrel=1
updpkgsums
makepkg --printsrcinfo > .SRCINFO
makepkg -si  # Test
git add PKGBUILD .SRCINFO
git commit -m "Update to version X.Y.Z"
git push
```

#### voxd-bin
When a new binary release is available:
```bash
cd voxd-bin
# Edit PKGBUILD: update pkgver
# Edit PKGBUILD: reset pkgrel=1
# Update source URLs if needed
makepkg --printsrcinfo > .SRCINFO
makepkg -si  # Test
git add PKGBUILD .SRCINFO
git commit -m "Update to version X.Y.Z"
git push
```

#### voxd-git
Usually doesn't need version updates (tracks git main):
```bash
cd voxd-git
# Only update if dependencies change or build process changes
makepkg --printsrcinfo > .SRCINFO
git add PKGBUILD .SRCINFO
git commit -m "Update dependencies/build process"
git push
```

## Troubleshooting

### SSH Authentication Issues
```bash
# Test SSH connection
ssh -T aur@aur.archlinux.org

# Should see: "Hi username! You've successfully authenticated..."
```

### Package Already Exists
If someone else already published the package, you can:
1. Request co-maintainer access
2. Choose a different package name
3. Submit improvements as comments on the existing package

### Build Failures
```bash
# Clean build directory
rm -rf src pkg *.tar.gz *.tar.zst

# Try again
makepkg -si
```

## AUR Package Guidelines

Follow these AUR guidelines:
- https://wiki.archlinux.org/title/AUR_submission_guidelines
- https://wiki.archlinux.org/title/PKGBUILD
- https://wiki.archlinux.org/title/Arch_package_guidelines

## Useful Commands

```bash
# Update checksums
updpkgsums

# Generate .SRCINFO
makepkg --printsrcinfo > .SRCINFO

# Build and install
makepkg -si

# Clean build artifacts
makepkg -c

# Check PKGBUILD
namcap PKGBUILD

# Check built package
namcap *.pkg.tar.zst
```
