return {
  -- Mason
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    config = true,
    lazy = false,
  },

  -- mason-lspconfig
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    opts = {
      ensure_installed = { "jdtls", "lua_ls", "dockerls" },
      automatic_installation = true,
      handlers = {
        function(server_name)
          require("lspconfig")[server_name].setup({})
        end,
        dockerls = function()
          -- Правильный путь к бинарнику
          local mason_path = vim.fn.stdpath("data") .. "/mason/packages/docker-language-server"
          local dockerls_bin = mason_path .. "/docker-language-server-darwin-arm64-v0.20.1"
          
          require("lspconfig").dockerls.setup({
            cmd = { dockerls_bin, "--stdio" },
            filetypes = { "dockerfile" },
            on_attach = function(client, bufnr)
              vim.notify("dockerls attached!", vim.log.levels.INFO)
            end,
          })
        end,
      },
    },
    lazy = false,
  },

  -- lspconfig
  {
    "neovim/nvim-lspconfig",
    lazy = false,
  },

  -- JDTLS (Java)
  {
    "mfussenegger/nvim-jdtls",
    ft = "java",
    lazy = true,
  },
}
