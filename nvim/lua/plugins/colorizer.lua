local hipatterns = require("mini.hipatterns")

hipatterns.setup({
  highlighters = {
    hex_color = hipatterns.gen_highlighter.hex_color(),
  },
})

-- Enable only for the filetypes colorizer was configured for
vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "typescript", "typescriptreact",
    "javascript", "javascriptreact",
    "css", "html", "astro", "toml", "lua",
  },
  callback = function()
    vim.b.minihipatterns_disable = false
    hipatterns.enable(0)
  end,
})

-- Disable for all other filetypes by default
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    local ft = vim.bo.filetype
    local enabled_fts = {
      typescript = true, typescriptreact = true,
      javascript = true, javascriptreact = true,
      css = true, html = true, astro = true, toml = true, lua = true,
    }
    if not enabled_fts[ft] then
      vim.b.minihipatterns_disable = true
    end
  end,
})
