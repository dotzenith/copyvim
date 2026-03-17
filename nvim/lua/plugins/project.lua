require("project_nvim").setup({
  active = true,
  on_config_done = nil,
  manual_mode = false,
  detection_methods = { "pattern" },
  patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", "pom.xml" },
  ignore_lsp = {},
  exclude_dirs = {},
  show_hidden = false,
  silent_chdir = true,
  scope_chdir = "global",
})

-- <C-p> project picker is defined in telescope.lua (mini.pick)
vim.keymap.set("n", "<c-p>", function()
  local ok, project_nvim = pcall(require, "project_nvim")
  if not ok then return end
  local projects = project_nvim.get_recent_projects()
  local items = {}
  for i = #projects, 1, -1 do
    table.insert(items, projects[i])
  end
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
end, { noremap = true, silent = true })
