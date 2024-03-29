local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  execute 'packadd packer.nvim'
end

return require('packer').startup({function()
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
  -- use 'mhinz/vim-signify'
  use 'lewis6991/gitsigns.nvim'
  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'
  -- telescope
  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'nvim-telescope/telescope.nvim'
  use 'nvim-telescope/telescope-fzy-native.nvim'
  use 'nvim-telescope/telescope-project.nvim'
  -- lsp
  use 'neovim/nvim-lspconfig'
  use 'mfussenegger/nvim-jdtls'
  -- autocomplete
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-nvim-lua'
  use 'hrsh7th/cmp-path'
  -- UI
  use 'norcalli/nvim-colorizer.lua'
  use 'sainnhe/gruvbox-material'
  use 'kyazdani42/nvim-web-devicons'
  use 'akinsho/nvim-bufferline.lua'
  use 'akinsho/nvim-toggleterm.lua'
  use 'famiu/feline.nvim'
  use 'psliwka/vim-smoothie'
  use 'onsails/lspkind-nvim'

  end,
  config = {
    display = {
      open_fn = require('packer.util').float,
    }
}})
