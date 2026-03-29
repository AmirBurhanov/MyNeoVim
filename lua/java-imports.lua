-- Все любимые статические импорты для Java
local favoriteStaticMembers = {
  -- JUnit 5
  "org.junit.jupiter.api.Assertions.*",
  "org.junit.jupiter.api.Assumptions.*",
  "org.junit.jupiter.api.DynamicTest.*",
  
  -- Spring MVC
  "org.springframework.ui.Model",
  "org.springframework.ui.ModelMap",
  "org.springframework.web.bind.annotation.*",
  "org.springframework.stereotype.*",
  "org.springframework.beans.factory.annotation.*",
  "org.springframework.context.annotation.*",
  
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
  "org.mockito.BDDMockito.*",
  
  -- AssertJ
  "org.assertj.core.api.Assertions.*",
  
  -- Lombok
  "lombok.*",
  
  -- Java Util
  "java.util.*",
  "java.util.stream.Collectors.*",
  "java.util.function.*",
  
  -- Java Time
  "java.time.*",
  "java.time.format.DateTimeFormatter.*",
  
  -- JDBC
  -- "org.springframework.jdbc.core.*",
  -- "org.springframework.jdbc.core.JdbcTemplate",
}

return {
  favoriteStaticMembers = favoriteStaticMembers,
}
