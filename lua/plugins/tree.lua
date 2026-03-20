return {
  -- Иконки
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
  },

  -- Проводник
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    lazy = false,
    config = function()
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      require("nvim-tree").setup({
        sort = {
          sorter = "case_sensitive",
        },

        view = {
          width = 30,
          side = "left",
          number = false,
          relativenumber = false,
          -- Убираем mappings отсюда - их тут больше нет!
        },

        renderer = {
          group_empty = true,
          icons = {
            show = {
              file = true,
              folder = true,
              folder_arrow = true,
              git = true,
            },
            glyphs = {
              default = "󰈚",
              symlink = "",
              folder = {
                arrow_closed = "",
                arrow_open = "",
                default = "󰉋",
                open = "󰝰",
                empty = "󰉌",
                empty_open = "󰉍",
                symlink = "",
                symlink_open = "",
              },
              git = {
                unstaged = "",
                staged = "✓",
                unmerged = "",
                renamed = "➜",
                untracked = "★",
                deleted = "",
                ignored = "◌",
              },
            },
          },
        },

        filters = {
          dotfiles = true,
          custom = {},
        },

        git = {
          enable = true,
          ignore = false,
          timeout = 500,
        },

        actions = {
          open_file = {
            resize_window = true,
            quit_on_open = false,
          },
        },

        update_focused_file = {
          enable = true,
          update_cwd = true,
          ignore_list = {},
        },
      })

      -- 👇 А ТЕПЕРЬ ДЕЛАЕМ МАППИНГИ ПРЯМО В КОНФИГЕ (НОВЫЙ СПОСОБ)
      local api = require("nvim-tree.api")
      
      -- Переопределяем клавиши для nvim-tree
      vim.keymap.set('n', 'l', api.node.open.edit, { buffer = true, desc = "Open file/folder" })
      vim.keymap.set('n', 'h', api.node.navigate.parent_close, { buffer = true, desc = "Close folder" })
      vim.keymap.set('n', 'H', api.tree.collapse_all, { buffer = true, desc = "Collapse all" })
    end,
  },
}
