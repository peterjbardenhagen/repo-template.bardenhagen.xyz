# Using This Template with Acode (Android)

[Acode](https://acode.quest/) is a powerful offline code editor for Android. This guide explains how to use the Repo Template effectively with Acode + Termux on Android devices.

## Prerequisites

1. **Install Acode** from [F-Droid](https://f-droid.org/packages/com.adee.nodejs/) or the Play Store
2. **Install Termux** from [F-Droid](https://f-droid.org/packages/com.termux/) (not Play Store — outdated)
3. **Grant Acode storage permissions** so it can access your project directory

## Setup Steps

### 1. Clone the Repository

In Termux:
```bash
pkg update && pkg upgrade -y
pkg install git -y
git clone https://github.com/peterjbardenhagen/repo-template.bardenhagen.xyz.git
cd repo-template.bardenhagen.xyz
```

Or in Acode directly:
- Open Acode → `+` → **Clone Repository** → Paste the repo URL

### 2. Install Development Tools in Termux

```bash
# Core utilities
pkg install git python nodejs make -y

# Pre-commit hooks (for code quality)
pip install pre-commit

# GitHub CLI (for PR management)
pkg install gh -y
```

### 3. Configure Acode

- **Editor settings** → enable **Show ruler**, **Word wrap**, **Minimap**
- **Terminal** → set working directory to your project folder
- **Syntax highlighting** — Acode auto-detects file types; no extra config needed
- **`.editorconfig`** is already included in this template — Acode reads it automatically

### 4. Useful Acode Extensions

Install these from Acode's **Extensions** tab:
- **Prettier** — code formatting
- **ESLint** — JavaScript/TypeScript linting
- **Markdown Preview** — live preview of `.md` files
- **GitLens** — Git integration within Acode
- **Terminal** — inline terminal access

### 5. Running the Makefile in Termux

This template includes a portable `Makefile`. All targets work in Termux:

```makefile
make help     # List available targets
make lint     # Run linters (pre-commit)
make format   # Format code
make test     # Run tests (customize per project)
make build    # Build project artifacts
make dev      # Start dev server (customize per project)
make clean    # Remove build artifacts
```

> **Note:** `make` is available in Termux via `pkg install make`.

### 6. Pre-commit Hooks

```bash
# Install hooks (run once after cloning)
pre-commit install

# Run all hooks on existing files
pre-commit run --all-files
```

### 7. Git Configuration (Termux)

```bash
git config --global user.name "Your Name"
git config --global user.email "you@example.com"

# Optional: Use SSH keys for GitHub
pkg install openssh -y
ssh-keygen -t ed25519 -C "you@example.com"
cat ~/.ssh/id_ed25519.pub
# Copy the output and add it to GitHub: Settings → SSH and GPG keys
```

## Tips for Android Development

- **Use Acode's split-view** to edit files while viewing terminal output
- **External keyboard support** — Acode supports keyboard shortcuts (Ctrl+S to save, Ctrl+F to search)
- **Cloud storage** — sync your project with Syncthing or store on SD card for large projects
- **Termux:Widget** — add quick tiles for frequent commands (e.g., `make test`)

## Troubleshooting

| Problem | Solution |
|---------|----------|
| `make: command not found` | `pkg install make` |
| `pre-commit: command not found` | `pip install pre-commit` |
| Permission denied on scripts | `chmod +x scripts/*.sh` |
| Git push fails | Verify SSH key is added to GitHub |
| Acode can't see files | Check storage permissions and working directory |
