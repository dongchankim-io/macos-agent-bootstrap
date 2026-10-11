# Optional Tool Packs Catalog

To keep a new Mac fresh and fast, these packages are **not** installed by default.
When setting up a machine, the AI agent should ask the user which of these packs (or individual tools) they want to install.

---

## 1. Python (`uv` Modern Stack)
Replaces `pyenv`, `pip`, `pipx`, and `virtualenv` with a single fast Rust binary.
```zsh
brew install uv ruff
# Install latest stable Python and expose `python` / `python3` in ~/.local/bin
uv python install --default
```
*Need a specific Python version for a project?* Run `uv python install 3.12` or `uv venv --python 3.13`.

---

## 2. Git & GitHub CLI Tools
```zsh
brew install gh git-filter-repo pre-commit
```
- `gh`: GitHub CLI (`gh auth login`, PRs, issues, SSH key upload)
- `git-filter-repo`: Fast repository history rewriting and secret scrubbing
- `pre-commit`: Git hook management

---

## 3. Search & CLI Utilities (Recommended for AI Agents)
```zsh
brew install jq ripgrep fd wget
```
- `jq`: Command-line JSON processor
- `ripgrep` (`rg`): Fast regex search across repositories
- `fd`: Fast file finder
- `wget`: Network downloader

---

## 4. Node.js & JavaScript Package Managers
```zsh
brew install node pnpm yarn
```
*(Alternative: If multi-version Node management is preferred over Homebrew's single `node` formula, install `fnm` via `brew install fnm` and add `eval "$(fnm env --use-on-cd --shell zsh)"` to `~/.zshrc.local`.)*

---

## 5. Go
```zsh
brew install go
```

---

## 6. Apple / Swift / Xcode Tooling
```zsh
brew install swiftformat xcbeautify xcode-build-server
```
- `swiftformat`: Code formatter for Swift
- `xcbeautify`: Fast, clean formatter for `xcodebuild` output
- `xcode-build-server`: Build server protocol integration (`sourcekit-lsp`) for Neovim/Cursor/VS Code

---

## 7. Cloud SDKs & Databases
```zsh
# Google Cloud CLI (installed declaratively as a Cask)
brew install --cask gcloud-cli

# Azure CLI + Azure Functions Core Tools
brew tap azure/functions
brew install azure-cli

# PostgreSQL & Migration Tooling
brew install postgresql@17 pgloader
```
*(If using `gcloud-cli` via Homebrew Cask, source `$(brew --prefix)/share/google-cloud-sdk/path.zsh.inc` and `completion.zsh.inc` in `~/.zshrc.local`.)*

---

## 8. Containers & Virtualization
Choose one:
```zsh
# Option A: OrbStack (lightweight, fast macOS container & Linux VM runtime)
brew install --cask orbstack

# Option B: Docker Desktop
brew install --cask docker
```

---

## 9. Media, Documents & LaTeX
```zsh
# Media & document conversion
brew install ffmpeg imagemagick pandoc

# Full TeX Live distribution (~5 GB download; install only if compiling LaTeX locally)
brew install --cask mactex
```
