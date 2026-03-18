-- Load colorscheme first so all other UI elements inherit the right colors
require("plugins.colorscheme")

-- Icons needed by mini.statusline, mini.starter, etc.
require("plugins.mini-icons")

-- mini.clue must come before mini-git/mini-pick so key groups register first
require("plugins.mini-clue")

require("plugins.mini-animate")
require("plugins.mini-comment")
require("plugins.mini-git")
require("plugins.mini-hipatterns")
require("plugins.mini-jump2d")
require("plugins.mini-pairs")
require("plugins.mini-pick")
require("plugins.mini-starter")
require("plugins.mini-statusline")
require("plugins.mini-surround")
require("plugins.mini-tree")
require("plugins.completion")
require("plugins.dropbar")
require("plugins.none-ls")
require("plugins.outline")
require("plugins.project")
require("plugins.treesitter")
