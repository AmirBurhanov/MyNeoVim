return {
  -- Основной плагин для тестирования (работает с Java)
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim", -- фикс для производительности
  "nvim-neotest/nvim-nio", 
    },
    config = function()
      require("neotest").setup({
        adapters = {
          -- Адаптер для Java (JUnit)
          require("neotest-java")({
            ignore_wrapper = false,      -- игнорировать mvnw/gradlew
            junit_jar = nil,              -- путь к junit если нужно
          }),
        },
        status = { virtual_text = true },
        output = { open_on_run = true },
        quickfix = {
          open = function()
            require("trouble").open({ mode = "quickfix" })
          end,
        },
      })
    end,
    keys = {
      { "<leader>tt", function() require("neotest").run.run() end, desc = "Run nearest test" },
      { "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run current file tests" },
      { "<leader>ts", function() require("neotest").run.stop() end, desc = "Stop test run" },
      { "<leader>ta", function() require("neotest").run.attach() end, desc = "Attach to test" },
      { "<leader>tl", function() require("neotest").output_panel.toggle() end, desc = "Toggle output panel" },
      { "<leader>to", function() require("neotest").output.open() end, desc = "Open output" },
      { "<leader>tS", function() require("neotest").summary.toggle() end, desc = "Toggle summary" },
    },
  },

  -- Адаптер для Java
  {
    "rcasia/neotest-java",
    dependencies = { "nvim-neotest/neotest" },
    ft = "java",
    config = function()
      -- Дополнительные настройки для Java тестов
    end,
  },

  -- Красивый вывод ошибок (опционально)
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
      { "<leader>cs", "<cmd>Trouble symbols toggle<cr>", desc = "Symbols (Trouble)" },
      { "<leader>cl", "<cmd>Trouble lsp toggle<cr>", desc = "LSP Definitions / references (Trouble)" },
      { "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
      { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
    },
  },
}
