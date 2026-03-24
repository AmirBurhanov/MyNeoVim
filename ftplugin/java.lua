-- Java LSP настройка
local jdtls = require("jdtls")
local mason_path = vim.fn.stdpath("data") .. "/mason/packages/jdtls"

-- Находим launcher.jar
local launcher_jar = vim.fn.glob(mason_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")
if launcher_jar == "" then
  vim.notify("❌ Установи JDTLS: :MasonInstall jdtls", vim.log.levels.ERROR)
  return
end

-- Для macOS
local config_dir = mason_path .. "/config_mac"

-- Функция для определения корня проекта
local function get_project_root()
  local markers = { "pom.xml", "build.gradle", ".git", "mvnw", "gradlew" }
  local root = vim.fs.dirname(vim.fs.find(markers, { upward = true })[1])
  
  if not root then
    root = vim.fn.getcwd()
    vim.notify("JDTLS: No project root, using: " .. root, vim.log.levels.WARN)
  end
  
  return root
end

local project_root = get_project_root()
local workspace_dir = vim.fn.stdpath("data") .. "/jdtls-workspace/" .. vim.fn.fnamemodify(project_root, ":t")

-- Конфигурация
local config = {
  cmd = {
    "java",
    "-Xms512m",
    "-Xmx2g",
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-jar", launcher_jar,
    "-configuration", config_dir,
    "-data", workspace_dir,
  },
  root_dir = project_root,
  init_options = {
    extendedClientCapabilities = require("jdtls").extendedClientCapabilities,
  },
  settings = {
    java = {
      signatureHelp = { enabled = true },
      contentProvider = { preferred = "fernflower" },
      completion = { favoriteStaticMembers = { "org.junit.jupiter.api.Assertions.*" } },
      sources = { organizeImports = { starThreshold = 9999, staticStarThreshold = 9999 } },
      codeGeneration = {
        toString = { template = "${object.className}{${member.name()}=${member.value}, }" },
        hashCodeEquals = { useJava7Objects = true },
        useBlocks = true,
      },
      configuration = {
        updateBuildConfiguration = "interactive",
        runtimes = {
          {
            name = "JavaSE-21",
            path = "/usr/local/opt/openjdk@21",
            default = true,
          },
        },
      },
    },
  },
}

-- Запускаем
jdtls.start_or_attach(config)

-- 👇 КЛАВИШИ
local opts = { buffer = true }

vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
vim.keymap.set('n', '<leader>ci', function()
  vim.lsp.buf.code_action({ context = { only = { "source.organizeImports" } }, apply = true })
end, opts)

vim.keymap.set('n', '<leader>tr', function() require("neotest").run.run() end, opts)
vim.keymap.set('n', '<leader>tR', function() require("neotest").run.run(vim.fn.expand("%")) end, opts)
vim.keymap.set('n', '<leader>tl', function() require("neotest").run.run_last() end, opts)
vim.keymap.set('n', '<leader>to', function() require("neotest").output.open() end, opts)
vim.keymap.set('n', '<leader>tp', function() require("neotest").output_panel.toggle() end, opts)

-- Авто-обновление проекта при открытии Java файла
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*.java",
  callback = function()
    vim.defer_fn(function()
      pcall(vim.lsp.buf.execute_command, { command = "java.project.updateSettings", arguments = {} })
    end, 1000)
  end,
})

vim.notify("✅ Java LSP loaded with auto-update", vim.log.levels.INFO)
