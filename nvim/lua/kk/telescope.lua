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
        mirror = false,
      },
      vertical = {
        mirror = false,
      },
    },
  }
}
require('telescope').load_extension('fzy_native')

M.search_dotfiles = function()
    require("telescope.builtin").find_files({
        prompt_title = " my config ",
        cwd = "~/.config",
    })
end

M.switch_workplace = function()
    require("telescope.builtin").find_files({
        prompt_title = "Projects",
        cwd="~/workspace",
        find_command={"ls"},
        attach_mappings = function(prompt_bufnr, map)
            function choose_workspace()
                local content = action_state.get_selected_entry(prompt_bufnr)
                local new_path = "~/workspace/" .. content.value

                vim.api.nvim_set_current_dir(new_path)
                vim.api.nvim_notify("Workspace set to " .. new_path, vim.log.levels.INFO, {})
                vim.notify("")
            end
            map('i', '<CR>', function(bufnr)
                choose_workspace()
                actions.close(bufnr)
            end)
            map('i', '<C-c>', function(bufnr)
                actions.close(bufnr)
            end)

            return true
        end
    })
end

return M

