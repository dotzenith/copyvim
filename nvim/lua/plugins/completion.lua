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

local function pum_key(pum_key, fallback_key)
  return function()
    local key = vim.fn.pumvisible() ~= 0 and pum_key or fallback_key
    return vim.api.nvim_replace_termcodes(key, true, false, true)
  end
end

-- Tab / S-Tab to cycle through popup menu entries
vim.keymap.set("i", "<Tab>",   pum_key("<C-n>", "<Tab>"),   { expr = true, noremap = true })
vim.keymap.set("i", "<S-Tab>", pum_key("<C-p>", "<S-Tab>"), { expr = true, noremap = true })
vim.keymap.set("i", "<C-j>",   pum_key("<C-n>", "<C-j>"),   { expr = true, noremap = true })
vim.keymap.set("i", "<C-k>",   pum_key("<C-p>", "<C-k>"),   { expr = true, noremap = true })
vim.keymap.set("i", "<CR>",    pum_key("<C-y>", "<CR>"),    { expr = true, noremap = true })
