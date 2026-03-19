-- Минимальный java.lua который точно работает
local jdtls = require("jdtls")
local mason_path = vim.fn.stdpath("data") .. "/mason/packages/jdtls"

-- Находим launcher.jar
local launcher_jar = vim.fn.glob(mason_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")
if launcher_jar == "" then
  vim.notify("❌ Установи JDTLS: :MasonInstall jdtls")
  return
end

-- Для macOS
local config_dir = mason_path .. "/config_mac"

-- Запускаем JDTLS
jdtls.start_or_attach({
  cmd = {
    "java",
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-jar", launcher_jar,
    "-configuration", config_dir,
    "-data", vim.fn.stdpath("data") .. "/jdtls-workspace/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t"),
  },
  root_dir = vim.fs.dirname(vim.fs.find({ ".git", "pom.xml", "build.gradle" }, { upward = true })[1]),
})

-- 👇 ПРОСТЫЕ КЛАВИШИ
local opts = { buffer = true }

-- Пытаемся использовать стандартный LSP code_action (он должен быть)
vim.keymap.set('n', '<leader>ca', function()
  vim.lsp.buf.code_action()
end, opts)

vim.keymap.set('n', '<leader>ci', function()
  vim.lsp.buf.code_action({ 
    context = { only = { "source.organizeImports" } },
    apply = true 
  })
end, opts)
