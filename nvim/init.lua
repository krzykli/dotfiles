require('plugins')
require('impatient')
require('settings')
require('keys')
require('lsp')
require('bufferline').setup{}

require('kk.luasnip')
require('kk.cmp')
require('kk.toggleterm')
require('kk.telescope')
require('kk.feline')
require('kk.gitsigns')
require('kk.notify')

require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
  },
}

vim.highlight.link("VirtualTextError", "Red", true)

-- require'nvim-tree'.setup {
--   diagnostics = {
--     enable = true,
--   },
--   git = {
--     enable = false,
--   },
--   view = {
--     width = 50,
--   },
-- }
