HOME = vim.fn.expand("$HOME")

local on_attach_cbk = function(_, bufnr)
  require("kk.lsp-utils").setup_lsp_mappings(_, bufnr)

  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end
  local opts = { noremap = true, silent = true }

  buf_set_keymap('n', '<leader>rr', "<Cmd>lua require'jdtls'.test_class()<CR>", opts)
  buf_set_keymap('n', '<leader>rm', "<Cmd>lua require'jdtls'.test_nearest_method()<CR>", opts)
  -- lua require('jdtls').code_action()<CR>
  -- lua require('jdtls').code_action(true)<CR>
  -- lua require('jdtls').extract_variable()<CR>
  -- lua require('jdtls').extract_variable(true)<CR>
  -- lua require('jdtls').extract_constant()<CR>
  -- lua require('jdtls').extract_constant(true)<CR>
  -- lua require('jdtls').extract_method(true)<CR>
  --

  require('jdtls').setup_dap({ hotcodereplace = 'auto' })
end

-- dap bundles
local bundles = {
  vim.fn.glob(HOME .. "/workspace/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar")
};
vim.list_extend(bundles, vim.split(vim.fn.glob(HOME .. "/workspace/vscode-java-test/server/*.jar"), "\n"))

require("lspconfig").jdtls.setup({
  cmd = {
    HOME .. "/.sdkman/candidates/java/17.0.4-amzn/bin/java",
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-javaagent:/Users/kklimczyk/jdt-language-server/lombok.jar",
    "-Xms1g",
    "-Xmx2G",
    "-jar", HOME .. "/jdt-language-server/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar",
    "-configuration", HOME .. "/jdt-language-server/config_mac",
    "-data", HOME .. "/lsp/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t"),
    "--add-modules=ALL-SYSTEM",
    "--add-opens java.base/java.util=ALL-UNNAMED",
    "--add-opens java.base/java.lang=ALL-UNNAMED",
  },
  on_attach = on_attach_cbk,

  init_options = {
    bundles = bundles
  },

  capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities()),
  flags = {
    debounce_text_changes = 150,
  },
})

vim.cmd("command! JdtBytecode lua require('jdtls').javap()")
