vim.g.mapleader = ';'
--vim.api.nvim_set_keymap('n', ';', '<NOP>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('i', 'jk', '<ESC>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<Leader>h', ':set hlsearch!<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<Leader>w', ':w<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<Leader>re', ':so ~/.config/nvim/init.lua<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<Leader>t', ':NvimTreeToggle<CR>', {noremap = true, silent = true})

-- quickfix
vim.api.nvim_set_keymap('n', '[', ':cprevious<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', ']', ':cnext<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '++', ':cclose<CR>', {noremap = true, silent = true})

-- windows
vim.api.nvim_set_keymap('n', '<C-k>', ':wincmd k<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<C-j>', ':wincmd j<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<C-h>', ':wincmd h<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<C-l>', ':wincmd l<CR>', {noremap = true, silent = true})

vim.api.nvim_set_keymap('n', '<C-l>', ':wincmd l<CR>', {noremap = true, silent = true})

-- tabs
vim.api.nvim_set_keymap('n', 'tn', ':tabnew<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'tj', ':tabprevious<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'tk', ':tabnext<CR>', {noremap = true, silent = true})
-- buffers
-- vim.api.nvim_set_keymap('n', 'tn', ':enew<CR>', {noremap = true, silent = true})
-- vim.api.nvim_set_keymap('n', 'tj', ':bprevious<CR>', {noremap = true, silent = true})
-- vim.api.nvim_set_keymap('n', 'tk', ':bnext<CR>', {noremap = true, silent = true})

-- telescope
vim.api.nvim_set_keymap('n', '<Leader>fa', ":lua require('telescope.builtin').find_files()<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<Leader>fg', ":lua require('telescope.builtin').git_files()<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<Leader>fq', ":lua require('telescope.builtin').quickfix()<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<Leader>fe', ":lua require('telescope.builtin').lsp_document_symbols()<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<Leader>fr', ":lua require('telescope.builtin').lsp_references()<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<Leader>fl', ":lua require('telescope.builtin').live_grep()<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<Leader>fb', ":lua require('telescope.builtin').buffers()<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<Leader>fh', ":lua require('telescope.builtin').help_tags()<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<Leader>bb', ":lua require('telescope.builtin').git_branches()<CR>", {noremap = true, silent = true})

vim.api.nvim_set_keymap('n', '<Leader>vc', ":lua require('kk.telescope').search_dotfiles()<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<Leader>fs', ":lua require('kk.telescope').switch_workplace()<CR>", {noremap = true, silent = true})

-- bufferline
vim.api.nvim_set_keymap('n', '<Leader>gt', ":BufferLinePick<CR>", {noremap = true, silent = true})
