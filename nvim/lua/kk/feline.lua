local lsp = require('feline.providers.lsp')
local vi_mode_utils = require('feline.providers.vi_mode')

local components = {
  active = {{}, {}, {}},
  inactive = {{}, {}, {}},
}

local theme = {
  bg = '#282828',
  black = '#282828',
  yellow = '#d8a657',
  cyan = '#89b482',
  oceanblue = '#45707a',
  green = '#a9b665',
  orange = '#e78a4e',
  violet = '#d3869b',
  magenta = '#c14a4a',
  white = '#a89984',
  fg = '#a89984',
  skyblue = '#7daea3',
  red = '#ea6962',
}

local vi_mode_theme = {
  NORMAL = 'green',
  OP = 'green',
  INSERT = 'red',
  VISUAL = 'skyblue',
  LINES = 'skyblue',
  BLOCK = 'skyblue',
  REPLACE = 'violet',
  ['V-REPLACE'] = 'violet',
  ENTER = 'cyan',
  MORE = 'cyan',
  SELECT = 'orange',
  COMMAND = 'green',
  SHELL = 'green',
  TERM = 'green',
  NONE = 'yellow'
}

local vi_mode_text = {
  NORMAL = 'N',
  OP = '<|',
  INSERT = 'I',
  VISUAL = '<>',
  LINES = '<>',
  BLOCK = '<>',
  REPLACE = '<>',
  ['V-REPLACE'] = '<>',
  ENTER = '<>',
  MORE = '<>',
  SELECT = '<>',
  COMMAND = 'COMMAND',
  SHELL = 'SHELL',
  TERM = 'TERM',
  NONE = 'NONE'
}

-- LEFT

-- vi-mode
components.active[1] = {
    {
        hl = function()
            local val = {}

            val.bg = vi_mode_utils.get_mode_color()
            val.fg = 'black'
            val.style = 'bold'

            return val
        end,
        right_sep = ' '
    },
    {
        provider = function()
            return vi_mode_text[vi_mode_utils.get_vim_mode()]
        end,
        hl = function()
            local val = {}
            val.fg = vi_mode_utils.get_mode_color()
            val.bg = 'bg'
            val.style = 'bold'
            return val
        end,
        right_sep = '  '
    },
    {
      provider = function()
        local cwd = vim.fn['getcwd']()
        local tokens = {}

        for match in cwd:gmatch("[a-zA-Z-]+") do
            table.insert(tokens, match)
        end

        return tokens[#tokens]
      end,
      hl = {
        fg = 'red',
        bg = 'bg',
        style = 'bold'
      },
      right_sep = ' '
    },
    {
        -- gitBranch
        provider = 'git_branch',
        hl = {
            fg = 'yellow',
            bg = 'bg',
            style = 'bold'
        },
        right_sep = '  '
    },
    {
      provider = function()
        local dir = vim.fn['getcwd']()
        if string.find(dir, '/review/') then
            return ' REVIEW '
        else
            return ''
        end
      end,
      hl = {
        fg = 'black',
        bg = 'magenta',
        style = 'bold'
      },
      right_sep = ''
    },
    {
        -- filename
        provider = function()
            return vim.fn.expand("%:F")
        end,
        hl = {
            fg = 'white',
            bg = 'bg',
            style = 'bold'
        },
        right_sep = ' '
    },
    {
    -- lineInfo
      provider = 'position',
      hl = {
        fg = 'white',
        bg = 'bg',
        style = 'bold'
      },
      right_sep = ' '
    },
}

-- LSP
components.active[2] = {
    {
        provider = 'lsp_client_names',
        hl = {
            fg = 'yellow',
            bg = 'bg',
            style = 'bold'
        },
        right_sep = ' '
    },
    {
        provider = 'diagnostic_errors',
        enabled = function() return lsp.diagnostics_exist('Error') end,
        hl = {
            fg = 'red',
            style = 'bold'
        }
    },
    {
        -- diagnosticWarn
        provider = 'diagnostic_warnings',
        enabled = function() return lsp.diagnostics_exist('Warn') end,
        hl = {
            fg = 'yellow',
            style = 'bold'
        }
    },
    {
        -- diagnosticHint
        provider = 'diagnostic_hints',
        enabled = function() return lsp.diagnostics_exist('Hint') end,
        hl = {
            fg = 'cyan',
            style = 'bold'
        }
    },
    {
        -- diagnosticInfo
        provider = 'diagnostic_info',
        enabled = function() return lsp.diagnostics_exist('Info') end,
        hl = {
            fg = 'skyblue',
            style = 'bold'
        }
    }
}

-- LANG + FILES
components.active[3] = {
    {
      provider = function()
        local filename = vim.fn.expand('%:t')
        local extension = vim.fn.expand('%:e')
        local icon  = require'nvim-web-devicons'.get_icon(filename, extension)
        if icon == nil then
          icon = ''
        end
        return icon
      end,
      hl = function()
        local val = {}
        local filename = vim.fn.expand('%:t')
        local extension = vim.fn.expand('%:e')
        local icon, name  = require'nvim-web-devicons'.get_icon(filename, extension)
        if icon ~= nil then
          val.fg = vim.fn.synIDattr(vim.fn.hlID(name), 'fg')
        else
          val.fg = 'white'
        end
        val.bg = 'bg'
        val.style = 'bold'
        return val
      end,
      right_sep = ' '
    },
    {
    -- fileType
      provider = 'file_type',
      hl = function()
        local val = {}
        local filename = vim.fn.expand('%:t')
        local extension = vim.fn.expand('%:e')
        local icon, name  = require'nvim-web-devicons'.get_icon(filename, extension)
        if icon ~= nil then
          val.fg = vim.fn.synIDattr(vim.fn.hlID(name), 'fg')
        else
          val.fg = 'white'
        end
        val.bg = 'bg'
        val.style = 'bold'
        return val
      end,
      right_sep = ' '
    },
    {
    -- fileSize
      provider = 'file_size',
      enabled = function() return vim.fn.getfsize(vim.fn.expand('%:t')) > 0 end,
      hl = {
        fg = 'skyblue',
        bg = 'bg',
        style = 'bold'
      },
      right_sep = ' '
    },
    {
    -- fileEncode,
      provider = 'file_encoding',
      hl = {
        fg = 'white',
        bg = 'bg',
        style = 'bold'
      },
      right_sep = ' '
    },
    {
    -- linePercent
      provider = 'line_percentage',
      hl = {
        fg = 'white',
        bg = 'bg',
        style = 'bold'
      },
      right_sep = ' '
    },
    {
    -- scrollBar
      provider = 'scroll_bar',
      hl = {
        fg = 'yellow',
        bg = 'bg',
      },
    },
}

require('feline').setup({
  theme = theme,
  vi_mode_theme = vi_mode_theme,
  components = components,
})

