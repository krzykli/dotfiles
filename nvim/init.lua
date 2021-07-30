require('plugins')
require('settings')
require('keys')
require('compe-config')
require('lsp')
require('bufferline').setup{}

require('kk.toggleterm')

require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
  },
}
