return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,  -- загружается раньше других плагинов
    config = function()
      require("catppuccin").setup({
        flavour = "mocha", -- mocha - самый тёмный, macchiato - чуть светлее
        background = {
          light = "latte",
          dark = "mocha",
        },
        transparent_background = false, -- true если хочешь прозрачный фон
        term_colors = true,
        styles = {
          comments = { "italic" },      -- комментарии курсивом
          conditionals = { "italic" },
          loops = {},
          functions = { "bold" },       -- функции жирным
          keywords = { "bold" },        -- ключевые слова жирным
          strings = {},
          variables = {},
          numbers = {},
          booleans = { "bold" },
          properties = {},
          types = { "bold" },
          operators = {},
        },
        integrations = {
          telescope = true,
          nvimtree = true,
          lsp_trouble = true,
          gitsigns = true,
          which_key = true,
          treesitter = true,
          cmp = true,
          mason = true,
          -- для Java
          native_lsp = {
            enabled = true,
            virtual_text = {
              errors = { "italic" },
              hints = { "italic" },
              warnings = { "italic" },
              information = { "italic" },
            },
            underlines = {
              errors = { "underline" },
              hints = { "underline" },
              warnings = { "underline" },
              information = { "underline" },
            },
          },
        },
      })
      
      -- Устанавливаем тему
      vim.cmd.colorscheme("catppuccin")
    end,
  },
}
