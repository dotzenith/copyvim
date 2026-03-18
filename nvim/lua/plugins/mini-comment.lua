require("mini.comment").setup({
  options = {
    -- Use TreeSitter to get context-aware comment string (e.g. JSX, embedded langs)
    custom_commentstring = function()
      local ts_node = vim.treesitter.get_node()
      if ts_node == nil then return vim.bo.commentstring end

      -- Walk up the tree to find the most relevant language node
      local node = ts_node
      while node do
        local lang = vim.treesitter.language.get_lang(node:type())
        if lang then
          local ok, cs = pcall(vim.filetype.get_option, lang, "commentstring")
          if ok and cs ~= "" then return cs end
        end
        node = node:parent()
      end

      return vim.bo.commentstring
    end,
  },
})
