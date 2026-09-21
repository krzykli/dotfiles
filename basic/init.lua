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
vim.opt.shortmess:append("I")

vim.opt.number = true
vim.opt.numberwidth = 2
vim.opt.relativenumber = true

require("plugins")
require("mappings")

vim.cmd([[hi MsgArea guibg=#222222 guifg=#00CC77]])
vim.cmd([[set nowrap]])

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*" },
  command = [[%s/\s\+$//e]],
})

local function open_in_bitbucket()
  local function git(args)
    local command = { "git" }
    vim.list_extend(command, args)
    local result = vim.system(command, { text = true }):wait()
    if result.code ~= 0 then
      return nil
    end
    return vim.trim(result.stdout)
  end

  local prefix = git({ "rev-parse", "--show-prefix" })
  local branch_or_commit = git({ "rev-parse", "--abbrev-ref", "HEAD" })
  local remote_url = git({ "config", "--get", "remote.origin.url" })
  if not prefix or not branch_or_commit or not remote_url then
    vim.notify("The current file is not in a Git repository", vim.log.levels.ERROR)
    return
  end

  if branch_or_commit == "HEAD" then
    branch_or_commit = git({ "rev-parse", "HEAD" })
  end

  local repo_name = remote_url:match("([^/:]+)%.git$") or remote_url:match("([^/:]+)$")
  if not repo_name or not branch_or_commit then
    vim.notify("Unable to determine the Bitbucket repository", vim.log.levels.ERROR)
    return
  end

  local file_path = prefix .. vim.fn.expand("%:t")
  local workspace_name = "atlassian"
  local line_number = vim.fn.line(".")
  local url = "https://bitbucket.org/" .. workspace_name .. "/" .. repo_name .. "/src/" .. branch_or_commit .. "/" .. file_path .. "#lines-" .. line_number
  vim.ui.open(url)
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
