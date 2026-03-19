-- ~/.config/nvim/init.lua
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://app4.secure.forcepoint.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Базовые настройки редактора
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.termguicolors = true
vim.opt.mouse = 'a'
vim.opt.clipboard = "unnamedplus"
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Устанавливаем лидер на пробел
vim.g.mapleader = " "

-- ========== ГОРЯЧИЕ КЛАВИШИ ==========

-- Проводник (nvim-tree)
vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { desc = "Открыть/закрыть проводник" })
vim.keymap.set('n', '<leader>f', ':NvimTreeFindFile<CR>', { desc = "Найти текущий файл в проводнике" })
vim.keymap.set('n', '<leader>r', ':NvimTreeRefresh<CR>', { desc = "Обновить проводник" })
vim.keymap.set('n', '<leader>E', ':NvimTreeToggle<CR>:NvimTreeExpandAll<CR>', { desc = "Открыть проводник и развернуть всё" })

-- Поиск (Telescope)
vim.keymap.set('n', '<leader>ff', ':Telescope find_files<CR>', { desc = "Найти файлы" })
vim.keymap.set('n', '<leader>fg', ':Telescope live_grep<CR>', { desc = "Поиск по тексту" })
vim.keymap.set('n', '<leader>fh', ':Telescope help_tags<CR>', { desc = "Поиск по справке" })

-- Переключение между окнами (Shift + h/l/j/k)
vim.keymap.set('n', '<S-h>', '<C-w>h', { desc = "Перейти в левое окно" })
vim.keymap.set('n', '<S-l>', '<C-w>l', { desc = "Перейти в правое окно" })
vim.keymap.set('n', '<S-j>', '<C-w>j', { desc = "Перейти в нижнее окно" })
vim.keymap.set('n', '<S-k>', '<C-w>k', { desc = "Перейти в верхнее окно" })

-- Запуск Java (F5)
vim.keymap.set('n', '<F5>', function()
  vim.cmd('w')
  
  -- Пробуем определить имя класса из текущего файла
  local filename = vim.fn.expand('%:t:r')
  local package = ""
  
  -- Ищем package в файле
  for line in io.lines(vim.fn.expand('%')) do
    local pkg = line:match("package%s+([^;]+)")
    if pkg then
      package = pkg .. "."
      break
    end
  end
  
  local full_class = package .. filename
  
  local pom = io.open("pom.xml", "r")
  if pom then
    pom:close()
    
    -- Спрашиваем, но предлагаем угаданное имя
    local class_name = vim.fn.input("Main class [" .. full_class .. "]: ", full_class)
    if class_name and class_name ~= "" then
      vim.cmd('term mvn clean compile exec:java -Dexec.mainClass="' .. class_name .. '"')
    end
  else
    vim.cmd('term javac ' .. vim.fn.expand('%') .. ' && java ' .. package .. filename)
  end
end, { desc = "Run current project" })

-- ========== ПЛАГИНЫ ==========
require("lazy").setup({
  { import = "plugins" },
})

-- ========== АВТОКОМАНДЫ ==========

-- Автокоманды для LSP
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<leader>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, opts)
  end,
})

-- 👇 АВТОКОМАНДА ДЛЯ ПРОВОДНИКА (ЧТОБЫ l/h РАБОТАЛИ)
vim.api.nvim_create_autocmd("FileType", {
  pattern = "NvimTree",
  callback = function()
    -- Клавиши только для окна проводника
    vim.keymap.set('n', 'l', function()
      local api = require("nvim-tree.api")
      api.node.open.edit()
    end, { buffer = true, desc = "Открыть файл/папку" })
    
    vim.keymap.set('n', 'h', function()
      local api = require("nvim-tree.api")
      api.node.navigate.parent_close()
    end, { buffer = true, desc = "Свернуть папку" })
    
    vim.keymap.set('n', 'H', function()
      local api = require("nvim-tree.api")
      api.tree.collapse_all()
    end, { buffer = true, desc = "Свернуть всё" })
  end,
})
