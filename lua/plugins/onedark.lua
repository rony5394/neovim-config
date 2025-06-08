return {
  {
    "navarasu/onedark.nvim",
    lazy = false,
    config = function()
      require("onedark").setup({
        style = "deep",      -- choose "deep" style
        transparent = false, -- no transparent background
        term_colors = true,  -- set terminal colors
        ending_tildes = false,
        cmp_itemkind_reverse = false,
      })
      require("onedark").load()
    end,
  },
}

