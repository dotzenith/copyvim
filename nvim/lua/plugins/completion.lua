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
-- confirm with <C-y> if an item is selected, otherwise dismiss pum and newline
local keycode = vim.keycode or function(x)
  return vim.api.nvim_replace_termcodes(x, true, true, true)
end
local keys = {
  cr        = keycode("<CR>"),
  ctrl_y    = keycode("<C-y>"),
  ctrl_y_cr = keycode("<C-y><CR>"),
}

_G.cr_action = function()
  if vim.fn.pumvisible() ~= 0 then
    local item_selected = vim.fn.complete_info()["selected"] ~= -1
    return item_selected and keys.ctrl_y or keys.ctrl_y_cr
  else
    return keys.cr
  end
end

-- Tab / S-Tab to cycle through popup menu entries
vim.keymap.set("i", "<Tab>",   [[pumvisible() ? "\<C-n>" : "\<Tab>"]],   { expr = true })
vim.keymap.set("i", "<S-Tab>", [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]], { expr = true })
vim.keymap.set("i", "<C-j>",   [[pumvisible() ? "\<C-n>" : "\<C-j>"]],   { expr = true })
vim.keymap.set("i", "<C-k>",   [[pumvisible() ? "\<C-p>" : "\<C-k>"]],   { expr = true })
vim.keymap.set("i", "<CR>",    "v:lua._G.cr_action()",                   { expr = true })
