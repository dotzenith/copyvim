-- Load colorscheme first so all other UI elements inherit the right colors
require("plugins.colorscheme")

-- Icons needed by mini.statusline, telescope, mini.starter, etc.
require("plugins.mini-icons")

-- mini.clue must come before gitsigns/telescope so key groups register first
require("plugins.whichkey")

require("plugins.alpha")
require("plugins.autopairs")
require("plugins.colorizer")
require("plugins.comment")
require("plugins.completion")
require("plugins.dropbar")
require("plugins.gitsigns")
require("plugins.leap")
require("plugins.lualine")
require("plugins.mini-surround")
require("plugins.mini-tree")
require("plugins.neoscroll")
require("plugins.none-ls")
require("plugins.outline")
require("plugins.project")
require("plugins.telescope")
require("plugins.treesitter")
