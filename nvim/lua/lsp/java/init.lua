
HOME = vim.fn.expand('$HOME')


local setup_java_lsp_mappings = function(bufnr)
    require'kk.lsp-utils'.setup_lsp_mappings(bufnr)

    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local opts = { noremap=true, silent=true }

    buf_set_keymap('n', '<leader>mv', '<Cmd>lua require"kk.lsp-utils".split_command("mvn clean verify")<CR>', opts)
    buf_set_keymap('n', '<leader>oi', "<Cmd>lua require'jdtls'.organize_imports()<CR>", opts)
    -- buf_set_keymap('n', '<leader>rr', "<Cmd>lua require'jdtls'.code_action(false, 'refactor')<CR>", opts)
    -- lua require('jdtls').code_action()<CR>
    -- lua require('jdtls').code_action(true)<CR>
    -- lua require('jdtls').extract_variable()<CR>
    -- lua require('jdtls').extract_variable(true)<CR>
    -- lua require('jdtls').extract_constant()<CR>
    -- lua require('jdtls').extract_constant(true)<CR>
    -- lua require('jdtls').extract_method(true)<CR>
end


require'lspconfig'.jdtls.setup{
  cmd = {
    HOME .. "/.sdkman/candidates/java/11.0.10.hs-adpt/bin/java",
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-javaagent:/Users/kklimczyk/jdt-language-server/lombok.jar",
    "-Xms1g",
    "-Xmx2G",
    "-jar",
    HOME .. "/jdt-language-server/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar",
    "-configuration",
    HOME .. "/jdt-language-server/config_mac",
    "-data",
    HOME .. "/lsp/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t'),
    "--add-modules=ALL-SYSTEM",
    "--add-opens java.base/java.util=ALL-UNNAMED",
    "--add-opens java.base/java.lang=ALL-UNNAMED",
  },
  on_attach = setup_java_lsp_mappings,
  flags = {
    debounce_text_changes = 150,
  }
}
