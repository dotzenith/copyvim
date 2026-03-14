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
clone_plugin "alpha-nvim"                  "https://github.com/goolord/alpha-nvim"                              "de72250e054e5e691b9736ee30db72c65d560771"
clone_plugin "catppuccin"                  "https://github.com/catppuccin/nvim"                                 "5b5e3aef9ad7af84f463d17b5479f06b87d5c429"
clone_plugin "dropbar.nvim"                "https://github.com/Bekaboo/dropbar.nvim"                            "d08bf6b5e2b3bf160050b0f991c1831bf05a7523"
clone_plugin "lualine.nvim"                "https://github.com/nvim-lualine/lualine.nvim"                       "1517caa8fff05e4b4999857319d3b0609a7f57fa"
clone_plugin "lsp-progress.nvim"           "https://github.com/linrongbin16/lsp-progress.nvim"                  "f3df1df8f5ea33d082db047b5d2d2b83cc01cd8a"

# ── mini.nvim monorepo (provides mini.completion, mini.files, mini.icons, mini.surround) ──
clone_plugin "mini.nvim"                   "https://github.com/echasnovski/mini.nvim"                           "v0.15.0"

# ── Completion & Snippets ────────────────────────────────────────────────────
clone_plugin "friendly-snippets"           "https://github.com/rafamadriz/friendly-snippets"                    "efff286dd74c22f731cdec26a70b46e5b203c619"

# ── Editor features ──────────────────────────────────────────────────────────
clone_plugin "nvim-autopairs"              "https://github.com/windwp/nvim-autopairs"                           "84a81a7d1f28b381b32acf1e8fe5ff5bef4f7968"
clone_plugin "nvim-colorizer.lua"          "https://github.com/catgoose/nvim-colorizer.lua"                     "517df88cf2afb36652830df2c655df2da416a0ae"
clone_plugin "ts-comments.nvim"            "https://github.com/folke/ts-comments.nvim"                          "123a9fb12e7229342f807ec9e6de478b1102b041"
clone_plugin "neoscroll.nvim"              "https://github.com/karb94/neoscroll.nvim"                           "f957373912e88579e26fdaea4735450ff2ef5c9c"
clone_plugin "leap.nvim"                   "https://codeberg.org/andyg/leap.nvim.git"                           "af1dedf49efe203b98c65970a6bb652af256b882"
clone_plugin "vim-repeat"                  "https://github.com/tpope/vim-repeat"                                "65846025c15494983dafe5e3b46c8f88ab2e9635"

# ── Navigation & Search ───────────────────────────────────────────────────────
clone_plugin "telescope.nvim"              "https://github.com/nvim-telescope/telescope.nvim"                   "a4ed82509cecc56df1c7138920a1aeaf246c0ac5"
clone_plugin "plenary.nvim"                "https://github.com/nvim-lua/plenary.nvim"                           "857c5ac632080dba10aae49dba902ce3abf91b35"
clone_plugin "project.nvim"                "https://github.com/ahmedkhalf/project.nvim"                         "8c6bad7d22eef1b71144b401c9f74ed01526a4fb"

# ── Git ───────────────────────────────────────────────────────────────────────
clone_plugin "gitsigns.nvim"               "https://github.com/lewis6991/gitsigns.nvim"                         "3c76f7fabac723aa682365ef782f88a83ccdb4ac"

# ── Formatting / Linting ──────────────────────────────────────────────────────
clone_plugin "none-ls.nvim"                "https://github.com/nvimtools/none-ls.nvim"                          "a117163db44c256d53c3be8717f3e1a2a28e6299"

# ── Syntax ───────────────────────────────────────────────────────────────────
clone_plugin "nvim-treesitter"             "https://github.com/nvim-treesitter/nvim-treesitter"                 "30654ee72a69e7c76a54b66d748dae088429e863"
clone_plugin "nvim-treesitter-textobjects" "https://github.com/nvim-treesitter/nvim-treesitter-textobjects"     "9937e5e356e5b227ec56d83d0a9d0a0f6bc9cad4"
clone_plugin "rainbow-delimiters.nvim"     "https://github.com/HiPhish/rainbow-delimiters.nvim"                 "97bf4b8ef9298644a29fcd9dd41a0210cf08cac7"

# ── LSP helpers ───────────────────────────────────────────────────────────────
clone_plugin "outline.nvim"                "https://github.com/hedyhli/outline.nvim"                            "ae473fb51b7b6086de0876328c81a63f9c3ecfef"

# ── Keybindings ───────────────────────────────────────────────────────────────
clone_plugin "which-key.nvim"              "https://github.com/folke/which-key.nvim"                            "370ec46f710e058c9c1646273e6b225acf47cbed"

echo ""
echo "Done! $(ls "$PACK_DIR" | wc -l | tr -d ' ') plugins bundled in $PACK_DIR"
