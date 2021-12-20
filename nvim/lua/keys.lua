local kh = require('kk.key-helpers')
local Job = require "plenary.job"


function RunCommand(command)
    local stderr = {}
    local stdout, _ = Job
    :new({
        command = command,
        on_stderr = function(_, data)
            table.insert(stderr, data)
        end,
    })
    :sync()
    if next(stderr) then
        require "notify"(stderr, "error", {title="Builder"})
    else
        require "notify"(stdout, "info", {title="Builder"})
    end
end

-- general
vim.g.mapleader = ';'

kh.normal_map('Q', '<nop>')
kh.insert_map('jk', '<ESC>')
kh.visual_map('fd', '<ESC>')
kh.normal_map('<leader>h', ':set hlsearch!<CR>')
kh.normal_map('<leader>w', ':w<CR>')
kh.normal_map('<leader>re', ':source ~/.config/nvim/init.lua<CR>')

kh.normal_map('<leader>t', ':NvimTreeToggle<CR>')
kh.visual_map('<C-c>', '"*y')
kh.normal_map('Y', 'y$')
kh.normal_map('<leader>a', 'ggVG')
kh.normal_map('<leader>s', ':echo "renaming..."<CR>:%s/')

--
kh.normal_map('<leader>bb', ':w<CR>:!./build.sh<CR>')
kh.normal_map('<leader>b', ':lua RunCommand("./compile.sh")<CR>')
kh.normal_map('<leader>br', ':w<CR>:!./compile.sh && ./run.sh<CR><CR>')
kh.normal_map('<leader>r', ':w<CR>:!./run.sh<CR><CR>')

-- center search
kh.normal_map('n', 'nzz')
kh.normal_map('N', 'Nzz')

-- undo break points
kh.insert_map(',', ',<C-g>u')
kh.insert_map('.', '.<C-g>u')
kh.insert_map('!', '!<C-g>u')
kh.insert_map('?', '?<C-g>u')

-- move text
kh.visual_map('J', ":m '>+1<CR>gv=gv")
kh.visual_map('K', ":m '<-2<CR>gv=gv")
kh.insert_map('<C-j>', "<ESC>:m +1<CR>==")
kh.insert_map('<C-k>', "<ESC>:m -2<CR>==")
kh.normal_map('<leader>k', ":m .-2<CR>==")
kh.normal_map('<leader>j', ":m .+1<CR>==")

-- quickfix
kh.normal_map('[', ':cprevious<CR>')
kh.normal_map(']', ':cnext<CR>')
kh.normal_map('=++', ':cclose<CR>')

-- windows
kh.normal_map('<C-k>', ':wincmd k<CR>')
kh.normal_map('<C-j>', ':wincmd j<CR>')
kh.normal_map('<C-h>', ':wincmd h<CR>')
kh.normal_map('<C-l>', ':wincmd l<CR>')

-- kh.normal_map('<C-m>', ':vertical resize -5<CR>')
-- kh.normal_map('<C-n>', ':vertical resize +5<CR>')

-- tabs
kh.normal_map('tn', ':tabnew<CR>')
kh.normal_map('tj', ':tabprevious<CR>')
kh.normal_map('tk', ':tabnext<CR>')

-- termianl
kh.terminal_map('<ESC>', '<C-\\><C-n>')

-- buffers
-- kh.normal_map('tn', ':enew<CR>')
-- kh.normal_map('tj', ':bprevious<CR>')
-- kh.normal_map('tk', ':bnext<CR>')

kh.normal_map('<Leader>fo', ":lua vim.lsp.buf.formatting()<CR>")
-- telescope
kh.normal_map('<Leader>fa', ":lua require('telescope.builtin').find_files()<CR>")
kh.normal_map('<Leader>fg', ":lua require('telescope.builtin').git_files()<CR>")
kh.normal_map('<Leader>fe', ":lua require('telescope.builtin').lsp_document_symbols()<CR>")
kh.normal_map('<Leader>fr', ":lua require('telescope.builtin').lsp_references()<CR>")
kh.normal_map('<Leader>fl', ":lua require('telescope.builtin').live_grep()<CR>")
kh.normal_map('<Leader>fb', ":lua require('telescope.builtin').buffers()<CR>")
kh.normal_map('<Leader>fs', ":lua require('telescope').extensions.project.project{}<CR>")

kh.normal_map('<Leader>vc', ":lua require('kk.telescope').search_dotfiles()<CR>")
kh.normal_map('<Leader>vx', ":lua require('kk.telescope').open_bookmarks()<CR>")
kh.normal_map('test', ":lua require('kk.java').run_test_in_selection()<CR>")

-- gitsigns
kh.normal_map('<Leader>gb', ":Gitsigns toggle_current_line_blame<CR>")

-- bufferline
kh.normal_map('<Leader>gt', ":BufferLinePick<CR>")

-- lf
kh.normal_map('<Leader>lf', ":tabnew<CR>:set nonumber<CR>:set norelativenumber<CR>:term<CR>alf<CR>")
