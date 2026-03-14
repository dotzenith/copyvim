require("mini.completion").setup({
  lsp_completion = {
    source_func = "completefunc",
    auto_setup = false,
  },
  window = {
    info      = { height = 25, width = 80, border = "none" },
    signature = { height = 25, width = 80, border = "none" },
  },
})

-- Set completefunc to mini.completion's LSP handler
vim.o.completefunc = "v:lua.MiniCompletion.completefunc_lsp"

-- Tab / S-Tab to cycle through popup menu entries
vim.keymap.set("i", "<Tab>",   [[pumvisible() ? "\<C-n>" : "\<Tab>"]],   { expr = true, noremap = true })
vim.keymap.set("i", "<S-Tab>", [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]], { expr = true, noremap = true })
vim.keymap.set("i", "<C-j>",   [[pumvisible() ? "\<C-n>" : "\<C-j>"]],   { expr = true, noremap = true })
vim.keymap.set("i", "<C-k>",   [[pumvisible() ? "\<C-p>" : "\<C-k>"]],   { expr = true, noremap = true })
vim.keymap.set("i", "<CR>",    [[pumvisible() ? "\<C-y>" : "\<CR>"]],    { expr = true, noremap = true })
