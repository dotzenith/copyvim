local pick  = require("mini.pick")
local extra = require("mini.extra")

pick.setup({
  mappings = {
    -- Match the old telescope navigation keys
    move_down = "<C-j>",
    move_up   = "<C-k>",
  },
  options = {
    use_cache = false,
  },
  window = {
    -- Centered dropdown-style window (mirrors telescope's dropdown theme)
    config = function()
      local lines = vim.o.lines
      local cols  = vim.o.columns
      local height = math.min(math.floor(lines * 0.4), 20)
      local width  = math.min(math.floor(cols  * 0.6), 90)
      return {
        anchor = "NW",
        height = height,
        width  = width,
        row    = math.floor((lines - height) / 2),
        col    = math.floor((cols  - width)  / 2),
        border = "rounded",
      }
    end,
  },
})

-- Custom projects picker: reads project.nvim's recent project list directly
local function pick_projects()
  local ok, project_nvim = pcall(require, "project_nvim")
  if not ok then
    vim.notify("project_nvim not available", vim.log.levels.WARN)
    return
  end
  local projects = project_nvim.get_recent_projects()
  -- Most recent first
  local items = {}
  for i = #projects, 1, -1 do
    table.insert(items, projects[i])
  end
  pick.start({
    source = {
      items  = items,
      name   = "Projects",
      choose = function(item)
        vim.cmd("cd " .. vim.fn.fnameescape(item))
        pick.builtin.files()
      end,
    },
  })
end

local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<leader>ff",  pick.builtin.files,      vim.tbl_extend("force", opts, { desc = "Find Files" }))
vim.keymap.set("n", "<leader>ft",  pick.builtin.grep_live,  vim.tbl_extend("force", opts, { desc = "Find Text" }))
vim.keymap.set("n", "<leader>fb",  pick.builtin.buffers,    vim.tbl_extend("force", opts, { desc = "Show Buffers" }))
vim.keymap.set("n", "<leader>fh",  pick.builtin.help,       vim.tbl_extend("force", opts, { desc = "Help" }))

vim.keymap.set("n", "<leader>fo",  function() extra.pickers.oldfiles() end,
  vim.tbl_extend("force", opts, { desc = "Recent File" }))
vim.keymap.set("n", "<leader>fgb", function() extra.pickers.git_branches() end,
  vim.tbl_extend("force", opts, { desc = "Checkout branch" }))
vim.keymap.set("n", "<leader>fd",  function() extra.pickers.diagnostic({ scope = "all" }) end,
  vim.tbl_extend("force", opts, { desc = "Diagnostics" }))
vim.keymap.set("n", "<leader>fr",  function() extra.pickers.lsp({ scope = "references" }) end,
  vim.tbl_extend("force", opts, { desc = "References" }))
vim.keymap.set("n", "<leader>fp",  pick_projects,           vim.tbl_extend("force", opts, { desc = "Projects" }))
