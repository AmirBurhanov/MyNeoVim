return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      require("which-key").setup()
      
      require("which-key").add({
        -- Рефакторинг (теперь r свободен)
        { "<leader>r", group = "Refactor" },
        { "<leader>rn", desc = "Rename variable/method/class" },
        
        -- Код действия
        { "<leader>c", group = "Code" },
        { "<leader>ca", desc = "Code actions" },
        { "<leader>ci", desc = "Organize imports" },
        { "<leader>cx", desc = "Run Java" },
        
        -- Форматирование
        { "<leader>f", desc = "Format" },
        
        -- Поиск
        { "<leader>ff", desc = "Find files" },
        { "<leader>fg", desc = "Live grep" },
        { "<leader>fh", desc = "Help tags" },
        
        -- Git
        { "<leader>g", group = "Git" },
        { "<leader>gg", desc = "LazyGit" },
        { "<leader>gd", desc = "Diff" },
        { "<leader>gs", desc = "Stage hunk" },
        
        -- Проводник
        { "<leader>e", desc = "Toggle file explorer" },
        { "<leader>R", desc = "Refresh tree" },
        { "<leader>E", desc = "Open and expand all" },
        
        -- Терминал
        { "<leader>cf", desc = "Open terminal at bottom" },
        
        -- LSP
        { "<leader>lr", desc = "Restart LSP" },
      })
    end,
  },
}
