vim.g.mapleader = ";"

vim.opt.clipboard = "unnamedplus"

vim.opt.timeoutlen = 200
vim.opt.signcolumn = "yes"
vim.opt.laststatus = 3 -- global statusline
vim.opt.pumheight = 20
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.smartindent = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shortmess = "I"

vim.opt.number = true
vim.opt.numberwidth = 2
vim.opt.relativenumber = true

require("plugins")
require("mappings")

vim.cmd([[hi MsgArea guibg=#222222 guifg=#00CC77]])
vim.cmd([[set nowrap]])

vim.cmd('augroup PythonBlack')
vim.cmd('autocmd!')
vim.cmd('autocmd FileType python nnoremap <buffer> <leader>fm :!poetry run black %<CR><CR>')
vim.cmd('augroup END')

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*" },
  command = [[%s/\s\+$//e]],
})

local function open_in_bitbucket()
  -- Get the relative path of the current file in the repository
  local file_path = vim.fn.system("git rev-parse --show-prefix") .. vim.fn.expand("%")
  file_path = file_path:gsub("\n", "")
  -- Get the current branch name or commit hash
  local branch_or_commit = vim.fn.system("git rev-parse --abbrev-ref HEAD")
  branch_or_commit = branch_or_commit:gsub("\n", "")
  -- If we're not on a branch (detached HEAD), get the current commit hash
  if branch_or_commit == "HEAD" then
    branch_or_commit = vim.fn.system("git rev-parse HEAD"):gsub("\n", "")
  end
  -- Get the repository name from the remote URL
  local remote_url = vim.fn.system("git config --get remote.origin.url")
  remote_url = remote_url:gsub("\n", "")
  -- Extract the repository name from the URL
  local repo_name = remote_url:match("([^/]+)%.git$")
  -- Set your workspace name
  local workspace_name = "atlassian"
  -- Get the current line number
  local line_number = vim.fn.line('.')
  -- Construct the Bitbucket URL with the line number
  local url = "https://bitbucket.org/" .. workspace_name .. "/" .. repo_name .. "/src/" .. branch_or_commit .. "/" .. file_path .. "#lines-" .. line_number
  -- Execute the open command (use 'open' for macOS, adjust for other OS as needed)
  os.execute("open '" .. url .. "'")
end

vim.open_in_bitbucket = open_in_bitbucket

local function generate_uuid()
  -- Call the system's uuidgen command
  local result = vim.fn.system("uuidgen")
  -- Trim any trailing newline
  local uuid = vim.fn.trim(result)
  uuid = string.lower(uuid)
  -- Return the UUID
  return uuid
end
-- Define a command in Neovim to insert the UUID at the current cursor position
vim.api.nvim_create_user_command('InsertUUID', function()
  local uuid = generate_uuid()
  vim.api.nvim_put({uuid}, 'c', true, true)
end, {})
