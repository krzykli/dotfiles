vim.g.mapleader = ";"

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({

  'chaoren/vim-wordmotion',
  'kevinhwang91/nvim-bqf',

  {
    "nvim-lua/plenary.nvim",
  },

  {
    "gbprod/yanky.nvim",
    config = function ()
      require("yanky").setup(require("plugins.configs.others").yanky())
    end,
    init = function()
      require("core.utils").load_mappings "yanky"
    end
  },

  {
    'NvChad/extensions',
  },

  {
    "NvChad/base46",
    config = function()
      local ok, base46 = pcall(require, "base46")

      if ok then
        base46.load_theme()
      end
    end,
  },

  {
    "NvChad/ui",
    --after = "base46",
    config = function()
      local present, nvchad_ui = pcall(require, "nvchad_ui")

      if present then
        nvchad_ui.setup()
      end
    end,
  },

  {
    "NvChad/nvterm",
    config = function()
      require "plugins.configs.nvterm"
    end,
    init = function()
      require("core.utils").load_mappings "nvterm"
    end,
  },

  {
    "nvim-tree/nvim-web-devicons",
    --after = "ui",
    config = function()
      require("plugins.configs.others").devicons()
    end,
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    lazy = true,
    init = function()
      require("core.utils").load_mappings "blankline"
    end,
    config = function()
      require("plugins.configs.others").blankline()
    end,
  },

  {
    "NvChad/nvim-colorizer.lua",
    lazy = true,
    config = function()
      require("plugins.configs.others").colorizer()
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require "plugins.configs.treesitter"
    end,
  },
  "nvim-treesitter/playground",

  -- git stuff
  {
    "lewis6991/gitsigns.nvim",
    ft = "gitcommit",
    config = function()
      require("plugins.configs.others").gitsigns()
    end,
  },

  -- lsp stuff
  {
    "williamboman/mason.nvim",

    cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
    config = function()
      require "plugins.configs.mason"
    end,
  },

  {
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
    dependencies = { "nvim-tree/nvim-web-devicons" }
  },

  {
    "folke/neodev.nvim",
    config = function()
      require("neodev").setup({})
    end
  },

  {
    "neovim/nvim-lspconfig",
    lazy = true,
    dependencies = {"folke/neodev.nvim"},
    config = function()
      require "plugins.configs.lspconfig"
    end,
  },

  -- load luasnips + cmp related in insert mode only

  {
    "rafamadriz/friendly-snippets",
    event = "InsertEnter",
  },

  {
    "hrsh7th/nvim-cmp",
    --after = "friendly-snippets",
    config = function()
      require "plugins.configs.cmp"
    end,
  },

  {
    "L3MON4D3/LuaSnip",
    wants = "friendly-snippets",
    --after = "nvim-cmp",
    config = function()
      require("plugins.configs.others").luasnip()
    end,
  },

  -- {"saadparwaiz1/cmp_luasnip", after = "LuaSnip" },
  -- {"hrsh7th/cmp-nvim-lua", after = "cmp_luasnip" },
  -- {"hrsh7th/cmp-nvim-lsp", after = "cmp-nvim-lua" },
  -- {"hrsh7th/cmp-buffer", after = "cmp-nvim-lsp" },
  -- {"hrsh7th/cmp-path", after = "cmp-buffer" },
  {"saadparwaiz1/cmp_luasnip"},
  {"hrsh7th/cmp-nvim-lua"},
  {"hrsh7th/cmp-nvim-lsp"},
  {"hrsh7th/cmp-buffer"},
  {"hrsh7th/cmp-path"},

  -- misc plugins
  {
    "windwp/nvim-autopairs",
    --after = "nvim-cmp",
    config = function()
      require("plugins.configs.others").autopairs()
    end,
  },

  {
    "numToStr/Comment.nvim",
    keys = { "gc", "gb" },
    config = function()
      require("plugins.configs.others").comment()
    end,
    init = function()
      require("core.utils").load_mappings "comment"
    end,
  },

  -- file managing , picker etc
  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    config = function()
      require "plugins.configs.nvimtree"
    end,
    init = function()
      require("core.utils").load_mappings "nvimtree"
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    config = function()
      require "plugins.configs.telescope"
    end,
    init = function()
      require("core.utils").load_mappings "telescope"
    end,
  },

  'nvim-telescope/telescope-ui-select.nvim',

  {
    "folke/trouble.nvim",
    dependencies = {"nvim-tree/nvim-web-devicons"},
    config = function()
      require("trouble").setup {}
    end,
  },

  'simrat39/rust-tools.nvim',

  {
    'mfussenegger/nvim-dap',
    config = function()
      require "plugins.configs.dap"
    end,
  },

  'mfussenegger/nvim-dap-python',
  'mfussenegger/nvim-jdtls',

  {
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
  },


  {
    'VonHeikemen/fine-cmdline.nvim',
    dependencies = {
      {'MunifTanjim/nui.nvim'}
    },
    cmd = {"FineCmdline"},
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
  },


  { 'alexghergh/nvim-tmux-navigation',
    config = function()
      local nvim_tmux_nav = require('nvim-tmux-navigation')

      nvim_tmux_nav.setup {
        disable_when_zoomed = true -- defaults to false
      }
    end,
    init = function()
      require("core.utils").load_mappings "tmux"
    end
  },
})

