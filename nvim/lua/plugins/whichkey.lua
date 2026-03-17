local clue = require("mini.clue")

clue.setup({
  triggers = {
    -- Leader
    { mode = "n", keys = "<Leader>" },
    { mode = "x", keys = "<Leader>" },
    -- g prefix
    { mode = "n", keys = "g" },
    { mode = "x", keys = "g" },
    -- Bracket navigation
    { mode = "n", keys = "[" },
    { mode = "n", keys = "]" },
    -- Window commands
    { mode = "n", keys = "<C-w>" },
    -- Marks / registers
    { mode = "n", keys = "'" },
    { mode = "n", keys = "`" },
    { mode = "n", keys = '"' },
    { mode = "i", keys = "<C-r>" },
    -- z commands
    { mode = "n", keys = "z" },
  },

  clues = {
    -- Built-in helpers
    clue.gen_clues.g(),
    clue.gen_clues.marks(),
    clue.gen_clues.registers(),
    clue.gen_clues.windows(),
    clue.gen_clues.z(),

    -- ── Groups ────────────────────────────────────────────────────────────
    { mode = "n", keys = "<leader>f",  desc = "+Find" },
    { mode = "n", keys = "<leader>g",  desc = "+Git" },
    { mode = "n", keys = "<leader>l",  desc = "+LSP" },
    { mode = "n", keys = "<leader>s",  desc = "+Surround" },

    -- ── Find / Telescope ──────────────────────────────────────────────────
    { mode = "n", keys = "<leader>fb",  desc = "Show Buffers" },
    { mode = "n", keys = "<leader>fd",  desc = "Diagnostics" },
    { mode = "n", keys = "<leader>ff",  desc = "Find Files" },
    { mode = "n", keys = "<leader>fgb", desc = "Git Branches" },
    { mode = "n", keys = "<leader>fh",  desc = "Help Tags" },
    { mode = "n", keys = "<leader>fo",  desc = "Recent Files" },
    { mode = "n", keys = "<leader>fp",  desc = "Projects" },
    { mode = "n", keys = "<leader>fr",  desc = "LSP References" },
    { mode = "n", keys = "<leader>ft",  desc = "Find Text" },

    -- ── Git ───────────────────────────────────────────────────────────────
    { mode = "n", keys = "<leader>gR",  desc = "Buffer History" },
    { mode = "n", keys = "<leader>gd",  desc = "Git Diff" },
    { mode = "n", keys = "<leader>gj",  desc = "Next Hunk" },
    { mode = "n", keys = "<leader>gk",  desc = "Prev Hunk" },
    { mode = "n", keys = "<leader>gl",  desc = "Blame / Git Info" },
    { mode = "n", keys = "<leader>gp",  desc = "Preview Hunk (Toggle Overlay)" },
    { mode = "n", keys = "<leader>gr",  desc = "Reset Hunk" },
    { mode = "n", keys = "<leader>gs",  desc = "Stage Hunk (Apply)" },
    { mode = "n", keys = "<leader>gu",  desc = "Show Commit at Cursor" },

    -- ── LSP ───────────────────────────────────────────────────────────────
    { mode = "n", keys = "<leader>la",  desc = "Code Action" },
    { mode = "n", keys = "<leader>lf",  desc = "Format" },
    { mode = "n", keys = "<leader>li",  desc = "Info" },
    { mode = "n", keys = "<leader>lj",  desc = "Next Diagnostic" },
    { mode = "n", keys = "<leader>lk",  desc = "Prev Diagnostic" },
    { mode = "n", keys = "<leader>ll",  desc = "CodeLens Action" },
    { mode = "n", keys = "<leader>lq",  desc = "Quickfix" },
    { mode = "n", keys = "<leader>lr",  desc = "Rename" },

    -- ── Surround ──────────────────────────────────────────────────────────
    { mode = "n", keys = "<leader>sa",  desc = "Add Surrounding" },
    { mode = "n", keys = "<leader>sd",  desc = "Delete Surrounding" },
    { mode = "n", keys = "<leader>sf",  desc = "Find Surrounding Right" },
    { mode = "n", keys = "<leader>sF",  desc = "Find Surrounding Left" },
    { mode = "n", keys = "<leader>sh",  desc = "Highlight Surrounding" },
    { mode = "n", keys = "<leader>sr",  desc = "Replace Surrounding" },
  },

  window = {
    delay = 500,
    config = {
      border = "none",
      width  = "auto",
    },
  },
})

-- LSP keymaps (moved here from whichkey.lua groups)
local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>",                 vim.tbl_extend("force", opts, { desc = "Code Action" }))
vim.keymap.set("n", "<leader>lf", "<cmd>lua vim.lsp.buf.format({ async = true })<cr>",      vim.tbl_extend("force", opts, { desc = "Format" }))
vim.keymap.set("n", "<leader>li", "<cmd>LspInfo<cr>",                                        vim.tbl_extend("force", opts, { desc = "Info" }))
vim.keymap.set("n", "<leader>lj", "<cmd>lua vim.diagnostic.goto_next()<cr>",                 vim.tbl_extend("force", opts, { desc = "Next Diagnostic" }))
vim.keymap.set("n", "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev()<cr>",                 vim.tbl_extend("force", opts, { desc = "Prev Diagnostic" }))
vim.keymap.set("n", "<leader>ll", "<cmd>lua vim.lsp.codelens.run()<cr>",                     vim.tbl_extend("force", opts, { desc = "CodeLens Action" }))
vim.keymap.set("n", "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<cr>",                vim.tbl_extend("force", opts, { desc = "Quickfix" }))
vim.keymap.set("n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>",                       vim.tbl_extend("force", opts, { desc = "Rename" }))
