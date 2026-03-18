-- Catppuccin Mocha palette (matching the old lualine custom theme)
local colors = {
  blue   = "#87b0f9",
  mauve  = "#cba6f7",
  red    = "#f38ba8",
  green  = "#a6e3a1",
  peach  = "#fab387",
  white  = "#c6d0f5",
  gray   = "#a1a8c9",
  black  = "#1e1e2e",
}

-- Override mini.statusline highlight groups to match the old lualine theme
local function set_highlights()
  vim.api.nvim_set_hl(0, "MiniStatuslineModeNormal",  { fg = colors.black, bg = colors.blue,  bold = true })
  vim.api.nvim_set_hl(0, "MiniStatuslineModeInsert",  { fg = colors.black, bg = colors.green, bold = true })
  vim.api.nvim_set_hl(0, "MiniStatuslineModeVisual",  { fg = colors.black, bg = colors.mauve, bold = true })
  vim.api.nvim_set_hl(0, "MiniStatuslineModeReplace", { fg = colors.black, bg = colors.red,   bold = true })
  vim.api.nvim_set_hl(0, "MiniStatuslineModeCommand", { fg = colors.black, bg = colors.peach, bold = true })
  vim.api.nvim_set_hl(0, "MiniStatuslineModeOther",   { fg = colors.black, bg = colors.peach, bold = true })
  vim.api.nvim_set_hl(0, "MiniStatuslineDevinfo",     { fg = colors.blue,  bg = "NONE" })
  vim.api.nvim_set_hl(0, "MiniStatuslineFilename",    { fg = colors.white, bg = "NONE" })
  vim.api.nvim_set_hl(0, "MiniStatuslineFileinfo",    { fg = colors.gray,  bg = "NONE" })
  vim.api.nvim_set_hl(0, "MiniStatuslineInactive",    { fg = colors.gray,  bg = "NONE" })
end

set_highlights()
-- Re-apply after colorscheme changes
vim.api.nvim_create_autocmd("ColorScheme", { callback = set_highlights })

-- Track LSP progress for display in statusline
local lsp_progress_msg = ""
vim.api.nvim_create_autocmd("LspProgress", {
  callback = function(ev)
    local value = ev.data and ev.data.params and ev.data.params.value
    if not value then
      lsp_progress_msg = ""
      return
    end
    if value.kind == "end" then
      lsp_progress_msg = ""
    elseif value.title then
      local msg = string.sub(value.title, 1, 50)
      if value.percentage then
        msg = msg .. string.format(" (%.0f%%)", value.percentage)
      end
      lsp_progress_msg = msg
    end
    vim.cmd("redrawstatus")
  end,
})

require("mini.statusline").setup({
  use_icons = true,
  set_vim_settings = true,

  content = {
    active = function()
      local MiniStatusline = require("mini.statusline")
      local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
      local git           = MiniStatusline.section_git({ trunc_width = 75 })
      local diff          = MiniStatusline.section_diff({ trunc_width = 75 })
      local diagnostics   = MiniStatusline.section_diagnostics({ trunc_width = 75 })
      local filename      = MiniStatusline.section_filename({ trunc_width = 140 })
      local fileinfo      = MiniStatusline.section_fileinfo({ trunc_width = 120 })
      local location      = MiniStatusline.section_location({ trunc_width = 75 })
      local lsp           = lsp_progress_msg ~= "" and lsp_progress_msg
                            or MiniStatusline.section_lsp({ trunc_width = 75 })

      return MiniStatusline.combine_groups({
        { hl = mode_hl,                    strings = { mode } },
        { hl = "MiniStatuslineDevinfo",    strings = { git, diff, diagnostics } },
        "%<",
        { hl = "MiniStatuslineFilename",   strings = { filename } },
        "%=",
        { hl = "MiniStatuslineFileinfo",   strings = { fileinfo } },
        { hl = "MiniStatuslineDevinfo",    strings = { lsp } },
        { hl = mode_hl,                    strings = { location } },
      })
    end,

    inactive = function()
      local MiniStatusline = require("mini.statusline")
      local filename = MiniStatusline.section_filename({ trunc_width = 140 })
      local location = MiniStatusline.section_location({ trunc_width = 999 })
      return MiniStatusline.combine_groups({
        { hl = "MiniStatuslineInactive", strings = { filename } },
        "%=",
        { hl = "MiniStatuslineInactive", strings = { location } },
      })
    end,
  },
})

-- Don't show statusline on alpha/starter screen (handled in alpha.lua via autocmd)
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "ministarter" },
  callback = function()
    vim.b.ministatusline_disable = true
  end,
})
