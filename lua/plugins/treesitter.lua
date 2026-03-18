return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
		"lua",
		"go",
		"javascript",
		"html",
		"c_sharp"
	}, -- languages you use
      highlight = { enable = true },
      indent = { enable = true },
    })
  end,
}

