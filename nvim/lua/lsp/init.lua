require('lsp.lua')
require('lsp.java')

-- LSP
-- map buffer local keybindings when the language server attaches
local nvim_lsp = require('lspconfig')

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { "pyright", "ccls"}
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = require'kk.lsp-utils'.setup_lsp_mappings,
    flags = {
      debounce_text_changes = 150,
    }
  }
end

