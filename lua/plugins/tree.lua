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

        -- Скрываем файлы с точкой по умолчанию
        filters = {
          dotfiles = true,        -- true = НЕ показывать файлы с точкой
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

      -- Настройка клавиш для проводника
      local api = require("nvim-tree.api")
      
      -- l - открыть файл/папку
      vim.keymap.set('n', 'l', api.node.open.edit, { buffer = true, desc = "Open file/folder" })
      
      -- h - выйти из папки (назад)
      vim.keymap.set('n', 'h', api.node.navigate.parent_close, { buffer = true, desc = "Go back" })
      
      -- H - переключить видимость скрытых файлов
      vim.keymap.set('n', 'H', function()
        local nvim_tree = require("nvim-tree")
        local filters = nvim_tree.get_filter()
        if filters.dotfiles then
          nvim_tree.set_filter({ dotfiles = false })
        else
          nvim_tree.set_filter({ dotfiles = true })
        end
        nvim_tree.reload()
      end, { buffer = true, desc = "Toggle hidden files" })
    end,
  },
}
