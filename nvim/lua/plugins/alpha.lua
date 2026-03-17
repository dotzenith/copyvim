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
    {
      name    = "f  Find file",
      action  = function() require("mini.pick").builtin.files() end,
      section = "Actions",
    },
    { name = "e  New file", action = "enew | startinsert", section = "Actions" },
    {
      name    = "p  Find project",
      action  = function()
        local ok, proj = pcall(require, "project_nvim")
        if not ok then return end
        local projects = proj.get_recent_projects()
        local items = {}
        for i = #projects, 1, -1 do table.insert(items, projects[i]) end
        require("mini.pick").start({
          source = {
            items  = items,
            name   = "Projects",
            choose = function(item)
              vim.cmd("cd " .. vim.fn.fnameescape(item))
              require("mini.pick").builtin.files()
            end,
          },
        })
      end,
      section = "Actions",
    },
    {
      name    = "r  Recent files",
      action  = function() require("mini.extra").pickers.oldfiles() end,
      section = "Actions",
    },
    {
      name    = "t  Find text",
      action  = function() require("mini.pick").builtin.grep_live() end,
      section = "Actions",
    },
    { name = "q  Quit Neovim", action = "qa", section = "Actions" },
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
