--[[
Code borrowed from
https://github.com/polarmutex/contextprint.nvim
]]

local ts_utils = require("nvim-treesitter.ts_utils")
local ts_query = require("nvim-treesitter.query")
local parsers = require("nvim-treesitter.parsers")
local locals = require("nvim-treesitter.locals")

local M = {}

local intersects = function(row, col, sRow, sCol, eRow, eCol)
  if sRow > row or eRow < row then
    return false
  end

  if sRow == row and sCol > col then
    return false
  end

  if eRow == row and eCol < col then
    return false
  end

  return true
end

M.intersect_nodes = function(nodes, row, col)
  local found = {}
  for idx = 1, #nodes do
    local node = nodes[idx]
    local sRow = node.dim.s.r
    local sCol = node.dim.s.c
    local eRow = node.dim.e.r
    local eCol = node.dim.e.c

    if intersects(row, col, sRow, sCol, eRow, eCol) then
      table.insert(found, node)
    end
  end
  return found
end

function M.parse(bufnr, query, lang_tree)
  lang_tree = lang_tree or parsers.get_parser(bufnr)

  local success, parsed_query = pcall(function()
    return vim.treesitter.parse_query(lang_tree:lang(), query)
  end)

  if not success then
    return {}
  end

  local results = {}

  for _, tree in ipairs(lang_tree:trees()) do
    local root = tree:root()
    local start_row, _, end_row, _ = root:range()

    for match in ts_query.iter_prepared_matches(parsed_query, root, bufnr, start_row, end_row) do
      locals.recurse_local_nodes(match, function(_, node, path)
        table.insert(results, { node = node, tag = path })
      end)
    end
  end

  return results
end

M.find_nodes = function(lang, parsed_query)
  local bufnr = vim.api.nvim_get_current_buf()
  local parser = parsers.get_parser(bufnr, lang)
  local root = parser:parse()[1]:root()
  local start_row, _, end_row, _ = root:range()

  local results = {}
  for match in ts_query.iter_prepared_matches(parsed_query, root, bufnr, start_row, end_row) do
    local sRow, sCol, eRow, eCol
    local declaration_node
    local type = "no_type"
    local name = nil

    locals.recurse_local_nodes(match, function(_, node, path)
      local idx = string.find(path, ".", 1, true)
      local op = string.sub(path, idx + 1, #path)

      type = string.sub(path, 1, idx - 1)
      if op == "name" then
        name = ts_utils.get_node_text(node)[1]
      elseif op == "declaration" then
        declaration_node = node
        sRow, sCol, eRow, eCol = node:range()
        sRow = sRow + 1
        eRow = eRow + 1
        sCol = sCol + 1
        eCol = eCol + 1
      end
    end)

    if declaration_node ~= nil then
      table.insert(results, {
        declaring_node = declaration_node,
        dim = {
          s = { r = sRow, c = sCol },
          e = { r = eRow, c = eCol },
        },
        name = name,
        type = type,
      })
    end
  end
  return results
end

return M
