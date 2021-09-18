local M = {}

M.normal_map = function(keys, map)
    vim.api.nvim_set_keymap('n', keys, map, {noremap = true, silent = true})
end

M.insert_map = function(keys, map)
    vim.api.nvim_set_keymap('i', keys, map, {noremap = true, silent = true})
end

M.visual_map = function(keys, map)
    vim.api.nvim_set_keymap('v', keys, map, {noremap = true, silent = true})
end

M.terminal_map = function(keys, map)
    vim.api.nvim_set_keymap('t', keys, map, {noremap = true, silent = true})
end

return M
