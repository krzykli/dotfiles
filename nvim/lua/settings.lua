vim.cmd("colorscheme gruvbox-material")

vim.cmd("set termguicolors")
vim.cmd("set hidden")
vim.cmd("set ignorecase")
vim.cmd("set smartcase")
vim.cmd("set clipboard+=unnamed")
vim.cmd("set noswapfile")
vim.cmd("set nobackup")
vim.cmd("set scrolloff=8")
vim.cmd("set undodir=~/.vim/undodir")
vim.cmd("set undofile")
vim.cmd("set number")
vim.cmd("set relativenumber")
vim.cmd("set laststatus=3")



vim.opt.guifont = { "Hack Nerd Font", "h12" }
vim.g.hidden = true
vim.o.wrap = false
vim.o.splitright = true
vim.o.clipboard = "unnamedplus"
vim.o.cursorline = true
vim.o.expandtab = true
vim.o.list = true
vim.o.listchars = "trail:·,tab:➤ "
vim.o.scrolloff = 10
vim.o.scrolloff = 10
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.smartindent = true
vim.o.smarttab = true
vim.o.softtabstop = 4
vim.o.termguicolors = true
vim.o.timeoutlen = 200

if vim.fn.exists('g:neovide') then
    vim.cmd("let g:neovide_floating_blur_amount_x = 3.0")
    vim.cmd("let g:neovide_floating_blur_amount_y = 3.0")
    vim.cmd("let g:neovide_scroll_animation_length = 0.5")
    vim.cmd("let g:neovide_cursor_animation_length = 0.03")
    vim.cmd("let g:neovide_window_floating_opacity = 1")
end
vim.cmd("let g:neovide_floating_blur_amount_x = 3.0")
vim.cmd("let g:neovide_floating_blur_amount_y = 3.0")
vim.cmd("let g:neovide_scroll_animation_length = 0.5")
vim.cmd("let g:neovide_cursor_animation_length = 0.03")
vim.cmd("let g:neovide_transparency = 1")
vim.cmd("let g:neovide_window_floating_opacity = 1")

