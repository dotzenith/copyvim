require("mini.pairs").setup({
  modes = { insert = true, command = false, terminal = false },
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "TelescopePrompt" },
  callback = function()
    vim.b.minipairs_disable = true
  end,
})
