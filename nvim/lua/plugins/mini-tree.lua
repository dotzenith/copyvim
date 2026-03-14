require('mini.files').setup()
vim.api.nvim_set_keymap('n', '<leader>e', '<cmd>lua MiniFiles.open()<CR>', { noremap = true, silent = true })
