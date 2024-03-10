local function run_black()
    vim.cmd('!poetry run black %<CR>')
end

vim.cmd('augroup PythonBlack')
vim.cmd('autocmd!')

-- Keybinding for Python files
vim.cmd('autocmd FileType python nnoremap <buffer> <leader>f :lua run_black()<CR>')

vim.cmd('augroup END')
