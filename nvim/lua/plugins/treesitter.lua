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
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@call.outer",
        ["ic"] = "@call.inner",
        ["ai"] = "@conditional.outer",
        ["ii"] = "@conditional.inner",
        ["al"] = "@loop.outer",
        ["il"] = "@loop.inner",
        ["ap"] = "@parameter.outer",
        ["ip"] = "@parameter.inner",
      },
    },
    move = {
      enable = true,
      set_jumps = true,
      goto_next_start     = { ["]f"] = "@function.outer", ["]c"] = "@call.outer" },
      goto_next_end       = { ["]F"] = "@function.outer", ["]C"] = "@call.outer" },
      goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@call.outer" },
      goto_previous_end   = { ["[F"] = "@function.outer", ["[C"] = "@call.outer" },
    },
  },
})
