local kkts = require'kk.treesitter'

local M = {}

local query = [[
(method_declaration (identifier)? @method.name) @method.declaration
(class_declaration (identifier) @class.name) @class.declaration
]]

M.run_test_in_selection = function()
    local lang = "java"
    local success, parsed_query = pcall(function()
        return vim.treesitter.parse_query(lang, query)
    end)

    if not success then
        print("Unable to parse the query")
        return
    end

    local nodes = kkts.find_nodes(lang, parsed_query)

    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    local intersected_nodes = kkts.intersect_nodes(nodes, row, col)

    local counter = 0
    for _ in pairs(intersected_nodes) do
        counter = counter + 1
    end

    local command = ""

    if counter == 2 then
        local class_node = intersected_nodes[1]
        local method_node = intersected_nodes[2]
        command = 'tmux split-window -h "mvn clean -Dtest=' .. class_node.name .. '#' .. method_node.name .. ' test ; read"'
    else
        local class_node = intersected_nodes[1]
        command = 'tmux split-window -h "mvn clean -Dtest=' .. class_node.name .. ' test ; read"'
    end


    io.popen(command)
    local colour_command = 'tmux select-pane -t:.1 -P "bg=colour234"'
    io.popen(colour_command)
end

return M
