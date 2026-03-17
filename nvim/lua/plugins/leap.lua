local jump2d = require("mini.jump2d")

jump2d.setup({
  -- Show labels for word-start positions
  spotter = jump2d.gen_pattern_spotter("%S+"),
  view = {
    dim = true,
    n_steps_ahead = 2,
  },
  allowed_lines = {
    blank = false,
    fold = true,
    cursor_at = false,
    cursor_before = true,
    cursor_after = true,
  },
  -- Use single-column labels like leap
  labels = "sfnjklhodweimbuyvrgtaqpcxz",
  silent = false,
})

local opts = { noremap = true, silent = true }

-- s: jump to any word-start (forward/anywhere, same omni-directional as leap)
vim.keymap.set({ "n", "o" }, "s", function()
  jump2d.start(jump2d.builtin_opts.word_start)
end, opts)

-- S: jump to any single character match (type one char, jump to all occurrences)
vim.keymap.set({ "n", "o" }, "S", function()
  jump2d.start(jump2d.builtin_opts.single_character)
end, opts)
