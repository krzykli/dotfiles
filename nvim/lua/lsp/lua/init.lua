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
                checkThirdParty = false,
                preloadFileSize = 500
            }
        }
    }
}


