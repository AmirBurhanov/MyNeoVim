return {
  -- Автодополнение скобок и кавычек
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      local npairs = require("nvim-autopairs")
      
      -- Импортируем Rule и правило для угловых скобок
      local Rule = require('nvim-autopairs.rule')
      
      npairs.setup({
        enable_check_bracket_line = false,
        disable_filetype = { "TelescopePrompt", "vim" },
        enable_afterquote = true,
        check_ts = true,
        
        -- Базовая настройка пар
        pairs = {
          ["("] = ")",
          ["["] = "]",
          ["{"] = "}",
          ['"'] = '"',
          ["'"] = "'",
        },
        
        fast_wrap = {
          map = '<M-e>',
          chars = { '{', '[', '(', '"', "'" },
          pattern = string.gsub([[ [%'%"%)%>%]%)%}%, ] ]], '%s+', ''),
          offset = 0,
          end_key = '$',
          keys = 'qwertyuiopzxcvbnmasdfghjkl',
          check_comma = true,
          highlight = 'Search',
          highlight_grey='Comment'
        },
      })

      -- Добавляем правило для угловых скобок (правильный синтаксис)
      npairs.add_rules({
        Rule("<", ">", "java")
          :with_pair(function(opts)
            local line = opts.line
            local col = opts.col
            local before = line:sub(col - 1, col - 1)
            local after = line:sub(col, col)
            
            -- Не срабатывает если это << или >>
            if before == "<" or after == ">" then
              return false
            end
            return true
          end)
          :with_move(function(opts)
            return opts.char == ">"
          end)
          :with_cr(function(opts)
            return false
          end)
      })

      -- Интеграция с nvim-cmp
      local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      local cmp = require('cmp')
      cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
    end,
  },

  -- Цветные скобки
  {
    "HiPhish/rainbow-delimiters.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
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
