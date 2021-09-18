require('plugins')
require('settings')
require('keys')
require('compe-config')
require('lsp')
require('bufferline').setup{}
require('lualine').setup {
    options = { theme  = 'gruvbox' }
}

require('kk.toggleterm')
require('kk.telescope')

require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
  },
}
