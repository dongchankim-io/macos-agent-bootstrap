# CLAUDE.md — Claude Code Instructions

This repository is designed for autonomous or interactive macOS development environment bootstrapping.

## Primary Instructions
When asked to set up, audit, or configure this Mac:
1. Read and strictly follow the step-by-step workflow in [`AGENTS.md`](./AGENTS.md).
2. Run the non-destructive system audit script first:
   ```zsh
   bash scripts/audit.sh
   ```
3. Complete the interactive interview before installing any optional packages.
4. Never write personal names, emails, or SSH keys into this repository — only write personalized configurations to `$HOME` (`~/.gitconfig`, `~/.ssh/config`, etc.).
5. Always back up existing user dotfiles before modifying or replacing them.
