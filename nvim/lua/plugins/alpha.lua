local starter = require("mini.starter")

starter.setup({
  evaluate_single = true,
  header = table.concat({
    [[     ___           ___           ___                       ___           ___     ]],
    [[    /\  \         /\  \         /\__\          ___        /\  \         /\__\    ]],
    [[    \:\  \       /::\  \       /::|  |        /\  \       \:\  \       /:/  /    ]],
    [[     \:\  \     /:/\:\  \     /:|:|  |        \:\  \       \:\  \     /:/__/     ]],
    [[      \:\  \   /::\~\:\  \   /:/|:|  |__      /::\__\      /::\  \   /::\  \ ___ ]],
    [[_______\:\__\ /:/\:\ \:\__\ /:/ |:| /\__\  __/:/\/__/     /:/\:\__\ /:/\:\  /\__\]],
    [[\::::::::/__/ \:\~\:\ \/__/ \/__|:|/:/  / /\/:/  /       /:/  \/__/ \/__\:\/:/  /]],
    [[ \:\~~\~~      \:\ \:\__\       |:/:/  /  \::/__/       /:/  /           \::/  / ]],
    [[  \:\  \        \:\ \/__/       |::/  /    \:\__\       \/__/            /:/  /  ]],
    [[   \:\__\        \:\__\         /:/  /      \/__/                       /:/  /   ]],
    [[    \/__/         \/__/         \/__/                                   \/__/    ]],
    [[                                                                                 ]],
  }, "\n"),
  items = {
    { name = "f  Find file",           action = "Telescope find_files",  section = "Actions" },
    { name = "e  New file",            action = "enew | startinsert",    section = "Actions" },
    { name = "p  Find project",        action = "lua require('telescope').extensions.projects.projects()", section = "Actions" },
    { name = "r  Recent files",        action = "Telescope oldfiles",    section = "Actions" },
    { name = "t  Find text",           action = "Telescope live_grep",   section = "Actions" },
    { name = "q  Quit Neovim",         action = "qa",                    section = "Actions" },
  },
  content_hooks = {
    starter.gen_hook.adding_bullet("  "),
    starter.gen_hook.aligning("center", "center"),
  },
  footer = "",
})

-- Hide statusline on the starter screen
vim.api.nvim_create_autocmd("User", {
  pattern = "MiniStarterOpened",
  callback = function()
    vim.o.laststatus = 0
  end,
})
vim.api.nvim_create_autocmd("User", {
  pattern = "MiniStarterClosed",
  callback = function()
    vim.o.laststatus = 3
  end,
})
