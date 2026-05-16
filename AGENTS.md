# CaramOS - Linux Distribution (ISO Remaster)

## Project Overview

CaramOS là bản phân phối Linux dựa trên Linux Mint 22 (Ubuntu 24.04 LTS), thiết kế cho người dùng Việt Nam. Build method: ISO Remaster — extract source ISO → customize (packages, overlay, hooks) → repack (squashfs + xorriso).

## Project Structure

```
./
├── build.sh           # Main build script (entry point)
├── Makefile           # Build targets wrapper
├── scripts/           # Build modules
│   ├── config.sh      # Version, mirror, output config
│   ├── utils.sh       # Log, deps check, ISO download
│   ├── extract.sh     # Mount ISO + rsync + unsquashfs
│   ├── customize.sh   # Chroot + packages + overlay + hooks
│   ├── repack.sh      # mksquashfs + xorriso → ISO
│   ├── boot_config.sh # Boot menu + Plymouth branding
│   ├── overlay.sh     # Copy includes.chroot into rootfs
│   ├── chroot_shell.sh# Debug chroot
│   └── debug_iso.sh   # Check boot splash/Plymouth
├── config/
│   ├── packages.txt   # Packages to add (plank, fcitx5, chrome...)
│   ├── hooks/live/    # Hooks run inside chroot
│   │   └── NNNN-name.hook.chroot  # Named by priority (0100, 0200...)
│   └── includes.chroot/ # Overlay files copied to rootfs
│       ├── etc/       # dconf, lightdm, skel, locale, hostname
│       └── usr/share/ # applications, backgrounds, icons, themes
├── docker-compose.yml # Docker builder config
├── Dockerfile         # Ubuntu 24.04 base for containerized build
└── assets/            # Logo, banner images
```

## Build Commands

### Local Build (Ubuntu/Mint/Debian only)

- `make build` — Full dev build (lz4 compression, fast)
- `make release` — Release build (xz compression, smaller ISO)
- `make prepare` — Extract ISO to build/ tree for quick edits
- `make quick` — Prepare if needed → overlay → repack (fast iteration)
- `make overlay` — Copy includes.chroot into rootfs only
- `make customize-only` — Run packages + overlay + hooks
- `make repack` — Repack squashfs + ISO from existing work tree
- `make iso-only` — Regenerate ISO only from build/custom
- `make shell` — Enter chroot build/squashfs for manual debug
- `make boot-only` — Apply boot config + Plymouth branding only
- `make clean` — Remove all build/cache/output (keep source ISO)

### Docker Build (Any OS)

- `make docker-build` — Dev build in Docker container
- `make docker-release` — Release build in Docker container
- `make docker-clean` — Clean build via Docker

### Debug

- `make debug-iso` — Check boot menu/Plymouth status
- `make debug-iso ISO=filename.iso` — Check specific ISO

### Parameters

- `make build ISO=linuxmint-22.3-cinnamon-64bit.iso` — Build from existing ISO

## Build Workflow

```
1. extract.sh     Mount source ISO → rsync filesystem → unsquashfs
   → build/squashfs/ (read-only base)
   → build/custom/ (working tree)

2. customize.sh   chroot into build/custom/
   → Install packages from config/packages.txt
   → Copy config/includes.chroot/ overlay
   → Run config/hooks/live/*.hook.chroot scripts

3. repack.sh      mksquashfs build/custom/ → build/CaramOS.sfs
   → xorriso → CaramOS-VERSION-cinnamon-amd64.iso
```

## Conventions

### Hook Files

- Location: `config/hooks/live/`
- Naming: `NNNN-name.hook.chroot` (4-digit priority prefix)
- Execution order: Ascending numeric (0100, 0200, 0900...)
- Example: `0100-caramos-setup.hook.chroot`

### Bash Scripts

- Use `set -e` for error handling
- All scripts under `scripts/` are modular — can run standalone with `--help`

### Version Config

- Edit `scripts/config.sh` to change: MINT_VERSION, CARAMOS_VERSION, MIRROR, OUTPUT_ISO
- Default compression: lz4 (fast dev), xz for release

### Output

- ISO output: `CaramOS-${CARAMOS_VERSION}-cinnamon-amd64.iso`
- Build artifacts: `./build/` directory
- Source ISO kept intact in cache/ after extract

## Important Notes

### Requirements

- Build requires **sudo/root** (mount, chroot, loop operations)
- Local build: Ubuntu 24.04/Mint 22/Debian base
- Docker build works on any OS (macOS, Windows, any Linux distro)

### Docker Recommended

Use Docker for build if not on Ubuntu 24.04:

```bash
docker compose up --build builder
# or simply:
make docker-build
```

### CI/CD

GitHub Actions workflow in `.github/workflows/build.yml` builds on Ubuntu 24.04 runners.

### Git Workflow

- Commit format: `[build]`, `[config]`, `[assets]`, `[docs]` prefix
- AGENTS.md: Commit to Git for team shared context
- No .claudeignore needed — project is not TypeScript/Node.js
