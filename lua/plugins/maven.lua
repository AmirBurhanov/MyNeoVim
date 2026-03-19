return {
  {
    "yonchando/maven.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      local mvn = require("mvn")
      mvn.setup()
      
      -- Клавиши для Maven
      vim.keymap.set("n", "<leader>mc", mvn.mvn_cli)                 -- Maven команды
      vim.keymap.set("n", "<leader>mp", mvn.mvn_create_project)      -- Создать Maven проект
      vim.keymap.set("n", "<leader>ms", mvn.spring_initializr_project) -- Создать Spring Boot проект
    end,
  }
}
