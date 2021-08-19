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

local conf = require("telescope.config").values
local finders = require "telescope.finders"
local pickers = require "telescope.pickers"
local previewers = require "telescope.previewers"

M.open_bookmarks = function()
    local bookmarks_file = '/Users/kklimczyk/.config/bookmarks'

    local bookmarks = {}
    for line in io.lines(bookmarks_file) do
        local label, link = line:match("([^,]+),%s+([^,]+)")
        bookmarks[#bookmarks + 1] = {
            label = label,
            link = link
        }
    end
    pickers.new({
        prompt_title = "Bookmarks",
        finder = finders.new_table {
            results = bookmarks,
            entry_maker = function(entry)
                return {
                    ordinal = entry.label,
                    display = entry.label,
                    link = entry.link
                }
            end,
        },
        previewer = previewers.cat.new({}),
        sorter = conf.generic_sorter({}),
        attach_mappings = function(prompt_bufnr)
            actions.select_default:replace(function()
                local entry = action_state.get_selected_entry()
                vim.inspect(entry)
                actions.close(prompt_bufnr)
                print(entry.link)
                local url = 'open ' .. entry.link
                os.execute(url)
            end)

            return true
        end,
    }):find()
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

