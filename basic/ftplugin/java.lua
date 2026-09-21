local ok, jdtls = pcall(require, "jdtls")
if not ok then
  return
end

local root_dir = vim.fs.root(0, { "gradlew", "mvnw", "pom.xml", "build.gradle", "build.gradle.kts", ".git" })
local command = vim.fn.exepath("jdtls")
if not root_dir or command == "" then
  vim.notify("Java LSP is unavailable; run :MasonInstall jdtls", vim.log.levels.WARN)
  return
end

jdtls.start_or_attach({
  name = "jdtls",
  cmd = { command },
  root_dir = root_dir,
  capabilities = require("configs.lsp").capabilities,
  settings = {
    java = {
      eclipse = { downloadSources = true },
      maven = { downloadSources = true },
      configuration = { updateBuildConfiguration = "interactive" },
      implementationsCodeLens = { enabled = true },
      referencesCodeLens = { enabled = true },
    },
  },
})
