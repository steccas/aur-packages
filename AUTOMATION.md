# Automation Setup Guide

This repository uses GitHub Actions to automatically update AUR packages when new upstream releases are detected.

## How It Works

1. **Daily Check**: GitHub Actions runs daily at 00:00 UTC
2. **Version Detection**: Checks for new voxd releases on GitHub
3. **Auto-Update**: Updates PKGBUILDs and checksums
4. **Push to GitHub**: Commits changes to this repository
5. **Push to AUR**: Automatically pushes to AUR repositories

## Initial Setup

### 1. Create GitHub Repository

```bash
cd /home/stecca/git/aur

# Initialize git if not already done
git init
git add .
git commit -m "Initial commit: AUR packages collection"

# Create GitHub repo (via web or gh CLI)
gh repo create stecca/aur-packages --public --source=. --remote=origin --push
# OR manually:
# git remote add origin git@github.com:stecca/aur-packages.git
# git push -u origin main
```

### 2. Generate SSH Key for AUR

```bash
# Generate a new SSH key specifically for AUR automation
ssh-keygen -t ed25519 -C "aur-automation" -f ~/.ssh/aur_automation
# Don't set a passphrase (needed for automation)

# Add the public key to your AUR account
cat ~/.ssh/aur_automation.pub
# Go to https://aur.archlinux.org/account/ and add the key
```

### 3. Add SSH Key to GitHub Secrets

```bash
# Copy the private key
cat ~/.ssh/aur_automation

# Go to GitHub repo → Settings → Secrets and variables → Actions
# Click "New repository secret"
# Name: AUR_SSH_KEY
# Value: Paste the entire private key (including BEGIN and END lines)
```

### 4. Initialize AUR Repositories

For each package, you need to initialize the AUR repo once:

```bash
# voxd
cd voxd
git init
git remote add aur ssh://aur@aur.archlinux.org/voxd.git
makepkg --printsrcinfo > .SRCINFO
git add PKGBUILD .SRCINFO .gitignore
git commit -m "Initial commit: voxd 1.7.0"
git push -u aur master
cd ..

# voxd-bin
cd voxd-bin
git init
git remote add aur ssh://aur@aur.archlinux.org/voxd-bin.git
makepkg --printsrcinfo > .SRCINFO
git add PKGBUILD .SRCINFO .gitignore
git commit -m "Initial commit: voxd-bin 1.7.0"
git push -u aur master
cd ..

# voxd-git
cd voxd-git
git init
git remote add aur ssh://aur@aur.archlinux.org/voxd-git.git
makepkg --printsrcinfo > .SRCINFO
git add PKGBUILD .SRCINFO .gitignore
git commit -m "Initial commit: voxd-git"
git push -u aur master
cd ..

# windsurf-marketplace
cd windsurf-marketplace
git init
git remote add aur ssh://aur@aur.archlinux.org/windsurf-marketplace.git
makepkg --printsrcinfo > .SRCINFO
git add PKGBUILD .SRCINFO .gitignore
git commit -m "Initial commit: windsurf-marketplace 1.1.0"
git push -u aur master
cd ..

# windsurf-features
cd windsurf-features
git init
git remote add aur ssh://aur@aur.archlinux.org/windsurf-features.git
makepkg --printsrcinfo > .SRCINFO
git add PKGBUILD .SRCINFO .gitignore
git commit -m "Initial commit: windsurf-features 1.1.0"
git push -u aur master
cd ..
```

## Manual Trigger

You can manually trigger the update workflow:

1. Go to your GitHub repo
2. Click "Actions" tab
3. Select "Update VOXD Packages"
4. Click "Run workflow"

## Monitoring

- **GitHub Actions**: Check the Actions tab for workflow runs
- **Email Notifications**: GitHub will email you if workflows fail
- **AUR Comments**: Users may comment on AUR packages if issues arise

## Workflow Files

- `.github/workflows/update-voxd.yml` - Main automation workflow

## What Gets Automated

✅ **Automated:**
- voxd version updates
- voxd-bin version updates
- **Checksum updates** (including SHA256 for voxd-bin binaries)
- .SRCINFO generation
- Pushing to AUR

❌ **Manual (for now):**
- windsurf-marketplace updates (no upstream releases to track)
- windsurf-features updates (no upstream releases to track)
- voxd-git updates (tracks git main, rarely needs updates)

## Troubleshooting

### Workflow fails with SSH error
- Check that `AUR_SSH_KEY` secret is set correctly
- Verify the SSH key is added to your AUR account
- Test SSH connection: `ssh -T aur@aur.archlinux.org`

### Version not detected
- Check if voxd has a new release on GitHub
- Verify the API call in the workflow is working
- Check GitHub Actions logs

### Push to AUR fails
- Ensure you've initialized the AUR repos (step 4 above)
- Check that your AUR account has push access
- Verify the package names are correct

## Future Enhancements

Possible improvements:
- Add automation for windsurf packages (if they get versioned releases)
- Add build testing before pushing to AUR
- Add notifications (Discord, Telegram, etc.)
- Add automatic PR creation instead of direct push
- Add dependency update detection
