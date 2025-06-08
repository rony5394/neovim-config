return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local mode_map = {
        ["n"] = "N",
        ["no"] = "N·OP",
        ["v"] = "V",
        ["V"] = "V-LN",
        [""] = "V-BLK",
        ["s"] = "S",
        ["S"] = "S-LN",
        [""] = "S-BLK",
        ["i"] = "I",
        ["ic"] = "I",
        ["R"] = "R",
        ["Rv"] = "V-R",
        ["c"] = "C",
        ["cv"] = "CV",
        ["ce"] = "CE",
        ["r"] = "R",
        ["rm"] = "M",
        ["r?"] = "?",
        ["!"] = "!",
        ["t"] = "T",
      }

      local function short_mode()
        local current_mode = vim.api.nvim_get_mode().mode
        return mode_map[current_mode] or current_mode
      end

      local function current_time()
        return os.date("%H:%M")
      end

      require("lualine").setup({
        options = {
          theme = "onedark",
          component_separators = { left = "", right = "" },  -- thin separators inside sections
          section_separators = { left = "", right = "" },    -- filled powerline arrows between sections
          globalstatus = true,
          disabled_filetypes = {},
        },
        sections = {
          lualine_a = { short_mode },
          lualine_b = { "branch" },
          lualine_c = { "filename" },
          lualine_x = {},
          lualine_y = {},
          lualine_z = {
            {
              current_time,
              color = { fg = "#000000", bg = "#008b8b", gui = "bold" }, -- black text on cyan bg
            },		  
	  },
        },
      })
    end,
  },
}

