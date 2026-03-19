require("mini.completion").setup({
  lsp_completion = {
    source_func = "completefunc",
    auto_setup = false,
  },
  window = {
    info      = { height = 25, width = 80, border = "rounded" },
    signature = { height = 25, width = 80, border = "rounded" },
  },
})

-- Set completefunc to mini.completion's LSP handler
vim.o.completefunc = "v:lua.MiniCompletion.completefunc_lsp"

-- Recommended CR action from mini.completion docs:
-- confirm with <C-y> if an item is selected, otherwise fall through to mini.pairs
local keycode = vim.keycode or function(x)
  return vim.api.nvim_replace_termcodes(x, true, true, true)
end
local keys = {
  ctrl_y    = keycode("<C-y>"),
  ctrl_y_cr = keycode("<C-y><CR>"),
}

-- Tab / S-Tab to cycle through popup menu entries
vim.keymap.set("i", "<Tab>",   [[pumvisible() ? "\<C-n>" : "\<Tab>"]],   { expr = true })
vim.keymap.set("i", "<S-Tab>", [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]], { expr = true })
vim.keymap.set("i", "<C-j>",   [[pumvisible() ? "\<C-n>" : "\<C-j>"]],   { expr = true })
vim.keymap.set("i", "<C-k>",   [[pumvisible() ? "\<C-p>" : "\<C-k>"]],   { expr = true })
-- replace_keycodes = false required when returning raw bytes from nvim_replace_termcodes
-- (matches how mini.pairs sets up its own <CR> mapping)
vim.keymap.set("i", "<CR>", function()
  if vim.fn.pumvisible() ~= 0 then
    local item_selected = vim.fn.complete_info()["selected"] ~= -1
    return item_selected and keys.ctrl_y or keys.ctrl_y_cr
  else
    return require("mini.pairs").cr()
  end
end, { expr = true, replace_keycodes = false })
