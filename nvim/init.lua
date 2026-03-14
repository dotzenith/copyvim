vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("base")

-- Load all plugins from pack/bundled/start/
vim.cmd("packloadall")

-- Run plugin setup
require("plugins")
