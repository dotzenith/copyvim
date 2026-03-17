---@diagnostic disable-next-line: missing-fields
require("nvim-treesitter.configs").setup({
  -- Parsers are NOT auto-installed. Install manually via :TSInstall <lang>
  -- or copy pre-compiled .so files to ~/.local/share/nvim/parser/
  ensure_installed = {},
  auto_install = false,
  sync_install = false,
  ignore_install = { "" },
  highlight = {
    enable = true,
    disable = {},
    additional_vim_regex_highlighting = false,
  },
  indent = { enable = true, disable = { "yaml", "c" } },
  rainbow = {
    enable = true,
    extended_mode = true,
    max_file_lines = nil,
  },
})

-- mini.ai: enhanced text objects with TreeSitter support
-- Replaces nvim-treesitter-textobjects text object selection
local spec_ts = require("mini.ai").gen_spec.treesitter

require("mini.ai").setup({
  n_lines = 500,
  custom_textobjects = {
    -- function
    f = spec_ts({ a = "@function.outer", i = "@function.inner" }),
    -- call
    c = spec_ts({ a = "@call.outer",     i = "@call.inner" }),
    -- conditional
    i = spec_ts({ a = "@conditional.outer", i = "@conditional.inner" }),
    -- loop
    l = spec_ts({ a = "@loop.outer",     i = "@loop.inner" }),
    -- parameter
    p = spec_ts({ a = "@parameter.outer", i = "@parameter.inner" }),
  },
})
