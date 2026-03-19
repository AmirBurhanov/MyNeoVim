-- Запуск JDTLS для Java-файлов
local jdtls = require("jdtls")
local mason_path = vim.fn.stdpath("data") .. "/mason/packages/jdtls"

local launcher_jar = vim.fn.glob(mason_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")
if launcher_jar == "" then
  vim.notify("JDTLS not installed. Run :MasonInstall jdtls", vim.log.levels.WARN)
  return
end

local os_name = vim.loop.os_uname().sysname
local config_dir
if os_name == "Darwin" then
  config_dir = mason_path .. "/config_mac"
elseif os_name == "Linux" then
  config_dir = mason_path .. "/config_linux"
else
  config_dir = mason_path .. "/config_win"
end

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = vim.fn.stdpath("data") .. "/jdtls-workspace/" .. project_name

jdtls.start_or_attach({
  cmd = {
    "java",
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-Xms1g",
    "--add-modules=ALL-SYSTEM",
    "--add-opens", "java.base/java.util=ALL-UNNAMED",
    "--add-opens", "java.base/java.lang=ALL-UNNAMED",
    "-jar", launcher_jar,
    "-configuration", config_dir,
    "-data", workspace_dir,
  },
  root_dir = vim.fs.dirname(vim.fs.find({ "gradlew", "mvnw", ".git", "pom.xml", "build.gradle" }, { upward = true })[1]),
})
