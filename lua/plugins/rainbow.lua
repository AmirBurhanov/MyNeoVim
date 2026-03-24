return {
  {
    "HiPhish/rainbow-delimiters.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require('rainbow-delimiters.setup').setup({
        strategy = {
          [''] = require('rainbow-delimiters.strategy.global'),
        },
        query = {
          [''] = 'rainbow-delimiters',
          lua = 'rainbow-blocks',
          java = 'rainbow-delimiters',
        },
        highlight = {
          'RainbowDelimiterRed',
          'RainbowDelimiterYellow',
          'RainbowDelimiterBlue',
          'RainbowDelimiterOrange',
          'RainbowDelimiterGreen',
          'RainbowDelimiterViolet',
          'RainbowDelimiterCyan',
        },
      })
    end,
  },
}
