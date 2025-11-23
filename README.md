# AUR Packages by Luca Steccanella

Collection of AUR packages maintained by Luca Steccanella.

## Available Packages

### VOXD - Voice Typing Application

Three variants of [VOXD](https://github.com/jakovius/voxd) - a voice-typing/dictation application for Linux:

### 1. voxd (Stable Source Build)
- **Directory**: `voxd/`
- **Description**: Builds from stable release tarballs
- **Best for**: Most users who want a stable, tested version
- **Build time**: ~2-5 minutes (compiles from source)

### 2. voxd-bin (Pre-built Binary)
- **Directory**: `voxd-bin/`
- **Description**: Installs pre-compiled binaries from GitHub releases
- **Best for**: Users who want fastest installation without compilation
- **Build time**: ~30 seconds (no compilation needed)

### 3. voxd-git (Development Version)
- **Directory**: `voxd-git/`
- **Description**: Builds from the latest git main branch
- **Best for**: Developers and users who want bleeding-edge features
- **Build time**: ~2-5 minutes (compiles from source)
- **Note**: May be unstable

## Quick Installation

Choose one variant:

```bash
# Stable version (recommended)
yay -S voxd

# Binary version (fastest)
yay -S voxd-bin

# Git version (latest features)
yay -S voxd-git
```

## What is VOXD?

VOXD is a speech-to-text, voice-typing, dictation software for Linux that:
- Runs in the background
- Provides fast voice-to-text typing in any Linux app
- Uses LOCAL (offline) voice processing
- Optional LOCAL (offline) AI text post-processing
- Works on older CPUs without GPU

## Post-Installation

After installing any variant:

1. Set up a global hotkey:
   - Open system keyboard shortcuts
   - Add command: `bash -c 'voxd --trigger-record'`
   - Assign your preferred hotkey

2. Run first-time setup:
   ```bash
   voxd --setup
   ```

3. For Wayland users: Log out and back in for ydotool permissions

## Automation

This repository uses **GitHub Actions** to automatically update voxd packages when new releases are detected:

- ✅ Daily checks for new voxd releases
- ✅ Auto-updates PKGBUILDs and checksums
- ✅ Auto-pushes to AUR repositories
- ✅ Creates GitHub releases for tracking

See [AUTOMATION.md](AUTOMATION.md) for setup details.

## Contributing

To submit or update these packages to the AUR:

1. Clone the appropriate package directory
2. Make your changes
3. Test with `makepkg -si`
4. Update `.SRCINFO` with `makepkg --printsrcinfo > .SRCINFO`
5. Commit and push to AUR

### Windsurf IDE Enhancements

Packages to enhance the Windsurf IDE:

#### windsurf-marketplace
- **Directory**: `windsurf-marketplace/`
- **Description**: Enable VS Code Marketplace in Windsurf
- **Installation**: `yay -S windsurf-marketplace`
- **AUR**: https://aur.archlinux.org/packages/windsurf-marketplace

#### windsurf-features
- **Directory**: `windsurf-features/`
- **Description**: Unblock additional features in Windsurf (Settings Sync, Remote Development, etc.)
- **Installation**: `yay -S windsurf-features`
- **AUR**: https://aur.archlinux.org/packages/windsurf-features

## Links

### VOXD
- Upstream: https://github.com/jakovius/voxd
- AUR voxd: https://aur.archlinux.org/packages/voxd
- AUR voxd-bin: https://aur.archlinux.org/packages/voxd-bin
- AUR voxd-git: https://aur.archlinux.org/packages/voxd-git

### Windsurf
- AUR windsurf-marketplace: https://aur.archlinux.org/packages/windsurf-marketplace
- AUR windsurf-features: https://aur.archlinux.org/packages/windsurf-features

## Maintainer

Luca Steccanella <steccas at pm dot me>

## License

Each package has its own license - see individual package directories for details.
