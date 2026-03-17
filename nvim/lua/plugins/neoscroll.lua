require("mini.animate").setup({
  scroll = {
    enable = true,
    timing = require("mini.animate").gen_timing.quadratic({ duration = 150, unit = "total" }),
  },
  -- Only animate scroll; leave cursor/resize/open/close as default (disabled)
  cursor = { enable = false },
  resize = { enable = false },
  open   = { enable = false },
  close  = { enable = false },
})
