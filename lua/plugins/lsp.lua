return {
  -- Core LSP config
  {
    "neovim/nvim-lspconfig",
    config = function()
      -- Define on_attach function with LSP keymaps
      local on_attach = function(client, bufnr)
        local opts = { noremap = true, silent = true, buffer = bufnr }
        local keymap = vim.keymap.set

        keymap("n", "<leader>gd", vim.lsp.buf.definition, { desc = "Go to Definition", buffer = bufnr })
        keymap("n", "K", vim.lsp.buf.hover, { desc = "Hover", buffer = bufnr })
        keymap("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename", buffer = bufnr })
        keymap("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action", buffer = bufnr })
        keymap("n", "<leader>gr", vim.lsp.buf.references, { desc = "References", buffer = bufnr })
        keymap("n", "<leader>gi", vim.lsp.buf.implementation, { desc = "Implementation", buffer = bufnr })
      end

      -- Save globally to reuse in mason-lspconfig
      vim.g._lsp_on_attach = on_attach

      -- Manual setup example: Lua language server
      require("lspconfig").lua_ls.setup({
        on_attach = on_attach,
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
          },
        },
      })
    end,
  },

  -- Mason: installs LSP servers
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    config = function()
      require("mason").setup()
    end,
  },

  -- Mason-LSPConfig: connects Mason and LSPConfig
  {
    "williamboman/mason-lspconfig.nvim",
    version = "1.32.0", -- pin to a stable version if desired
    dependencies = { "mason.nvim", "nvim-lspconfig" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "intelephense",
	  "gopls"
        },
        automatic_installation = true,
      })

      local lspconfig = require("lspconfig")
      local on_attach = vim.g._lsp_on_attach

      require("mason-lspconfig").setup_handlers({
        function(server_name)
          lspconfig[server_name].setup({
            on_attach = on_attach,
          })
        end,
      })
    end,
  },
}

