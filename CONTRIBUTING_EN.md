# Contributing Guide — CaramOS

Thank you for your interest in CaramOS! This document describes the project architecture, how to build the ISO, development workflow, and how to contribute.

> [Tiếng Việt](CONTRIBUTING.md) · [README](README_EN.md)

---

## Table of Contents

- [Project Architecture](#project-architecture)
- [Build ISO](#build-iso)
- [How to Contribute](#how-to-contribute)
- [Development Workflow](#development-workflow)
- [Code Standards](#code-standards)
- [Bug Reports & Feature Requests](#bug-reports--feature-requests)

---

## Project Architecture

CaramOS = **Ubuntu base** + **Linux Mint tools** + **CaramOS customization**.

```
Ubuntu archive (kernel, systemd, libs)
     ↓
+ Linux Mint repo (mintupdate, nemo, cinnamon, timeshift...)
     ↓
+ CaramOS hooks (Chrome, ChromeOS theme, Vietnamese localization...)
     ↓
= CaramOS ISO
```

### Directory Structure

```
CaramOS/
├── auto/                                  # live-build auto scripts
│   ├── config                             # Build config (base, arch, mirror, Secure Boot)
│   ├── build                              # lb build + logging
│   └── clean                              # lb clean
│
├── config/
│   ├── archives/                          # Additional APT repos
│   │   ├── linuxmint.list.chroot          # Linux Mint repo (Wilma)
│   │   └── linuxmint.list.binary
│   ├── package-lists/
│   │   └── caramos.list.chroot            # Packages to install
│   ├── packages.chroot/                   # Local .deb files to install
│   ├── hooks/live/                        # Scripts run in chroot during build
│   │   ├── 0050-mint-base.hook.chroot     # Import Mint key + install Mint tools
│   │   └── 0100-caramos-setup.hook.chroot # Chrome, theme, icons, cursor, locale
│   ├── includes.chroot/                   # Overlay → / of the ISO
│   │   ├── etc/sddm.conf.d/              # SDDM login screen
│   │   ├── etc/skel/.config/              # Default user config
│   │   │   ├── cinnamon/                  # Chrome OS panel layout
│   │   │   ├── fcitx5/                    # Vietnamese input method
│   │   │   ├── autostart/                 # Flameshot screenshot
│   │   │   └── mimeapps.list              # Chrome as default browser
│   │   └── usr/share/
│   │       ├── glib-2.0/schemas/          # Dconf (theme, icon, font...)
│   │       ├── backgrounds/caramos/       # Wallpapers
│   │       └── pixmaps/                   # Logo
│   ├── includes.binary/                   # Files on ISO (outside filesystem)
│   └── preseed/                           # Auto-answer installer
│
├── debian/                                # Debian packaging → .deb
│   ├── control, changelog, rules
│   ├── install                            # File mapping
│   └── postinst                           # Post-install hook
│
├── Makefile                               # make build / clean / deb
└── README.md, CONTRIBUTING.md, LICENSE
```

### Hook Scripts — Execution Order

| Hook | Runs after | What it does |
|---|---|---|
| `0050-mint-base` | Bootstrap | Import Mint GPG key, `apt-get update`, install mintupdate, mintsystem, timeshift, warpinator... |
| `0100-caramos-setup` | 0050 | Install Chrome .deb, ChromeOS theme, Tela icons, Bibata cursor, remove bloat, set Vietnamese locale, install Be Vietnam Pro font |

### Config Overlay — What Goes Where

| In repo | Destination on ISO |
|---|---|
| `config/includes.chroot/etc/sddm.conf.d/` | `/etc/sddm.conf.d/` |
| `config/includes.chroot/etc/skel/` | `/etc/skel/` |
| `config/includes.chroot/usr/share/glib-2.0/schemas/` | `/usr/share/glib-2.0/schemas/` |
| `config/includes.chroot/usr/share/backgrounds/` | `/usr/share/backgrounds/` |

---

## Build ISO

### Requirements

- Machine running **Ubuntu 22.04+** or **Linux Mint 21+**
- About **10 GB** free disk space
- Internet connection

### Build Commands

```bash
# 1. Install tools (first time only)
sudo apt install live-build debootstrap git

# 2. Clone the repo
git clone https://github.com/VN-Linux-Family/CaramOS.git
cd CaramOS

# 3. Build ISO (single command, fully automated)
make build
```

Wait **15-30 minutes** → `.iso` file is created → write to USB → boot.

### Build .deb Settings Package

```bash
make deb    # → caramos-default-settings.deb
```

### Write to USB

```bash
sudo dd if=*.iso of=/dev/sdX bs=4M status=progress
# Or use Balena Etcher (GUI)
```

### Test in VM

```bash
# QEMU
qemu-system-x86_64 -m 4G -cdrom *.iso -boot d -enable-kvm

# Or use VirtualBox / GNOME Boxes
```

---

## How to Contribute

### How can you help?

| Role | Tasks | Requirements |
|---|---|---|
| **Tester** | Test ISO on different hardware, report bugs | A computer to test on |
| **Designer** | Wallpapers, icons, themes, branding | Graphic design skills |
| **Developer** | Scripts, hooks, configs | Bash, live-build knowledge |
| **Writer** | Documentation, translations | Good Vietnamese/English writing |

### Contribution Workflow

1. **Fork** the repo to your GitHub account
2. **Clone** to your machine:
   ```bash
   git clone https://github.com/<your-username>/CaramOS.git
   cd CaramOS
   ```
3. **Create a new branch**:
   ```bash
   git checkout -b feature/feature-name
   ```
4. **Code** and commit:
   ```bash
   git commit -m "feat: short description"
   ```
5. **Push** and create a **Pull Request**

### Pull Request Rules

- 1 PR = 1 feature or 1 bug fix
- Clearly describe what the PR does and why
- Make sure you've tested before creating the PR
- Wait for at least 1 reviewer to approve

---

## Development Workflow

### Branch Strategy

```
main            ← Stable, used for building release ISOs
├── develop     ← Main development branch
├── feature/*   ← New features
├── fix/*       ← Bug fixes
└── release/*   ← Release preparation
```

### Versioning — Semantic Versioning

```
CaramOS X.Y.Z
X = Major   Y = Minor   Z = Patch

0.1.0  — First beta
1.0.0  — Official release
```

---

## Code Standards

### Commit Messages — [Conventional Commits](https://www.conventionalcommits.org/)

```
feat:     new feature
fix:      bug fix
docs:     documentation
chore:    build, config, CI
brand:    wallpaper, logo, theme
```

### Language Usage

| Context | Language |
|---|---|
| Variable, function names, comments | English |
| Commits, Issues, PRs | Vietnamese or English |
| UI, user documentation | Vietnamese |

### Bash (hook scripts)

```bash
#!/bin/bash
set -e

# Comment explaining each block
echo "[CaramOS] Installing..."
apt-get install -y package-name
```

---

## Bug Reports & Feature Requests

Create an [Issue on GitHub](https://github.com/VN-Linux-Family/CaramOS/issues):

**Bug report:** Description → Steps to reproduce → Expected result → System info → Logs/screenshots

**Feature request:** Description → Reason → Proposed solution

---

<p align="center">
  <strong>CaramOS</strong> — Sweet & Simple Linux<br>
  <a href="https://github.com/VN-Linux-Family/CaramOS">github.com/VN-Linux-Family/CaramOS</a>
</p>
