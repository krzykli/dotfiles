vim.g.mapleader = ";"

vim.opt.clipboard = "unnamedplus"

vim.opt.timeoutlen = 200
vim.opt.signcolumn = "yes"
vim.opt.laststatus = 3 -- global statusline
vim.opt.pumheight = 20
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.smartindent = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4

vim.opt.number = true
vim.opt.numberwidth = 2
vim.opt.relativenumber = true

require("plugins")
require("mappings")

vim.cmd([[hi MsgArea guibg=#222222 guifg=#00CC77]])
vim.cmd([[set nowrap]])

vim.cmd('augroup PythonBlack')
vim.cmd('autocmd!')
vim.cmd('autocmd FileType python nnoremap <buffer> <leader>fm :!poetry run black %<CR><CR>')
vim.cmd('augroup END')

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*" },
  command = [[%s/\s\+$//e]],
})