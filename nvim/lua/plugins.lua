local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  execute 'packadd packer.nvim'
end

-- This file can be loaded by calling `lua require('plugins')` from your init.vim

return require('packer').startup(function()
  use 'wbthomason/packer.nvim'
  --
  use 'christoomey/vim-tmux-navigator'
  use 'easymotion/vim-easymotion'
  use 'chaoren/vim-wordmotion'
  use 'kyazdani42/nvim-tree.lua'
  use 'tpope/vim-commentary'
  use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use {'nvim-treesitter/playground'}
  use 'kevinhwang91/nvim-bqf'
  use 'junegunn/fzf'
  use 'mhinz/vim-signify'
  -- telescope
  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'nvim-telescope/telescope.nvim'
  use 'nvim-telescope/telescope-fzy-native.nvim'
  use 'nvim-telescope/telescope-project.nvim'
  -- lsp
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/nvim-compe'
  use 'mfussenegger/nvim-jdtls'
  -- UI
  use 'norcalli/nvim-colorizer.lua'
  use 'sainnhe/gruvbox-material'
  use 'kyazdani42/nvim-web-devicons'
  use 'akinsho/nvim-bufferline.lua'
  use 'akinsho/nvim-toggleterm.lua'
  use 'psliwka/vim-smoothie'
end)
