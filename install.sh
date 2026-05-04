#!/usr/bin/env bash
set -euo pipefail

SKIP_CLONE=false
for arg in "$@"; do
  [[ "$arg" == "--skip-clone" ]] && SKIP_CLONE=true
done

echo ""
echo "╔══════════════════════════════════════════╗"
echo "║         NVIM INSTALLER  C:\\SETUP>_        ║"
echo "╚══════════════════════════════════════════╝"
echo ""

OS="$(uname -s)"

# ── Abort on Windows ─────────────────────────────────────────────────────────
if [[ "$OS" == MINGW* || "$OS" == CYGWIN* || "$OS" == MSYS* ]]; then
  echo "ERROR: Windows not yet supported. Use WSL or wait for install.ps1."
  exit 1
fi

# ── Install deps ─────────────────────────────────────────────────────────────
echo ">>> Installing dependencies..."

if [[ "$OS" == "Darwin" ]]; then
  if ! command -v brew &>/dev/null; then
    echo "Homebrew not found. Install it from https://brew.sh then re-run."
    exit 1
  fi

  BREWS=(neovim ripgrep fd fzf node git python3)
  for pkg in "${BREWS[@]}"; do
    if brew list --formula "$pkg" &>/dev/null; then
      echo "    [ok] $pkg"
    else
      echo "    [installing] $pkg"
      brew install "$pkg"
    fi
  done

  # MartianMono Nerd Font
  if brew list --cask font-martian-mono &>/dev/null 2>&1 || \
     fc-list 2>/dev/null | grep -qi "MartianMono"; then
    echo "    [ok] MartianMono Nerd Font"
  else
    echo "    [installing] MartianMono Nerd Font"
    brew install --cask font-martian-mono 2>/dev/null || \
      echo "    [warn] Font cask not found — install MartianMono Nerd Font manually."
  fi

elif [[ "$OS" == "Linux" ]]; then
  if command -v apt &>/dev/null; then
    sudo apt update -qq
    sudo apt install -y neovim ripgrep fd-find fzf nodejs git python3 python3-pip
    # fd-find installs as 'fdfind'; alias to fd
    if ! command -v fd &>/dev/null && command -v fdfind &>/dev/null; then
      mkdir -p ~/.local/bin
      ln -sf "$(which fdfind)" ~/.local/bin/fd
    fi
  else
    echo "[warn] Only apt-based Linux is auto-supported. Install neovim, ripgrep, fd, fzf, node, git, python3 manually."
  fi
  echo "[note] Install MartianMono Nerd Font manually on Linux: https://www.nerdfonts.com"
fi

# ── Verify personal org dir ──────────────────────────────────────────────────
ORG_DIR="$HOME/Nextcloud/Documents/org"
if [[ -d "$ORG_DIR" ]]; then
  echo ">>> [ok] Personal org dir: $ORG_DIR"
else
  echo ">>> [warn] Personal org dir not found at $ORG_DIR"
  echo "           Nextcloud may not have synced yet. Org keybindings will work once it appears."
fi

# ── Verify Cryptex vault ─────────────────────────────────────────────────────
CRYPTEX="$HOME/Nextcloud/Cryptex"
if [[ -d "$CRYPTEX" ]]; then
  echo ">>> [ok] Cryptex zettel vault: $CRYPTEX"
else
  echo ">>> [warn] Cryptex vault not found at $CRYPTEX"
  echo "           Obsidian.nvim keybindings will error until the vault is present."
fi

# ── Back up existing config ──────────────────────────────────────────────────
NVIM_DIR="$HOME/.config/nvim"
if [[ -d "$NVIM_DIR" && "$SKIP_CLONE" == false ]]; then
  BAK="$HOME/.config/nvim.bak.$(date +%Y%m%d%H%M%S)"
  echo ">>> Backing up existing config to $BAK"
  mv "$NVIM_DIR" "$BAK"
fi

# ── Clone repo ───────────────────────────────────────────────────────────────
if [[ "$SKIP_CLONE" == false ]]; then
  echo ">>> Cloning config repo..."
  git clone https://github.com/SurreptitiousSR/nvim.git "$NVIM_DIR"
fi

# ── Sync plugins ─────────────────────────────────────────────────────────────
echo ">>> Syncing plugins (this may take a minute)..."
nvim --headless "+Lazy! sync" +qa 2>&1 | tail -5

# ── Treesitter parsers ────────────────────────────────────────────────────────
echo ">>> Compiling treesitter parsers..."
nvim --headless "+TSUpdateSync" +qa 2>&1 | tail -5

# ── Mason LSP servers ─────────────────────────────────────────────────────────
echo ">>> Installing LSP servers via Mason..."
nvim --headless \
  "+MasonInstall pyright ts_ls html cssls bashls yamlls taplo dockerls marksman" \
  +qa 2>&1 | tail -5

echo ""
echo "╔══════════════════════════════════════════╗"
echo "║  SETUP COMPLETE — open nvim and run      ║"
echo "║  :checkhealth to verify everything.      ║"
echo "╚══════════════════════════════════════════╝"
echo ""
