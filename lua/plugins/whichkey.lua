return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      local wk = require("which-key")
      wk.setup({})
      
      -- Правильный способ регистрации (для новой версии)
      wk.add({
        -- Группа для <leader>
        { "<leader>e", group = "Проводник" },
        { "<leader>e", desc = "Открыть/закрыть", mode = "n" },
        { "<leader>f", desc = "Найти файл в дереве", mode = "n" },
        { "<leader>r", desc = "Обновить дерево", mode = "n" },
        { "<leader>E", desc = "Открыть и развернуть всё", mode = "n" },
        
        -- Группа для поиска
        { "<leader>f", group = "Поиск" },
        { "<leader>ff", desc = "Найти файлы", mode = "n" },
        { "<leader>fg", desc = "Поиск по тексту", mode = "n" },
        { "<leader>fh", desc = "Помощь", mode = "n" },
      })
    end,
  },
}
