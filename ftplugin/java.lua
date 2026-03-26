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

-- Функция для определения корня проекта (улучшена)
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
    "-Xms1g",
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
      completion = {
        favoriteStaticMembers = {
          -- JUnit
          "org.junit.jupiter.api.Assertions.*",
          "org.junit.jupiter.api.Assumptions.*",
          -- Spring Test
          "org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*",
          "org.springframework.test.web.servlet.result.MockMvcResultMatchers.*",
          -- Hamcrest
          "org.hamcrest.Matchers.*",
          "org.hamcrest.core.StringContains.*",
          "org.hamcrest.CoreMatchers.*",
          -- Mockito
          "org.mockito.Mockito.*",
          "org.mockito.ArgumentMatchers.*",
          -- AssertJ
          "org.assertj.core.api.Assertions.*",
          -- Lombok
          "lombok.*",
        },
        staticCompletion = true,
        staticImportCompletion = true,
      },
      sources = {
        organizeImports = {
          starThreshold = 9999,
          staticStarThreshold = 9999
        }
      },
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
      maven = {
        downloadSources = true,
      },
      eclipse = {
        downloadSources = true,
      },
      import = {
        maven = {
          enabled = true,
          disableTestClasspathFlag = false,
        },
        gradle = {
          enabled = false,
        },
      },
      references = {
        includeDecompiledSources = true,
      },
      format = {
        enabled = true,
      },
      -- Новая настройка: автоматическая организация импортов при сохранении
      saveActions = {
        organizeImports = true,
      },
    },
  },
}

-- Запускаем JDTLS
jdtls.start_or_attach(config)

-- 👇 КЛАВИШИ
local opts = { buffer = true }

vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
vim.keymap.set('n', '<leader>ci', function()
  vim.lsp.buf.code_action({ context = { only = { "source.organizeImports" } }, apply = true })
end, opts)

-- Дополнительные полезные клавиши
vim.keymap.set('v', '<leader>ce', function()
  jdtls.extract_variable()
end, opts, { desc = "Extract variable" })

vim.keymap.set('v', '<leader>cm', function()
  jdtls.extract_method()
end, opts, { desc = "Extract method" })

vim.keymap.set('n', '<leader>gt', function()
  jdtls.test_nearest_method()
end, opts, { desc = "Run nearest test" })

-- Тестирование
vim.keymap.set('n', '<leader>tr', function() require("neotest").run.run() end, opts)
vim.keymap.set('n', '<leader>tR', function() require("neotest").run.run(vim.fn.expand("%")) end, opts)
vim.keymap.set('n', '<leader>tl', function() require("neotest").run.run_last() end, opts)
vim.keymap.set('n', '<leader>to', function() require("neotest").output.open() end, opts)
vim.keymap.set('n', '<leader>tp', function() require("neotest").output_panel.toggle() end, opts)

-- Авто-обновление с защитой от ошибок
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*.java",
  callback = function()
    vim.defer_fn(function()
      local success, err = pcall(vim.lsp.buf.execute_command, { command = "java.project.updateSettings", arguments = {} })
      if not success then
        vim.notify("JDTLS update skipped: " .. tostring(err), vim.log.levels.WARN)
      end
    end, 2000)
  end,
})

vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = { "pom.xml", "build.gradle" },
  callback = function()
    vim.defer_fn(function()
      pcall(vim.lsp.buf.execute_command, { command = "java.project.updateSettings", arguments = {} })
      vim.notify("Project configuration updated", vim.log.levels.INFO)
    end, 1000)
  end,
})

vim.notify("✅ Java LSP loaded with full Spring support", vim.log.levels.INFO)
