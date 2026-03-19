return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = false,
    config = function()
      local status_ok, treesitter = pcall(require, "nvim-treesitter.configs")
      if status_ok then
        treesitter.setup({
          ensure_installed = { "java", "lua" },
          highlight = { enable = true },
          indent = { enable = true },
        })
      end
    end,
  },
}
