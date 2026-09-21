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
      require("vscode").setup({})
      require("vscode").load()
    end,
  },

  "mbbill/undotree",
  {
    "nvim-flutter/flutter-tools.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim", -- Optional but recommended for beautiful UIs
    },
    config = function()
      require("flutter-tools").setup({
        lsp = {
          color_render = true, -- Highlights color codes inline
          settings = {
            showTodos = true,
            completeFunctionCalls = true,
          },
        },
      })
    end,
  },

  -- {
  --   "jose-elias-alvarez/null-ls.nvim",
  --   event = "VeryLazy",
  --   config = function()
  --     local null_ls = require "null-ls"
  --     null_ls.setup {
  --       sources = {
  --         null_ls.builtins.formatting.stylua,
  --         null_ls.builtins.formatting.rustfmt,
  --         null_ls.builtins.diagnostics.eslint,
  --         null_ls.builtins.completion.spell,
  --
  --         null_ls.builtins.formatting.black,
  --         null_ls.builtins.formatting.google_java_format,
  --         null_ls.builtins.diagnostics.checkstyle.with {
  --           extra_args = { "-c", "/Users/kklimczyk/workspace/control-automation/checkstyle.xml" }, -- or "/sun_checks.xml" or path to self written rules
  --         },
  --       },
  --     }
  --   end,
  -- },

  {
    "nvim-lua/plenary.nvim",
  },

  {
    "gbprod/yanky.nvim",
    config = function()
      require("yanky").setup(require("configs.others").yanky())
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
    main = "ibl",
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
    lazy = false,
    config = function()
      require "configs.mason"
    end,
  },

  -- {
  --   "glepnir/lspsaga.nvim",
  --   branch = "main",
  --   config = function()
  --     require("lspsaga").setup {
  --       lightbulb = {
  --         enable = true,
  --         enable_in_insert = false,
  --         sign = true,
  --         sign_priority = 40,
  --         virtual_text = false,
  --       },
  --       symbol_in_winbar = {
  --         separator = " | ",
  --       },
  --       outline = {
  --         win_position = "right",
  --         win_with = "",
  --         win_width = 30,
  --         show_detail = true,
  --         auto_preview = false,
  --         auto_refresh = true,
  --         auto_close = true,
  --         custom_sort = nil,
  --         keys = {
  --           jump = "{ CR }",
  --           expand_collapse = "u",
  --           quit = "q",
  --         },
  --       },
  --     }
  --   end,
  --   dependencies = { "nvim-tree/nvim-web-devicons" },
  -- },

  {
    "folke/neodev.nvim",
    config = function()
      require("neodev").setup {}
    end,
    event = "VeryLazy",
  },

  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "folke/neodev.nvim" },
    config = function()
      require "configs.lsp"
    end,
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
    -- follow latest release.
    version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    -- install jsregexp (optional!).
    build = "make install_jsregexp"
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
    opts = {},
    event = "VeryLazy",
  },

  {
    "yetone/avante.nvim",
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    -- ⚠️ must add this setting! ! !
    build = vim.fn.has("win32") ~= 0
      and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
      or "make",
    event = "VeryLazy",
    version = false, -- Never set this value to "*"! Never!
    ---@module 'avante'
    ---@type avante.Config
    opts = {
      provider = "deepseek",
      auto_suggestions_provider = "deepseek",
      providers = {
        deepseek = {
          __inherited_from = "openai",
          api_key_name = "DEEPSEEK_API_KEY",
          endpoint = "https://api.deepseek.com",
          model = "deepseek-v4-flash", -- ⚡ Official DeepSeek V4 Flash identifier
          max_tokens = 8192,
        },
      },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "nvim-mini/mini.pick", -- for file_selector provider mini.pick
      "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
      "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
      "ibhagwan/fzf-lua", -- for file_selector provider fzf
      "stevearc/dressing.nvim", -- for input provider dressing
      "folke/snacks.nvim", -- for input provider snacks
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      "zbirenbaum/copilot.lua", -- for providers='copilot'
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  },

  {
    'mrcjkb/rustaceanvim',
    version = '^4',
    ft = { 'rust' },
  },

  {
    "mfussenegger/nvim-jdtls",
    ft = "java",
  },

  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
  },
  {
    "kdheepak/lazygit.nvim",
    -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    event = "VeryLazy",
  },
  {
    "mfussenegger/nvim-dap",
  },
  -- {
  --   "rcarriga/nvim-dap-ui",
  --   dependencies = {
  --     "mfussenegger/nvim-dap"
  --   },
  --   config = function ()
  --     require('dapui').setup()
  --   end,
  -- },
  {
    "leoluz/nvim-dap-go",
    config = function ()
      require("dap-go").setup({
        dap_configurations = {
          {
            type = "go",
            name = "Attach remote",
            mode = "remote",
            request = "attach",
          },
        },
      })
    end,
    ft = {"go"},
  },
  {
    "olexsmir/gopher.nvim",
    config = function (_, opts)
      require('gopher').setup(opts)
    end,
    ft = {"go"},
    build = function ()
      vim.cmd [[silent! GoInstallDeps]]
    end
  },
  {
    "j-hui/fidget.nvim",
    config = function ()
      require('fidget').setup()
    end,
  },
  -- {
  --   "pmizio/typescript-tools.nvim",
  --   dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  --   opts = {},
  -- },
  {
    'stevearc/quicker.nvim',
    event = "FileType qf",
    opts = {},
  },
  -- {
  --   "yetone/avante.nvim",
  --   event = "VeryLazy",
  --   lazy = false,
  --   version = false, -- Set this to "*" to always pull the latest release version, or set it to false to update to the latest code changes.
  --   opts = {
  --     provider = "ollama",
  --     vendors = {
  --       ollama = {
  --         __inherited_from = "openai",
  --         api_key_name = "",
  --         endpoint = "https://127.0.0.1:11434",
  --         model = "deepseek-r1",
  --       },
  --     },
  --   },
  --   -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  --   build = "make",
  --   -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
  --   dependencies = {
  --     "stevearc/dressing.nvim",
  --     "nvim-lua/plenary.nvim",
  --     "MunifTanjim/nui.nvim",
  --     --- The below dependencies are optional,
  --     "echasnovski/mini.pick", -- for file_selector provider mini.pick
  --     "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
  --     "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
  --     "ibhagwan/fzf-lua", -- for file_selector provider fzf
  --     "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
  --     "zbirenbaum/copilot.lua", -- for providers='copilot'
  --     {
  --       -- support for image pasting
  --       "HakonHarnes/img-clip.nvim",
  --       event = "VeryLazy",
  --       opts = {
  --         -- recommended settings
  --         default = {
  --           embed_image_as_base64 = false,
  --           prompt_for_file_name = false,
  --           drag_and_drop = {
  --             insert_mode = true,
  --           },
  --           -- required for Windows users
  --           use_absolute_path = true,
  --         },
  --       },
  --     },
  --     {
  --       -- Make sure to set this up properly if you have lazy=true
  --       'MeanderingProgrammer/render-markdown.nvim',
  --       opts = {
  --         file_types = { "markdown", "Avante" },
  --       },
  --       ft = { "markdown", "Avante" },
  --     },
  --   },
  -- }
  --
---@type LazySpec
{
  "mikavilpas/yazi.nvim",
  version = "*", -- use the latest stable version
  event = "VeryLazy",
  dependencies = {
    { "nvim-lua/plenary.nvim", lazy = true },
  },
  keys = {
    -- 👇 in this section, choose your own keymappings!
    {
      "<leader>-",
      mode = { "n", "v" },
      "<cmd>Yazi<cr>",
      desc = "Open yazi at the current file",
    },
    {
      -- Open in the current working directory
      "<leader>cw",
      "<cmd>Yazi cwd<cr>",
      desc = "Open the file manager in nvim's working directory",
    },
    {
      "<c-up>",
      "<cmd>Yazi toggle<cr>",
      desc = "Resume the last yazi session",
    },
  },
  ---@type YaziConfig | {}
  opts = {
    -- if you want to open yazi instead of netrw, see below for more info
    open_for_directories = false,
    keymaps = {
      show_help = "<f1>",
    },
  },
  -- 👇 if you use `open_for_directories=true`, this is recommended
  init = function()
    -- mark netrw as loaded so it's not loaded at all.
    --
    -- More details: https://github.com/mikavilpas/yazi.nvim/issues/802
    vim.g.loaded_netrwPlugin = 1
  end,
}
}
