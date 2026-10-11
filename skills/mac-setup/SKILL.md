---
name: mac-setup
description: Audits, bootstraps, and interactively configures a fresh, minimal macOS development environment (Homebrew, Ghostty, Neovim, Starship, uv, and multi-account Git/SSH).
---

# macOS Developer Setup Skill

This skill allows an AI agent to guide a user through setting up a fresh or existing Mac for software development following the minimal-core philosophy.

## When to Use This Skill
- The user asks to configure or bootstrap a new Mac.
- The user wants to audit their existing macOS setup.
- The user wants clean, agent-safe dotfiles (`.zshrc`, Starship, Neovim, Ghostty).
- The user wants to set up single or multi-account GitHub SSH and Git identities.

## Execution Procedure
1. Run `bash scripts/audit.sh` to get an instant snapshot of the machine.
2. Follow the detailed steps in [AGENTS.md](../../AGENTS.md).
3. Back up existing user configurations before overwriting any dotfiles in `$HOME`.
4. Ask the user before installing any optional tools from [catalog/optional-packages.md](../../catalog/optional-packages.md).
