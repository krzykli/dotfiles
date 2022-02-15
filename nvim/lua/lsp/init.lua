require('lsp.lua')
require('lsp.java')

-- LSP
-- map buffer local keybindings when the language server attaches
local nvim_lsp = require('lspconfig')

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { "pyright", "ccls", "tsserver"}

for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),

    on_attach = require'kk.lsp-utils'.setup_lsp_mappings,

    flags = {
      debounce_text_changes = 150,
    }
  }
end

require'lspconfig'.gopls.setup{}
