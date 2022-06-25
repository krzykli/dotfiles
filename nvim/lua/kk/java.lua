local kkts = require'kk.treesitter'
local kklib = require'kk.lib'
local parsers = require("nvim-treesitter.parsers")

local M = {}


M.sort_fields = function ()
    local query = [[
    (field_declaration
        (modifiers) @mods
        (variable_declarator (
            (identifier) @id
        )) @dec
    ) @field-declaration
    ]]

    local bufnr = vim.api.nvim_get_current_buf()
    local nodes = kkts.parse(bufnr, query, parsers.get_parser(bufnr))

    local var_name_to_line_map = {}

    local range_min = 100000000000000
    local range_max = 0

    local is_static = false
    local access = "private"

    for _, v in ipairs(nodes) do
        local node = v.node

        if node:type() == "modifiers" then
            local name = vim.treesitter.get_node_text(node, bufnr)

            if string.find(name, "static") then
                is_static = true
            end

            if string.find(name, "public") then
                access = "public"
            elseif string.find(name, "protected") then
                access = "protected"
            elseif string.find(name, "private") then
                access = "private"
            end

        elseif node:type() == "identifier" then
            local name = vim.treesitter.get_node_text(node, bufnr)
            local variable_declarator = node:parent()
            local field_decl = variable_declarator:parent()
            local parent_start_row, _, parent_end_row, _ = field_decl:range()

            range_min = math.min(parent_start_row, range_min)
            range_max = math.max(parent_end_row, range_max)
            local field_declaration = vim.treesitter.get_node_text(field_decl, bufnr)

            var_name_to_line_map[name] = field_declaration
            vim.inspect(name .. " | access: " .. access .. " | is_static: " .. tostring(is_static))

            is_static = false
            access = "private"
        end
    end

    local keyset={}
    local n = 0

    for k, _ in pairs(var_name_to_line_map) do
        n = n + 1
        keyset[n] = k
    end

    local lines = {}
    local first_line = vim.api.nvim_buf_get_lines(bufnr, range_min, range_min + 1, false)
    local indent = string.find(first_line[1], "%S+") - 1

    table.sort(keyset)
    for _, v in ipairs(keyset) do
        table.insert(lines, string.rep(" ", indent) .. var_name_to_line_map[v])
    end
    vim.api.nvim_buf_set_lines(bufnr, range_min, range_max + 1, false, lines)

end


M.run_test_in_selection = function()

    local query = [[
    (method_declaration (identifier)? @method.name) @method.declaration
    (class_declaration (identifier) @class.name) @class.declaration
    ]]

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

M.call_function_from_declaration = function()

    local query = [[
    (method_declaration (identifier)? @method.name) @method.declaration
    ]]

end

return M
