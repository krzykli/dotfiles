local kh = require('kk.key-helpers')
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')

local M = {}

require('telescope').setup{
  defaults = {
    entry_prefix = "  ",
    initial_mode = "insert",
    prompt_prefix = " 🔍 ",
    selection_caret = "> ",
    selection_strategy = "reset",
    sorting_strategy = "descending",
    borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
    layout_strategy = "flex",
    layout_config = {
      horizontal = {
        width = 0.9,
        mirror = false,
      },
      vertical = {
        width = 0.9,
        mirror = false,
      },
    },
  },
  extensions = {
    project = {
      base_dirs = {
        '~/workspace/',
      }
    }
  }
}
require('telescope').load_extension('fzy_native')

M.search_dotfiles = function()
    require("telescope.builtin").find_files({
        prompt_title = " my config ",
        cwd = "~/.config",
    })
end


local workspace_root = '~/workspace/'
local project_config = '/Users/kklimczyk/.config/current_projects'

local current_projects = {}
for line in io.lines(project_config) do 
    current_projects[#current_projects + 1] = line
end

local access_key = {'j', 'k', 'i'}
for i, project in ipairs(current_projects) do
    kh.normal_map('<Leader>f' .. access_key[i], ":lua require('telescope.builtin').find_files({prompt_title='" .. project .. "', cwd='" .. workspace_root .. project .. "'})<CR>")
end

return M

