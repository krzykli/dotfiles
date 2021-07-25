require('plugins')
require('settings')
require('keys')
require('compe-config')
require('lsp.lua')
require('lsp.java')
require('kk.toggleterm')

require('bufferline').setup{}

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

-- https://github.com/sumneko/lua-language-server/wiki/Build-and-Run-(Standalone)
USER = vim.fn.expand('$USER')

local sumneko_root_path = ""
local sumneko_binary = ""

sumneko_root_path = "/Users/" .. USER .. "/.config/nvim/lua-language-server"
sumneko_binary = "/Users/" .. USER .. "/.config/nvim/lua-language-server/bin/macOS/lua-language-server"
require'lspconfig'.sumneko_lua.setup {
    on_attach = require'kk.lsp-utils'.setup_lsp_mappings,
    cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"},
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
                -- Setup your lua path
                path = vim.split(package.path, ';')
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = {'vim'}
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = {[vim.fn.expand('$VIMRUNTIME/lua')] = true, [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true},
                checkThirdParty = false
            }
        }
    }
}

require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
  },
}
