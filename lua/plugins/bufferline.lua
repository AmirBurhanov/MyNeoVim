return {
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    event = "VeryLazy",
    config = function()
      require("bufferline").setup({
        options = {
          mode = "buffers",           -- режим буферов (не табов)
          numbers = "none",            -- не показывать номера
          close_command = "bdelete! %d", -- команда закрытия
          right_mouse_command = "bdelete! %d", -- закрыть по правой кнопке
          left_mouse_command = "buffer %d", -- открыть по левой кнопке
          middle_mouse_command = nil,
          indicator = {
            icon = '▎',
            style = 'icon',
          },
          buffer_close_icon = '󰅖',
          modified_icon = '●',
          close_icon = '󰅖',
          left_trunc_marker = '',
          right_trunc_marker = '',
          max_name_length = 30,
          max_prefix_length = 30,
          tab_size = 20,
          diagnostics = "nvim_lsp",
          diagnostics_indicator = function(count, level, diagnostics_dict, context)
            return "("..count..")"
          end,
          -- Фильтруем специальные буферы (NvimTree, терминал)
          custom_filter = function(buf_number, buf_numbers)
            local buftype = vim.bo[buf_number].buftype
            if buftype == "terminal" or buftype == "quickfix" or buftype == "nofile" then
              return false
            end
            if vim.bo[buf_number].filetype == "NvimTree" then
              return false
            end
            return true
          end,
          -- Отделяем проводник
          offsets = {
            {
              filetype = "NvimTree",
              text = "File Explorer",
              text_align = "left",
              separator = true,
            }
          },
          color_icons = true,
          show_buffer_icons = true,
          show_buffer_close_icons = true,
          show_close_icon = true,
          persist_buffer_sort = true,
          separator_style = "thin",
          enforce_regular_tabs = false,
          always_show_bufferline = true, -- ВСЕГДА ПОКАЗЫВАТЬ (то что тебе нужно!)
        },
        highlights = {
          separator = {
            fg = "#434C5E",
          },
          buffer_selected = {
            bold = true,
            italic = false,
          },
        },
      })
    end,
    keys = {
      -- Навигация
      { "<Tab>", "<Cmd>BufferLineCycleNext<CR>", desc = "Next buffer" },
      { "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev buffer" },
      
      -- Переход по номерам
      { "<leader>1", "<Cmd>BufferLineGoToBuffer 1<CR>", desc = "Buffer 1" },
      { "<leader>2", "<Cmd>BufferLineGoToBuffer 2<CR>", desc = "Buffer 2" },
      { "<leader>3", "<Cmd>BufferLineGoToBuffer 3<CR>", desc = "Buffer 3" },
      { "<leader>4", "<Cmd>BufferLineGoToBuffer 4<CR>", desc = "Buffer 4" },
      { "<leader>5", "<Cmd>BufferLineGoToBuffer 5<CR>", desc = "Buffer 5" },
      { "<leader>6", "<Cmd>BufferLineGoToBuffer 6<CR>", desc = "Buffer 6" },
      { "<leader>7", "<Cmd>BufferLineGoToBuffer 7<CR>", desc = "Buffer 7" },
      { "<leader>8", "<Cmd>BufferLineGoToBuffer 8<CR>", desc = "Buffer 8" },
      { "<leader>9", "<Cmd>BufferLineGoToBuffer 9<CR>", desc = "Buffer 9" },
      
      -- Управление закрытием (ТО ЧТО ТЫ ПРОСИЛ)
      { "<leader>bd", "<Cmd>BufferLinePickClose<CR>", desc = "Pick buffer to close" },
      { "<leader>bD", "<Cmd>bdelete<CR>", desc = "Close current buffer" },
    },
  },

  -- Дополнительно: плагин для красивого закрытия буферов (опционально)
  {
    "famiu/bufdelete.nvim",
    keys = {
      { "<leader>bd", "<Cmd>Bdelete<CR>", desc = "Delete buffer" },
      { "<leader>bD", "<Cmd>Bdelete!<CR>", desc = "Force delete buffer" },
    },
  },
}
