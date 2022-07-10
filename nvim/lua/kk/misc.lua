local kklib = require'kk.lib'

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

M.funky = function ()

    local row_start, _, row_end, _ = kklib.get_visual_selection_range()
    local lines = vim.api.nvim_buf_get_lines(0, row_start, row_end + 1, false)

    local current_row = row_start - 1
    for i = 1, #lines, 1 do
        local line = lines[i]
        current_row = current_row + 1
        local new_line = line:gsub("%S", "O")
        vim.api.nvim_buf_set_lines(0, current_row, current_row + 1, false, {new_line})
    end

end

M.choochoo = function ()
    local row_start, _, row_end, _ = kklib.get_visual_selection_range()
    local lines = vim.api.nvim_buf_get_lines(0, row_start, row_end + 1, false)

    local line_nb_to_length = {}
    local current_line_offset = {}

    local line_idx = 1
    for i = row_start, row_end, 1 do
        line_nb_to_length[i] = #lines[line_idx]
        line_idx = line_idx + 1
        current_line_offset[i] = 0
    end

    local non_empty = 0
    for _, value in ipairs(lines) do
        if value ~= "" then
            non_empty = non_empty + 1
        end
    end

    local curr_line_nb = row_start
    local lines_done = {}
    while true do
        for j, line in ipairs(lines) do
            if kklib.has_value(lines_done, curr_line_nb) then
                curr_line_nb = curr_line_nb + 1
                goto loop_end
            end

            local first_char = string.sub(line, 1, 1)
            local new_line = string.sub(line, 2, #line) .. first_char
            current_line_offset[curr_line_nb] = current_line_offset[curr_line_nb] + 1
            vim.api.nvim_buf_set_lines(0, curr_line_nb, curr_line_nb + 1, false, {new_line})
            line = new_line
            lines[j] = new_line

            if current_line_offset[curr_line_nb] == line_nb_to_length[curr_line_nb] then
                table.insert(lines_done, curr_line_nb)
            end

            curr_line_nb = curr_line_nb + 1

            ::loop_end::
        end

        curr_line_nb = row_start
        os.execute("sleep " .. tonumber(0.01))
        vim.cmd("redraw")

        if #lines_done == non_empty then
            break
        end
    end
    -- end
end


local function locals()
  local variables = {}
  local idx = 1
  while true do
    local ln, lv = debug.getlocal(2, idx)
    if ln ~= nil then
      variables[ln] = lv
    else
      break
    end
    idx = 1 + idx
  end
  return variables
end

M.showme = function (winid)
    local line = vim.api.nvim_get_current_line()
    if line == "choochoo" then
        M.choochoo()
    end

    vim.api.nvim_win_close(winid, true)
end

M.uitest = function ()
  local bufnr = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "q", ":q!<CR>", {noremap=true, silent=true})
  vim.api.nvim_buf_set_lines(bufnr, 0, 1000, false, {
      "create a new variable",
      "choochoo",
      "perhaps",
      "will be",
      "useful"
  })
  local popup = require "plenary.popup"

  local current_window = vim.api.nvim_get_current_win()
  local window_width = vim.api.nvim_win_get_width(current_window)
  local minwidth = 40
  local win, opts = popup.create(bufnr,
    {minwidth=minwidth,
    minheight=20,
    borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
    cursorline=true,
    border=true,
    title="KK TOOLBOX",
    })

  popup.move(win, {relative="editor", row=20, col=window_width - minwidth})
  vim.api.nvim_win_set_option(win, 'winhl', 'Normal:blue')
  -- vim.api.nvim_win_set_config(win, {relative="editor", row=20, col=window_width - 10})
  vim.api.nvim_win_set_option(win, "winblend", 10);
  vim.api.nvim_buf_set_keymap(
        bufnr,
        "n",
        "<CR>",
        "<Cmd>lua require('kk.misc').showme(" .. win ..")<CR>",
        {}
    )
  -- a.nvim_win_set_option(win, "wrap", not nowrap)
  -- local border_win = opts and opts.border and opts.border.win_id
  -- if border_win then
  --     a.nvim_win_set_option(border_win, "winblend", self.window.winblend)
  -- end
  -- return win, opts, border_win
end

return M

