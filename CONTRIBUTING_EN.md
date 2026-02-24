# Contributing Guide — CaramOS

Thank you for your interest in CaramOS! This document describes the development workflow, code standards, and how to contribute to the project.

> [Tiếng Việt](CONTRIBUTING.md) · [README](README_EN.md)

---

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [How to Contribute](#how-to-contribute)
- [Development Workflow](#development-workflow)
- [Language Standards](#language-standards)
- [Bug Reports](#bug-reports)
- [Feature Requests](#feature-requests)

---

## Code of Conduct

See [CODE_OF_CONDUCT_EN.md](CODE_OF_CONDUCT_EN.md). In short:

- Respect all members
- No discrimination
- Focus on building, not destroying
- Give constructive feedback

---

## How to Contribute

### How can you help?

| Role | Tasks | Requirements |
|---|---|---|
| **Tester** | Test ISO on different hardware, report bugs | A computer to test on |
| **Designer** | Wallpapers, icons, themes, branding | Graphic design skills |
| **Developer** | Scripts, Caram Center, Welcome App | Python, Bash, GTK |
| **Writer** | Documentation, translations | Good Vietnamese/English writing |
| **Packager** | Package apps, write YAML configs for Caram Center | Wine/Bottles/Flatpak knowledge |

### Contribution workflow

1. **Fork** the repo to your GitHub account
2. **Clone** to your machine:
   ```bash
   git clone https://github.com/<your-username>/CaramOS.git
   cd CaramOS
   ```
3. **Create a new branch** from `main`:
   ```bash
   git checkout -b feature/feature-name
   ```
4. **Code** and commit:
   ```bash
   git add .
   git commit -m "feat: short description"
   ```
5. **Push** to your fork:
   ```bash
   git push origin feature/feature-name
   ```
6. Create a **Pull Request** on GitHub

### Pull Request rules

- 1 PR = 1 feature or 1 bug fix
- Clearly describe what the PR does and why
- Make sure you've tested before creating the PR
- If the PR involves UI changes, attach screenshots
- Wait for at least 1 reviewer to approve

---

## Development Workflow

### Branch strategy

```
main            <- Stable, used for building release ISOs
├── develop     <- Main development branch, merge features here
├── feature/*   <- New features (feature/caram-center, feature/ai-assistant)
├── fix/*       <- Bug fixes (fix/wifi-driver, fix/locale-bug)
└── release/*   <- Release prep (release/0.1-beta, release/1.0)
```

### Release process

```
1. Develop on develop branch
2. When enough features are ready -> create release/x.y branch
3. Thorough testing on release branch
4. Merge into main -> tag version -> build ISO -> publish
```

### Versioning

We use **Semantic Versioning**:

```
CaramOS X.Y.Z

X = Major  — large changes, may not be backwards compatible
Y = Minor  — new features, backwards compatible
Z = Patch  — bug fixes

Examples:
  0.1.0  — First beta
  0.2.0  — Add Caram Center GUI
  1.0.0  — Official release
  1.0.1  — Fix WiFi driver bug
  1.1.0  — Add offline AI
```

---

## Language Standards

### Commit messages

Use [Conventional Commits](https://www.conventionalcommits.org/) format:

```
<type>: <short description>

type:
  feat     — new feature
  fix      — bug fix
  docs     — documentation
  style    — code formatting (no logic changes)
  refactor — code restructuring
  test     — add/fix tests
  chore    — miscellaneous (build, config, CI)
  brand    — branding (wallpaper, logo, theme)

Examples:
  feat: add Caram Center GUI
  fix: fcitx5-lotus not enabled by default
  docs: add dual-boot installation guide
  brand: update default wallpaper
```

### Language usage in code

| Context | Language | Example |
|---|---|---|
| **Variable, function, class names** | English | `def install_package()` |
| **Code comments** | English | `# Check if driver is installed` |
| **Commit messages** | English or Vietnamese | `feat: add Caram Center` |
| **Issues, PRs** | Vietnamese or English | Up to the author |
| **User documentation** | Vietnamese (primary) | Installation guide |
| **README** | Vietnamese (primary) + English | Separate files |
| **UI/interface** | Vietnamese | "Cai dat", "Cap nhat" |

### Python (Caram Center, Welcome App)

- Python 3.10+
- GUI: GTK 4 or GTK 3 (via PyGObject)
- Formatter: [Black](https://github.com/psf/black) (line length 88)
- Linter: flake8
- File names: `snake_case.py`
- Class names: `PascalCase`
- Function/variable names: `snake_case`

```python
# Example
class CaramCenter:
    """Main application for managing Windows app installation."""

    def install_app(self, app_name: str) -> bool:
        """Install a Windows application via Bottles or Webapp Manager."""
        config = self._load_app_config(app_name)
        ...
```

### Bash (build scripts)

- Shebang: `#!/bin/bash`
- Use `set -euo pipefail` at the top
- File names: `kebab-case.sh`
- Comment each block of commands

```bash
#!/bin/bash
set -euo pipefail

# Install Vietnamese input method
apt install -y fcitx5-lotus

# Set Vietnamese locale as default
sed -i 's/en_US.UTF-8/vi_VN.UTF-8/' /etc/default/locale
```

### YAML (Caram Center app configs)

```yaml
# Example: apps/zalo.yaml
name: Zalo
description: Popular messaging app in Vietnam
method: webapp              # webapp | bottles | snap | flatpak
url: https://chat.zalo.me   # Only for method: webapp
icon: zalo.png
category: communication
```

---

## Bug Reports

Create an Issue at [GitHub Issues](https://github.com/VN-Linux-Family/CaramOS/issues) with:

1. **Bug description** — What happened?
2. **Steps to reproduce** — How to trigger the bug?
3. **Expected result** — What should have happened?
4. **System info** — CaramOS version, hardware (CPU, GPU, WiFi chip)
5. **Screenshots/logs** — If available

---

## Feature Requests

Create an Issue with the `feature-request` label:

1. **Feature description** — What do you want?
2. **Reason** — Why is this feature needed?
3. **Proposed solution** — How do you imagine it working?

---

<p align="center">
  <strong>CaramOS</strong> — Sweet & Simple Linux<br>
  <a href="https://github.com/VN-Linux-Family/CaramOS">github.com/VN-Linux-Family/CaramOS</a>
</p>
