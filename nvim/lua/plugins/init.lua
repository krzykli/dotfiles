local packer = require("packer")

local init_options = require("plugins.configs.others").packer_init()
packer.init(init_options)

return packer.startup(function(use)
  use 'lewis6991/impatient.nvim'
  use 'wbthomason/packer.nvim'
  use "christoomey/vim-tmux-navigator"
  use 'chaoren/vim-wordmotion'
  use 'kevinhwang91/nvim-bqf'

  use {
    "nvim-lua/plenary.nvim",
    module = "plenary"
  }

  use {
    "gbprod/yanky.nvim",
    config = function ()
      require("yanky").setup(require("plugins.configs.others").yanky())
    end,
    setup = function()
      require("core.utils").load_mappings "yanky"
    end
  }

  use {
    'NvChad/extensions',
    module = {"telescope", "nvchad"}
  }

  use {
    "NvChad/base46",
    config = function()
      local ok, base46 = pcall(require, "base46")

      if ok then
        base46.load_theme()
      end
    end,
  }

  use {
    "NvChad/ui",
    after = "base46",
    config = function()
      local present, nvchad_ui = pcall(require, "nvchad_ui")

      if present then
        nvchad_ui.setup()
      end
    end,
  }

  use {
    "NvChad/nvterm",
    module = "nvterm",
    config = function()
      require "plugins.configs.nvterm"
    end,
    setup = function()
      require("core.utils").load_mappings "nvterm"
    end,
  }

  use {
    "nvim-tree/nvim-web-devicons",
    after = "ui",
    module = "nvim-web-devicons",
    config = function()
      require("plugins.configs.others").devicons()
    end,
  }

  use {
    "lukas-reineke/indent-blankline.nvim",
    opt = true,
    setup = function()
      require("core.lazy_load").on_file_open "indent-blankline.nvim"
      require("core.utils").load_mappings "blankline"
    end,
    config = function()
      require("plugins.configs.others").blankline()
    end,
  }

  use {
    "NvChad/nvim-colorizer.lua",
    opt = true,
    setup = function()
      require("core.lazy_load").on_file_open "nvim-colorizer.lua"
    end,
    config = function()
      require("plugins.configs.others").colorizer()
    end,
  }

  use {
    "nvim-treesitter/nvim-treesitter",
    module = "nvim-treesitter",
    setup = function()
      require("core.lazy_load").on_file_open "nvim-treesitter"
    end,
    cmd = require("core.lazy_load").treesitter_cmds,
    run = ":TSUpdate",
    config = function()
      require "plugins.configs.treesitter"
    end,
  }
  use "nvim-treesitter/playground"

  -- git stuff
  use {
    "lewis6991/gitsigns.nvim",
    ft = "gitcommit",
    setup = function()
      require("core.lazy_load").gitsigns()
    end,
    config = function()
      require("plugins.configs.others").gitsigns()
    end,
  }

  -- lsp stuff
  use {
    "williamboman/mason.nvim",
    cmd = require("core.lazy_load").mason_cmds,
    config = function()
      require "plugins.configs.mason"
    end,
  }

  use {
    "glepnir/lspsaga.nvim",
    branch = "main",
    config = function()
      require("lspsaga").setup({
         lightbulb = {
            enable = true,
            enable_in_insert = false,
            sign = true,
            sign_priority = 40,
            virtual_text = false,
          },
          outline = {
            win_position = "right",
            win_with = "",
            win_width = 30,
            show_detail = true,
            auto_preview = false,
            auto_refresh = true,
            auto_close = true,
            custom_sort = nil,
            keys = {
              jump = "<CR>",
              expand_collapse = "u",
              quit = "q",
            },
          },
      })
    end,
    requires = { {"nvim-tree/nvim-web-devicons"} }
  }

  use {
    "neovim/nvim-lspconfig",
    opt = true,
    setup = function()
      require("core.lazy_load").on_file_open "nvim-lspconfig"
    end,
    config = function()
      require "plugins.configs.lspconfig"
    end,
  }

  -- load luasnips + cmp related in insert mode only

  use {
    "rafamadriz/friendly-snippets",
    module = { "cmp", "cmp_nvim_lsp" },
    event = "InsertEnter",
  }

  use {
    "hrsh7th/nvim-cmp",
    after = "friendly-snippets",
    config = function()
      require "plugins.configs.cmp"
    end,
  }

  use {
    "L3MON4D3/LuaSnip",
    wants = "friendly-snippets",
    after = "nvim-cmp",
    config = function()
      require("plugins.configs.others").luasnip()
    end,
  }

  use {"saadparwaiz1/cmp_luasnip", after = "LuaSnip" }
  use {"hrsh7th/cmp-nvim-lua", after = "cmp_luasnip" }
  use {"hrsh7th/cmp-nvim-lsp", after = "cmp-nvim-lua" }
  use {"hrsh7th/cmp-buffer", after = "cmp-nvim-lsp" }
  use {"hrsh7th/cmp-path", after = "cmp-buffer" }

  -- misc plugins
  use {
    "windwp/nvim-autopairs",
    after = "nvim-cmp",
    config = function()
      require("plugins.configs.others").autopairs()
    end,
  }

  use {
    "numToStr/Comment.nvim",
    module = "Comment",
    keys = { "gc", "gb" },
    config = function()
      require("plugins.configs.others").comment()
    end,
    setup = function()
      require("core.utils").load_mappings "comment"
    end,
  }

  -- file managing , picker etc
  use {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    config = function()
      require "plugins.configs.nvimtree"
    end,
    setup = function()
      require("core.utils").load_mappings "nvimtree"
    end,
  }

  use {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    config = function()
      require "plugins.configs.telescope"
    end,
    setup = function()
      require("core.utils").load_mappings "telescope"
    end,
  }

  use 'nvim-telescope/telescope-ui-select.nvim'

  use {
    "folke/trouble.nvim",
    requires = "nvim-tree/nvim-web-devicons",
    config = function()
      require("trouble").setup {}
    end,
  }

  use 'simrat39/rust-tools.nvim'

  use {
    'mfussenegger/nvim-dap',
    config = function()
      require "plugins.configs.dap"
    end,
  }

  use 'mfussenegger/nvim-dap-python'
  use 'mfussenegger/nvim-jdtls'

  use {
    "rcarriga/nvim-dap-ui",
    config = function()
      require("dapui").setup({
        icons = { expanded = "▾", collapsed = "▸" },
        mappings = {
          -- Use a table to apply multiple mappings
          expand = { "<CR>", "<2-LeftMouse>" },
          open = "o",
          remove = "d",
          edit = "e",
          repl = "r",
          toggle = "t",
        },
        layouts = {
          {
            elements = {
              "scopes",
              "breakpoints",
              "stacks",
              "watches",
            },
            size = 40,
            position = "left",
          },
          {
            elements = {
              "repl",
              "console",
            },
            size = 10,
            position = "bottom",
          },
        },
        floating = {
          max_height = nil, -- These can be integers or a float between 0 and 1.
          max_width = nil, -- Floats will be treated as percentage of your screen.
          border = "single", -- Border style. Can be "single", "double" or "rounded"
          mappings = {
            close = { "q", "<Esc>" },
          },
        },
        windows = { indent = 1 },
      })
    end,
  }


  use {
    'VonHeikemen/fine-cmdline.nvim',
    requires = {
      {'MunifTanjim/nui.nvim'}
    },
    config = function ()
      require('fine-cmdline').setup({
        cmdline = {
          prompt = "  ",
        },
        popup = {
          position = {
            row = '30%',
            col = '50%',
          },
          size = {
            width = '50%',
          },
          border = {
            style = 'rounded',
          },
        }
      })
  end
  }

end)

