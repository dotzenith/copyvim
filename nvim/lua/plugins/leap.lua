local opts = { noremap = true, silent = true }
vim.keymap.set({'n', 'o'}, 's',  '<Plug>(leap-forward)', opts)
vim.keymap.set({'n', 'o'}, 'S',  '<Plug>(leap-backward)', opts)
