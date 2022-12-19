local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({ "git", "clone", "https://github.com/wbthomason/packer.nvim", install_path })
  execute("packadd packer.nvim")
end

return require("packer").startup({
  function()
    use("wbthomason/packer.nvim")
    use { -- LSP Configuration & Plugins
        'neovim/nvim-lspconfig',
        requires = {
          -- Automatically install LSPs to stdpath for neovim
          'williamboman/mason.nvim',
          'williamboman/mason-lspconfig.nvim',

          -- Useful status updates for LSP
          'j-hui/fidget.nvim',
        },
      }
    --
    use("lewis6991/impatient.nvim")
    use("rcarriga/nvim-notify")
    use("christoomey/vim-tmux-navigator")
    use {
     'phaazon/hop.nvim',
     branch = 'v2',
   }
    -- use("hrsh7th/nvim-pasta")
    use("chaoren/vim-wordmotion")
    use("tpope/vim-commentary")
    use 'nvim-treesitter/nvim-treesitter-context'
    use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
    use({ "nvim-treesitter/playground" })
    use("kevinhwang91/nvim-bqf")
    use("lewis6991/gitsigns.nvim")
    use({
      "hrsh7th/nvim-cmp",
    })
    use({ "saadparwaiz1/cmp_luasnip" })
    use({
      "L3MON4D3/LuaSnip",
      after = "nvim-cmp",
    })
    use('simrat39/rust-tools.nvim')
    use('gbprod/yanky.nvim')
    -- telescope
    use("hashivim/vim-terraform")
    use("nvim-lua/popup.nvim")
    use("nvim-lua/plenary.nvim")
    use("nvim-telescope/telescope.nvim")
    use("nvim-telescope/telescope-fzy-native.nvim")
    use("nvim-telescope/telescope-ui-select.nvim")
    use("nvim-telescope/telescope-project.nvim")
    use("nvim-telescope/telescope-dap.nvim")
    -- lsp
    use("mfussenegger/nvim-jdtls")
    -- dap
    use("mfussenegger/nvim-dap")
    use("mfussenegger/nvim-dap-python")
    use({ "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } })
    -- autocomplete
    use("hrsh7th/cmp-buffer")
    use("hrsh7th/cmp-nvim-lsp")
    use("hrsh7th/cmp-nvim-lua")
    use("hrsh7th/cmp-path")
    -- UI
    use("folke/zen-mode.nvim")
    use("folke/trouble.nvim")
    use("kyazdani42/nvim-web-devicons")
    use("norcalli/nvim-colorizer.lua")
    use("sainnhe/gruvbox-material")
    use("akinsho/nvim-bufferline.lua")
    use {"akinsho/toggleterm.nvim", tag = 'v2.*', config = function()
        require("toggleterm").setup()
    end}
    use("famiu/feline.nvim")
    use("onsails/lspkind-nvim")
    use("dhruvasagar/vim-zoom")
  end,
  config = {
    display = {
      open_fn = require("packer.util").float,
    },
  },
})
