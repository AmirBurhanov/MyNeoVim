return {
  -- Mason (менеджер LSP-серверов)
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    config = true,
    lazy = false,
  },

  -- JDTLS (Java) - ему не нужен lspconfig!
  {
    "mfussenegger/nvim-jdtls",
    ft = "java",
    lazy = true,
  },
}
