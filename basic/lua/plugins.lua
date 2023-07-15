local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup {

  {
    "chaoren/vim-wordmotion",
    event = "VeryLazy",
  },

  {
    "kevinhwang91/nvim-bqf",
    event = "VeryLazy",
  },

  {
    "stevearc/oil.nvim",
    config = function ()
      require("oil").setup()
    end,
    event = "VeryLazy",
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require('nvim-surround').setup {
        -- Configuration here, or leave empty to use defaults
      }
    end,
  },
  {
    "Mofiqul/vscode.nvim",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      -- load the colorscheme here
      require('vscode').setup {
        require('vscode').load()
      }
    end,
  },

  "mbbill/undotree",

  {
    "jose-elias-alvarez/null-ls.nvim",
    event = "VeryLazy",
    config = function()
      local null_ls = require "null-ls"
      null_ls.setup {
        sources = {
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.formatting.rustfmt,
          null_ls.builtins.diagnostics.eslint,
          null_ls.builtins.completion.spell,

          null_ls.builtins.formatting.black,
          null_ls.builtins.formatting.google_java_format,
          null_ls.builtins.diagnostics.checkstyle.with {
            extra_args = { "-c", "/Users/kklimczyk/workspace/control-automation/checkstyle.xml" }, -- or "/sun_checks.xml" or path to self written rules
          },
        },
      }
    end,
  },

  {
    "nvim-lua/plenary.nvim",
  },

  {
    "gbprod/yanky.nvim",
    config = function()
      require("yanky").setup(require("configs.others").yanky())
    end,
    init = function()
      --require("core.utils").load_mappings "yanky"
    end,
    event = "VeryLazy"
  },
  {
    "nvim-tree/nvim-web-devicons",
    --after = "ui",
    config = function()
      require("configs.others").devicons()
    end,
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    init = function()
      -- require("core.utils").load_mappings "blankline"
    end,
    config = function()
      require("configs.others").blankline()
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require "configs.treesitter"
    end,
    lazy=true,
  },

  -- git stuff
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("configs.others").gitsigns()
    end,
  },

  -- lsp stuff
  {
    "williamboman/mason.nvim",

    cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
    config = function()
      require "configs.mason"
    end,
  },

  {
    "glepnir/lspsaga.nvim",
    branch = "main",
    config = function()
      require("lspsaga").setup {
        lightbulb = {
          enable = true,
          enable_in_insert = false,
          sign = true,
          sign_priority = 40,
          virtual_text = false,
        },
        symbol_in_winbar = {
          separator = " | ",
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
            jump = "{ CR }",
            expand_collapse = "u",
            quit = "q",
          },
        },
      }
    end,
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },

  {
    "folke/neodev.nvim",
    config = function()
      require("neodev").setup {}
    end,
    event = "VeryLazy",
  },

  {
    "neovim/nvim-lspconfig",
    lazy = true,
    dependencies = { "folke/neodev.nvim" },
    config = function()
      require "configs.lspconfig"
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
      require "configs.cmp"
    end,
    event = "VeryLazy",
  },

  {
    "L3MON4D3/LuaSnip",
    wants = "friendly-snippets",
    --after = "nvim-cmp",
    config = function()
      require("configs.others").luasnip()
    end,
    event = "VeryLazy",
  },

  { "saadparwaiz1/cmp_luasnip", event = "VeryLazy" },
  { "hrsh7th/cmp-nvim-lua", event = "VeryLazy" },
  { "hrsh7th/cmp-nvim-lsp", event = "VeryLazy" },
  { "hrsh7th/cmp-buffer", event = "VeryLazy" },
  { "hrsh7th/cmp-path", event = "VeryLazy" },

  -- misc plugins
  {
    "windwp/nvim-autopairs",
    --after = "nvim-cmp",
    config = function()
      require("configs.others").autopairs()
    end,
    event = "VeryLazy",
  },

  {
    "numToStr/Comment.nvim",
    keys = { "gc", "gb" },
    config = function()
      require("configs.others").comment()
    end,
    init = function()
      -- require("core.utils").load_mappings "comment"
    end,
    event = "VeryLazy",
  },

  -- file managing , picker etc
  {
    "nvim-telescope/telescope.nvim",
    config = function()
      require "configs.telescope"
    end,
    event = "VeryLazy",
  },

  {"nvim-telescope/telescope-ui-select.nvim", event = "VeryLazy"},
  {"nvim-telescope/telescope-project.nvim", event = "VeryLazy"},

  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy=true,
    opts = {},
  },

  {
    "simrat39/rust-tools.nvim",
    event = "VeryLazy",
  },

  {
    "mfussenegger/nvim-jdtls",
    event = "VeryLazy",
  },

  {
    "alexghergh/nvim-tmux-navigation",
    config = function()
      local nvim_tmux_nav = require "nvim-tmux-navigation"

      nvim_tmux_nav.setup {
        disable_when_zoomed = true, -- defaults to false
        keybindings = {
          left = "<C-h>",
          down = "<C-j>",
          up = "<C-k>",
          right = "<C-l>",
          last_active = "<C-\\>",
          next = "<C-Space>",
        }
      }
    end,
  },
  {
    "kdheepak/lazygit.nvim",
    -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    event = "VeryLazy",
  },
}
