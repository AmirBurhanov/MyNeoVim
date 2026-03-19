return {
  -- Строка статуса
  {
    'nvim-lualine/lualine.nvim',
    lazy = false,
    config = function()
      require('lualine').setup()
    end,
  },

  -- Файловый менеджер
  {
    'nvim-tree/nvim-tree.lua',
    lazy = false,
    config = function()
      require('nvim-tree').setup()
    end,
  },
}
