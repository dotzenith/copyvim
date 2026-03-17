local actions = require("telescope.actions")
local opts = { noremap = true, silent = true }

-- Telescope keymaps (descriptions registered in whichkey.lua / mini.clue)
vim.keymap.set("n", "<leader>fb",  "<cmd>Telescope buffers previewer=false<cr>",                             vim.tbl_extend("force", opts, { desc = "Show Buffers" }))
vim.keymap.set("n", "<leader>fgb", "<cmd>Telescope git_branches<cr>",                                        vim.tbl_extend("force", opts, { desc = "Checkout branch" }))
vim.keymap.set("n", "<leader>fd",  "<cmd>Telescope diagnostics<cr>",                                         vim.tbl_extend("force", opts, { desc = "Diagnostics" }))
vim.keymap.set("n", "<leader>ff",  "<cmd>Telescope find_files<cr>",                                          vim.tbl_extend("force", opts, { desc = "Find Files" }))
vim.keymap.set("n", "<leader>fh",  "<cmd>Telescope help_tags<cr>",                                           vim.tbl_extend("force", opts, { desc = "Help" }))
vim.keymap.set("n", "<leader>fo",  "<cmd>Telescope oldfiles<cr>",                                            vim.tbl_extend("force", opts, { desc = "Recent File" }))
vim.keymap.set("n", "<leader>fp",  "<cmd>lua require('telescope').extensions.projects.projects()<cr>",       vim.tbl_extend("force", opts, { desc = "Projects" }))
vim.keymap.set("n", "<leader>fr",  "<cmd>Telescope lsp_references<cr>",                                      vim.tbl_extend("force", opts, { desc = "References" }))
vim.keymap.set("n", "<leader>ft",  "<cmd>Telescope live_grep<cr>",                                           vim.tbl_extend("force", opts, { desc = "Find Text" }))

require("telescope").setup({
  defaults = {
    prompt_prefix = " ",
    selection_caret = " ",
    entry_prefix = "   ",
    initial_mode = "insert",
    selection_strategy = "reset",
    path_display = { "smart" },
    color_devicons = true,
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      "--hidden",
      "--glob=!.git/",
    },

    mappings = {
      i = {
        ["<C-n>"] = actions.cycle_history_next,
        ["<C-p>"] = actions.cycle_history_prev,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
      },
      n = {
        ["<esc>"] = actions.close,
        ["j"]     = actions.move_selection_next,
        ["k"]     = actions.move_selection_previous,
        ["q"]     = actions.close,
      },
    },
  },

  pickers = {
    live_grep = { theme = "dropdown" },
    grep_string = { theme = "dropdown" },
    find_files = { theme = "dropdown", previewer = false },
    buffers = {
      theme = "dropdown",
      previewer = false,
      initial_mode = "normal",
      mappings = {
        i = { ["<C-d>"] = actions.delete_buffer },
        n = { ["dd"]    = actions.delete_buffer },
      },
    },
    colorscheme = { enable_preview = true },
    lsp_references  = { initial_mode = "normal" },
    lsp_definitions = { initial_mode = "normal" },
  },
})
