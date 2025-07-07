return {
  "ojroques/nvim-osc52",
  config = function()
    require("osc52").setup({
      max_length = 0,  -- no limit on copied content size
      silent = true,
    })

    -- Automatically copy all yanks to local clipboard via OSC52
    vim.api.nvim_create_autocmd("TextYankPost", {
      callback = function()
        require("osc52").copy_register("+")
      end,
    })
  end,
}
