local utils = require("core.utils")
local M = {}

local present, telescope = pcall(require, "telescope")

if not present then
  return
end

vim.g.theme_switcher_loaded = true

require("base46").load_highlight "telescope"
local colors = require("base46").get_theme_tb "base_30"

local hl_overs = {
  TelescopeBorder = {
    fg = colors.black2,
    bg = colors.black2,
  },

  TelescopeResultsTitle = {
    fg = colors.black2,
    bg = colors.black2,
  },

  TelescopeNormal = { bg = colors.black2 },

  TelescopeSelection = { bg = colors.red, fg = colors.white },
}

utils.set_highlights(hl_overs)

local options = {
  defaults = {
    vimgrep_arguments = {
      "rg",
      "-L",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
    },
    prompt_prefix = "   ",
    selection_caret = "  ",
    entry_prefix = "  ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "ascending",
    layout_strategy = "horizontal",
    layout_config = {
      horizontal = {
        prompt_position = "top",
        preview_width = 0.55,
        results_width = 0.8,
      },
      vertical = {
        mirror = false,
      },
      width = 0.87,
      height = 0.80,
      preview_cutoff = 120,
    },
    file_sorter = require("telescope.sorters").get_fuzzy_file,
    file_ignore_patterns = { "node_modules" },
    generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
    path_display = { "truncate" },
    winblend = 0,
    border = true,
    -- borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    color_devicons = true,
    set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
    file_previewer = require("telescope.previewers").vim_buffer_cat.new,
    grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
    qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
    -- Developer configurations: Not meant for general override
    buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
    mappings = {
      n = { ["q"] = require("telescope.actions").close },
    },
  },

  extensions_list = { "themes", "terms", "ui-select" },
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown { }
    },
    project = {
      base_dirs = {
        "~/workspace/",
      }
    }
  }
}


-- check for any override
options = require("core.utils").load_override(options, "nvim-telescope/telescope.nvim")

telescope.setup(options)

-- load extensions
pcall(function()
  for _, ext in ipairs(options.extensions_list) do
    telescope.load_extension(ext)
  end
end)

-- custom
M.search_dotfiles = function()
  require("telescope.builtin").find_files({
    hidden = true,
    prompt_title = " My Config ",
    cwd = "~/.config",
  })
end

return M
