#AGENTS.md — AI Agent Playbook for macOS Developer Setup

You are an AI agent tasked with setting up and configuring a macOS machine for software development.

This repository follows a **Fresh & Minimal Core** philosophy:
1. Install only the lean, essential core environment by default (**Homebrew**, **Ghostty**, **Neovim**, **Starship**, and **Zsh plugins**).
2. Configure clean, fast dotfiles with first-class support for AI agent terminals (preventing prompt hangs in IDE/agent shells).
3. Set up Git and SSH (supporting either a single GitHub account or multi-account SSH routing over Port 443).
4. Keep the machine free of bloat by **asking the user** which optional language runtimes and CLI tools they actually need.

---

## Critical Rules for the Agent

1. **Never Overwrite Without Backup**: Before modifying or replacing any existing file in `$HOME` (such as `~/.zshrc`, `~/.gitconfig`, `~/.ssh/config`, `~/.config/nvim/init.vim`, or `~/.config/ghostty/config`), back up existing files to `~/.dotfiles-backup-$(date +%Y%m%d-%H%M%S)/`.
2. **Zero Personal Info in the Repo**: Never write the user's personal name, email, GitHub username, or SSH keys back into this repository. Only write personalized configs to `$HOME` (`~/.gitconfig`, `~/.ssh/config`, etc.).
3. **Interactive First**: Do not blindly install optional packages. Complete the **Phase 2 User Interview** before running installations.
4. **Apple Silicon & Intel Paths**: Default to `/opt/homebrew` on Apple Silicon (`arm64`) and `/usr/local` on Intel (`x86_64`). Always verify architecture with `uname -m`.

---

## Step-by-Step Execution Workflow

### Phase 1: System Audit (Read-Only)
Run a quick, non-destructive check of the target Mac:
- Check architecture and macOS version: `uname -m && sw_vers`
- Check Xcode Command Line Tools: `xcode-select -p`
- Check Homebrew installation: `which brew || /opt/homebrew/bin/brew --version`
- Check existing dotfiles in `~` and `~/.config`:
  - `~/.zshrc`, `~/.gitconfig`, `~/.ssh/config`
  - `~/.config/nvim`, `~/.config/ghostty`, `~/.config/starship.toml`

Summarize what is already installed vs. what is missing before proceeding to Phase 2.

---

### Phase 2: Interactive User Interview
Ask the user the following questions concisely before making changes:

1. **Core Environment Confirmation**:
   - Confirm installing the minimal core from [`Brewfile`](Brewfile):
     - **Ghostty** (GPU-accelerated terminal emulator with built-in Nerd Font symbols)
     - **Neovim** (`nvim`, aliased to `vim` and `vimdiff`)
     - **Starship** (fast, cross-shell Rust prompt)
     - **Zsh Plugins** (`zsh-autosuggestions`, `zsh-syntax-highlighting`)
2. **Git & GitHub SSH Setup**:
   - Ask if they want:
     - **Option A — Single GitHub Account**: Ask for their `user.name` and `user.email`.
     - **Option B — Multi-Account GitHub Routing**: Ask for their primary (`user.name`, `user.email`, `<ACCOUNT_1>`) and secondary (`user.name`, `user.email`, `<ACCOUNT_2>`) GitHub accounts. Explain that this routes each organization/username to its own `ed25519` SSH key over port 443 (`ssh.github.com`) and switches Git identity automatically via `includeIf`.
     - **Option C — Skip Git/SSH setup** (if already configured).
3. **Optional Tool Packs** (from [`catalog/optional-packages.md`](catalog/optional-packages.md)):
   - Ask which optional stacks they want to install right now (they can pick zero, one, or multiple):
     - **Python (`uv` stack)**: `uv` + `ruff` (manages Python versions, virtualenvs, and CLI tools without `pyenv` overhead)
     - **Git & GitHub CLI**: `gh`, `git-filter-repo`, `pre-commit`
     - **Search & JSON CLI Utilities**: `jq`, `ripgrep` (`rg`), `fd`, `wget`
     - **Node.js / JavaScript**: `node`, `pnpm`, `yarn` (or `fnm` for multi-version Node)
     - **Go**: `go`
     - **Apple / Swift Tooling**: `swiftformat`, `xcbeautify`, `xcode-build-server`
     - **Cloud & Databases**: `gcloud-cli` (cask), `azure-cli`, `postgresql@17`, `pgloader`
     - **Containers**: `orbstack` (lightweight Apple Silicon container runtime) or `docker` (Docker Desktop)
     - **Media & Document Processing**: `ffmpeg`, `imagemagick`, `pandoc`, `mactex` (note: MacTeX is ~5 GB)

---

### Phase 3: Prerequisites & Minimal Core Installation

1. **Xcode Command Line Tools** (if missing):
   ```zsh
   xcode-select --install
   ```
   Wait for the user to complete the macOS dialog if triggered.

2. **Homebrew** (if missing):
   ```zsh
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   eval "$(/opt/homebrew/bin/brew shellenv)"
   ```

3. **Install Minimal Core via [`Brewfile`](Brewfile)**:
   ```zsh
   brew bundle --file=Brewfile
   ```

---

### Phase 4: Dotfiles & Shell Configuration

Back up any existing files first, then install:

1. **Zsh Configuration** ([`dotfiles/zshrc`](dotfiles/zshrc) → `~/.zshrc`):
   - Includes automatic **IDE & AI Agent Terminal Detection** at the very top (`Cursor`, `VS Code`, `Antigravity`). When running inside an IDE/agent terminal, it disables complex prompts and uses a clean single-line prompt with shell integration hooks so agent commands never hang.
   - Outside IDE terminals (e.g., in Ghostty), it loads `Starship`, `zsh-autosuggestions`, and `zsh-syntax-highlighting`.

2. **Starship Prompt** ([`dotfiles/starship.toml`](dotfiles/starship.toml) → `~/.config/starship.toml`):
   - Clean 2-line prompt showing directory, Git branch/status, execution time, and active language runtimes.

3. **Neovim Configuration** ([`dotfiles/nvim/init.vim`](dotfiles/nvim/init.vim) → `~/.config/nvim/init.vim`):
   - Lightweight, zero-plugin setup with syntax highlighting, line numbers, 4-space indentation, incremental search, whitespace visibility, and the `industry` colorscheme.

4. **Ghostty Configuration** ([`dotfiles/ghostty/config`](dotfiles/ghostty/config) → `~/.config/ghostty/config`):
   - Clean macOS configuration with shell integration and comfortable defaults.

---

### Phase 5: Git & SSH Configuration (If Requested)

1. **Global Gitignore**:
   ```zsh
   mkdir -p ~/.config/git
   cp dotfiles/git/gitignore_global ~/.config/git/ignore
   ```

2. **Single-Account Setup**:
   - Populate `~/.gitconfig` with the user's `name` and `email` plus the core settings from [`dotfiles/git/gitconfig.template`](dotfiles/git/gitconfig.template) (omitting the multi-account blocks).
   - If the user needs an SSH key:
     ```zsh
     mkdir -p ~/.ssh && chmod 700 ~/.ssh
     ssh-keygen -t ed25519 -C "<GIT_USER_EMAIL>" -f ~/.ssh/id_ed25519 -N ""
     ssh-add --apple-use-keychain ~/.ssh/id_ed25519
     ```
   - Configure `~/.ssh/config` using the default `Host github.com` block from [`dotfiles/ssh/config.template`](dotfiles/ssh/config.template) (uses `ssh.github.com` over Port 443 so SSH works even on restrictive firewalls).

3. **Multi-Account Setup**:
   - Use [`dotfiles/git/gitconfig.template`](dotfiles/git/gitconfig.template), [`dotfiles/git/gitconfig-profile.template`](dotfiles/git/gitconfig-profile.template), and [`dotfiles/ssh/config.template`](dotfiles/ssh/config.template).
   - Replace placeholders (`<PRIMARY_GITHUB_USER>`, `<SECONDARY_GITHUB_USER>`, `<PRIMARY_NAME>`, `<PRIMARY_EMAIL>`, etc.) with the user's responses.
   - Generate separate keys (`~/.ssh/id_ed25519_<account>`) if they don't exist yet, add them to the macOS Keychain (`ssh-add --apple-use-keychain`), and set `chmod 600 ~/.ssh/config`.
   - Print the public keys (`cat ~/.ssh/id_ed25519*.pub`) or guide the user to upload them to GitHub (`gh ssh-key add` if `gh` is installed).

---

### Phase 6: Optional Tool Packs Installation
Install only the optional packages the user selected in Phase 2 using the commands documented in [`catalog/optional-packages.md`](catalog/optional-packages.md).

- If the user selected **Python (`uv`)**, install Python via `uv`:
  ```zsh
  brew install uv ruff
  uv python install --default
  ```
  *(Note: `~/.local/bin` is already in `~/.zshrc` `PATH` so `uv` default Python binaries `python`/`python3` work out of the box without `pyenv`.)*

---

### Phase 7: Verification
Run these checks and report the results to the user:
1. `zsh -n ~/.zshrc` (verify syntax) and `zsh -i -c 'echo "Shell OK"'`
2. `brew doctor`
3. `nvim --version | head -n 1` and `starship --version`
4. `git config --list --show-origin` (verify user identity and routing rules)
5. If SSH keys were added to GitHub: `ssh -T git@github.com`
