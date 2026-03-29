-- Список типов, которые НЕ должны появляться в автодополнении
local excludedTypes = {
  -- AWT (мешает с java.util.List)
  "java.awt.List",
  "java.awt.*",
  
  -- Устаревшие коллекции
  "java.util.Vector",
  "java.util.Stack",
  "java.util.Hashtable",
  "java.util.Dictionary",
  
  -- Swing
  "javax.swing.*",
  
  -- Устаревшие даты
  "java.util.Date",
  "java.sql.Date",
  "java.sql.Timestamp",
}

-- Список пакетов для исключения целиком
local excludedPackages = {
  "java.awt",
  "javax.swing",
  "java.applet",
  "java.beans",
  "java.rmi",
}

-- Приоритетные типы (будут выше в списке)
local priorityTypes = {
  "java.util.List",
  "java.util.ArrayList",
  "java.util.HashMap",
  "java.util.Set",
  "java.util.HashSet",
  "java.util.Optional",
  "java.util.stream.Stream",
}

-- ЖЁСТКОЕ ИСКЛЮЧЕНИЕ (игнорируем полностью)
local ignoredTypes = {
  "java.awt.List",
}

return {
  excludedTypes = excludedTypes,
  excludedPackages = excludedPackages,
  priorityTypes = priorityTypes,
  ignoredTypes = ignoredTypes,
}
