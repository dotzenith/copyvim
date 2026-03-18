local diff = require("mini.diff")

diff.setup({
  view = {
    style = "sign",
    signs = {
      add    = "▎",
      change = "▎",
      delete = "_",
    },
    priority = 6,
  },
  delay = {
    text_change = 100,
  },
  source = diff.gen_source.git(),
})

require("mini.git").setup()

local opts = { noremap = true, silent = true }

-- Hunk navigation
vim.keymap.set("n", "<leader>gj", function()
  diff.goto_hunk("next", { n_times = vim.v.count1 })
end, vim.tbl_extend("force", opts, { desc = "Next Hunk" }))

vim.keymap.set("n", "<leader>gk", function()
  diff.goto_hunk("prev", { n_times = vim.v.count1 })
end, vim.tbl_extend("force", opts, { desc = "Prev Hunk" }))

-- Preview overlay (toggle diff inline)
vim.keymap.set("n", "<leader>gp", diff.toggle_overlay,
  vim.tbl_extend("force", opts, { desc = "Preview Hunk (Toggle Overlay)" }))

-- Reset hunk using mini.diff operator on the hunk range
vim.keymap.set("n", "<leader>gr", function()
  diff.goto_hunk("next", { n_times = 0 })
  vim.cmd("norm! V")
  diff.operator("reset")
end, vim.tbl_extend("force", opts, { desc = "Reset Hunk" }))

-- Stage hunk using mini.diff operator
vim.keymap.set("n", "<leader>gs", function()
  diff.operator("apply")
end, vim.tbl_extend("force", opts, { desc = "Stage Hunk (Apply)" }))

-- Git diff vs HEAD
vim.keymap.set("n", "<leader>gd", function()
  MiniGit.show_diff_source()
end, vim.tbl_extend("force", opts, { desc = "Git Diff" }))

-- Blame current line (shows in a split)
vim.keymap.set("n", "<leader>gl", function()
  MiniGit.show_at_cursor()
end, vim.tbl_extend("force", opts, { desc = "Blame / Git Info" }))

-- Show full buffer history
vim.keymap.set("n", "<leader>gR", function()
  MiniGit.show_range_history()
end, vim.tbl_extend("force", opts, { desc = "Buffer History (Reset ref)" }))

-- Show current commit
vim.keymap.set("n", "<leader>gu", function()
  MiniGit.show_at_cursor()
end, vim.tbl_extend("force", opts, { desc = "Show Commit at Cursor" }))
