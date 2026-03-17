#!/usr/bin/env bash
# Populates nvim/pack/bundled/start/ with plugin sources at pinned commits.
# Run once on a machine with internet access, then commit the results.
# Re-running a plugin entry replaces it cleanly.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
PACK_DIR="$REPO_ROOT/nvim/pack/bundled/start"

mkdir -p "$PACK_DIR"

clone_plugin() {
  local name="$1"
  local url="$2"
  local ref="$3"   # commit hash or tag

  local dest="$PACK_DIR/$name"

  echo "Bundling $name..."
  rm -rf "$dest"

  local tmpdir
  tmpdir="$(mktemp -d)"
  trap 'rm -rf "$tmpdir"' RETURN

  git clone --quiet --filter=blob:none "$url" "$tmpdir"
  git -C "$tmpdir" checkout --quiet "$ref"

  mkdir -p "$dest"
  for dir in lua plugin after ftplugin syntax queries rplugin colors autoload indent; do
    if [ -d "$tmpdir/$dir" ]; then
      cp -r "$tmpdir/$dir" "$dest/"
    fi
  done

  echo "  ✓ $name"
}

# ── Core UI ───────────────────────────────────────────────────────────────────
clone_plugin "catppuccin"                  "https://github.com/catppuccin/nvim"                                 "5b5e3aef9ad7af84f463d17b5479f06b87d5c429"
clone_plugin "dropbar.nvim"                "https://github.com/Bekaboo/dropbar.nvim"                            "d08bf6b5e2b3bf160050b0f991c1831bf05a7523"

# ── mini.nvim monorepo ────────────────────────────────────────────────────────
# Provides: mini.ai, mini.animate, mini.clue, mini.comment, mini.completion,
#           mini.diff, mini.files, mini.git, mini.hipatterns, mini.icons,
#           mini.jump2d, mini.pairs, mini.starter, mini.statusline, mini.surround
clone_plugin "mini.nvim"                   "https://github.com/echasnovski/mini.nvim"                           "v0.15.0"

# ── Completion & Snippets ────────────────────────────────────────────────────
clone_plugin "friendly-snippets"           "https://github.com/rafamadriz/friendly-snippets"                    "efff286dd74c22f731cdec26a70b46e5b203c619"

# ── Navigation & Search ───────────────────────────────────────────────────────
clone_plugin "telescope.nvim"              "https://github.com/nvim-telescope/telescope.nvim"                   "a4ed82509cecc56df1c7138920a1aeaf246c0ac5"
clone_plugin "plenary.nvim"                "https://github.com/nvim-lua/plenary.nvim"                           "857c5ac632080dba10aae49dba902ce3abf91b35"
clone_plugin "project.nvim"                "https://github.com/ahmedkhalf/project.nvim"                         "8c6bad7d22eef1b71144b401c9f74ed01526a4fb"

# ── Formatting / Linting ──────────────────────────────────────────────────────
clone_plugin "none-ls.nvim"                "https://github.com/nvimtools/none-ls.nvim"                          "a117163db44c256d53c3be8717f3e1a2a28e6299"

# ── Syntax ───────────────────────────────────────────────────────────────────
clone_plugin "nvim-treesitter"             "https://github.com/nvim-treesitter/nvim-treesitter"                 "30654ee72a69e7c76a54b66d748dae088429e863"
clone_plugin "rainbow-delimiters.nvim"     "https://github.com/HiPhish/rainbow-delimiters.nvim"                 "97bf4b8ef9298644a29fcd9dd41a0210cf08cac7"

# ── LSP helpers ───────────────────────────────────────────────────────────────
clone_plugin "outline.nvim"                "https://github.com/hedyhli/outline.nvim"                            "ae473fb51b7b6086de0876328c81a63f9c3ecfef"

echo ""
echo "Done! $(ls "$PACK_DIR" | wc -l | tr -d ' ') plugins bundled in $PACK_DIR"
