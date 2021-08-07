local M = {}

M.get_visual_selection = function()
    local _, start_row, start_col, _ = unpack(vim.fn.getpos("'<"))
    local _, end_row, _, _ = unpack(vim.fn.getpos("'>"))
    local end_col = vim.fn.col("'>")
    local current_buffer = vim.api.nvim_get_current_buf()
    local lines = vim.api.nvim_buf_get_lines(current_buffer, start_row - 1, end_row, true)
    local first_line = lines[1]
    local selection = string.sub(first_line, start_col, end_col)
    return selection
end

M.search_selection_in_google = function()
    local phrase = M.get_visual_selection()
    local escaped_phrase = phrase:gsub(' ', '%%20')
    local url = 'open https://www.google.com/search?q=' .. escaped_phrase
    os.execute(url)
    print("Opened " .. url)
end

return M
