#!/usr/bin/env bash
# scripts/audit.sh — Non-destructive macOS Environment Audit
# Reads system state and prints a clean markdown summary for AI agents or users.
set -eo pipefail

echo "# macOS System Audit Report"
echo "Generated on: $(date '+%Y-%m-%d %H:%M:%S %Z')"
echo ""

echo "## 1. Hardware & OS"
ARCH="$(uname -m)"
echo "- **Architecture:** \`$ARCH\`"
if command -v sw_vers >/dev/null 2>&1; then
  SW_PRODUCT="$(sw_vers -productName 2>/dev/null || echo 'macOS')"
  SW_VER="$(sw_vers -productVersion 2>/dev/null || echo 'unknown')"
  SW_BUILD="$(sw_vers -buildVersion 2>/dev/null || echo 'unknown')"
  echo "- **OS:** $SW_PRODUCT $SW_VER (Build $SW_BUILD)"
fi
echo ""

echo "## 2. Developer Prerequisites"
if xcode-select -p >/dev/null 2>&1; then
  echo "- **Xcode Command Line Tools:** Installed (\`$(xcode-select -p)\`)"
else
  echo "- **Xcode Command Line Tools:** ❌ Not installed (run \`xcode-select --install\`)"
fi

if command -v brew >/dev/null 2>&1; then
  echo "- **Homebrew:** Installed (\`$(brew --prefix)\`)"
  echo "- **Homebrew Version:** \`$(brew --version | head -n 1)\`"
elif [[ -x /opt/homebrew/bin/brew ]]; then
  echo "- **Homebrew:** Installed at \`/opt/homebrew/bin/brew\` (needs shellenv in PATH)"
else
  echo "- **Homebrew:** ❌ Not installed"
fi
echo ""

echo "## 3. Core Tools & Editors"
check_cmd() {
  local name="$1"
  local cmd="$2"
  if command -v "$cmd" >/dev/null 2>&1; then
    local ver
    ver="$("$cmd" --version 2>/dev/null | head -n 1 || echo 'installed')"
    echo "- **$name:** Installed (\`$ver\`)"
  else
    echo "- **$name:** Not installed"
  fi
}

check_cmd "Ghostty" "ghostty"
check_cmd "Neovim" "nvim"
check_cmd "Starship" "starship"
check_cmd "uv" "uv"
check_cmd "Git" "git"
check_cmd "GitHub CLI (gh)" "gh"
echo ""

echo "## 4. Shell & Existing Dotfiles"
echo "- **Current Shell:** \`$SHELL\`"
check_file() {
  local label="$1"
  local file="$2"
  if [[ -f "$file" || -d "$file" ]]; then
    echo "- **$label:** Exists (\`$file\`)"
  else
    echo "- **$label:** Not found"
  fi
}

check_file "Zsh Config" "$HOME/.zshrc"
check_file "Starship Config" "$HOME/.config/starship.toml"
check_file "Neovim Config" "$HOME/.config/nvim/init.vim"
check_file "Ghostty Config" "$HOME/.config/ghostty/config"
check_file "Git Config" "$HOME/.gitconfig"
check_file "SSH Config" "$HOME/.ssh/config"
echo ""

echo "## 5. Summary Recommendation for AI Agent"
if ! command -v brew >/dev/null 2>&1 && [[ ! -x /opt/homebrew/bin/brew ]]; then
  echo "⚠️ **Next Action:** Install Homebrew first."
else
  echo "✅ Ready to review minimal core and execute \`brew bundle --file=Brewfile\`."
fi
