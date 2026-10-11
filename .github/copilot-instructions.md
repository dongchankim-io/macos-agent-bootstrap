# GitHub Copilot Agent Instructions

When invoked in this repository or asked to set up a macOS development machine:
- Strictly follow the interactive playbook defined in `AGENTS.md`.
- Use `bash scripts/audit.sh` as the initial non-destructive diagnosis step.
- Follow the fresh and minimal core philosophy (Homebrew, Ghostty, Neovim, Starship, Zsh plugins).
- Always ask the user before installing any optional tool packs from `catalog/optional-packages.md`.
- Never write personalized identity or secret values into repository files.
