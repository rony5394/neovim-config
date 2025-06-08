--return {
--    'nvim-telescope/telescope.nvim', tag = '0.1.8',
--      dependencies = { 'nvim-lua/plenary.nvim' }
--    }
return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      {
        "<leader>fs",
        function()
          require("telescope.builtin").lsp_document_symbols()
        end,
        desc = "Find Symbols in Document",
      },
      {
        "<leader>ff",
        function()
          local builtin = require("telescope.builtin")
          local utils = require("telescope.utils")

          local function get_root()
            -- 1. Try LSP root
            local clients = vim.lsp.get_active_clients({ bufnr = 0 })
            for _, client in ipairs(clients) do
              if client.config.root_dir then
                return client.config.root_dir
              end
            end

            -- 2. Try Git root (FIXED: pass current buffer path)
            local buf_path = vim.api.nvim_buf_get_name(0)
            local git_ok, git_root = pcall(utils.get_git_root, buf_path)
            if git_ok then return git_root end

            -- 3. Fallback to CWD
            return vim.loop.cwd()
          end

          builtin.find_files({ cwd = get_root() })
        end,
        desc = "Find Files (LSP/Git Root)",
      },
      {
        "<leader>fg",
        function()
          local builtin = require("telescope.builtin")
          local utils = require("telescope.utils")

          local function get_root()
            local clients = vim.lsp.get_active_clients({ bufnr = 0 })
            for _, client in ipairs(clients) do
              if client.config.root_dir then
                return client.config.root_dir
              end
            end

            local buf_path = vim.api.nvim_buf_get_name(0)
            local git_ok, git_root = pcall(utils.get_git_root, buf_path)
            if git_ok then return git_root end

            return vim.loop.cwd()
          end

          builtin.live_grep({ cwd = get_root() })
        end,
        desc = "Live Grep (LSP/Git Root)",
      },
      { "<leader>fb", "<cmd>Telescope buffers<CR>", desc = "Find Buffers" },
      { "<leader>fh", "<cmd>Telescope help_tags<CR>", desc = "Help Tags" },
    },
    config = function()
      require("telescope").setup()
    end,
  },
}

