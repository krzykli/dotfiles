-- n, v, i, t = mode names

local function termcodes(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local load_mappings = function(mode, map)
  for keybind, mapping_info in pairs(map) do
    vim.keymap.set(mode, keybind, mapping_info[1])
  end
end

local insert_maps = {
  ["jk"] = {"<ESC>", "exit insert mode"},
}
load_mappings("i", insert_maps)

local normal_maps = {
    ["<leader>:"] = { "q:i", "cmd" },
    ["QQ"] = { ":q<CR>", "quit" },
    ["<leader>gg"] = { "<cmd>LazyGit<CR>", "lazygit" },
    -- switch between windows
    ["<leader>a"] = { "ggVG", "copy whole file" },
    ["<leader>b"] = { "<cmd> enew <CR>", "new buffer" },
    ["<leader>o"] = { "<cmd> Lspsaga outline<CR>", "outline"},

    ["<leader>w"] = { function ()
      vim.api.nvim_command("write")
    end,
    "save current file"
    },

    ["<leader>la"] = { '<cmd>lua require("core.utils").open_lua_buf()<CR>', "opens a lua buffer in a horizontal split"},
    ["<leader>lr"] = { '<cmd>lua require("core.utils").exec_lua_buf()<CR>', "executes lua buffer"},
    ["<leader>jq"] = { '<cmd>%!jq .<CR><cmd>set syntax=json<CR>', "formats file with jq"},
    ["q]"] = {'<cmd>cnext<CR>', "next quicklist item"},
    ["q["] = {'<cmd>cprevious<CR>', "previous quicklist item"},

    -- telescope
    ["<leader>ff"] = { "<cmd> Telescope find_files <CR>", "find files" },
    ["<leader>fs"] = { "<cmd> lua require'telescope'.extensions.project.project{}<CR>", "projects" },
    ["<leader>fa"] = { "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>", "find all" },
    ["<leader>fc"] = { "<cmd> Telescope commands <CR>", "all commands" },
    ["<leader>fw"] = { "<cmd> Telescope live_grep <CR>", "live grep" },
    ["<leader>fb"] = { "<cmd> Telescope buffers <CR>", "find buffers" },
    ["<leader>fh"] = { "<cmd> Telescope help_tags <CR>", "help page" },
    ["<leader>fo"] = { "<cmd> Telescope oldfiles <CR>", "find oldfiles" },
    ["<leader>tk"] = { "<cmd> Telescope keymaps <CR>", "show keys" },
    -- dotfiles
    ["<leader>vc"] = {function ()
      require('configs.telescope').search_dotfiles()
    end, "open dotfiles" },
    -- git
    ["<leader>cm"] = { "<cmd> Telescope git_commits <CR>", "git commits" },
    ["<leader>gt"] = { "<cmd> Telescope git_status <CR>", "git status" },

    -- pick a hidden term
    ["<leader>pt"] = { "<cmd> Telescope terms <CR>", "pick hidden term" },

    -- lsp
    ["gD"] = {
      function()
        vim.lsp.buf.declaration()
      end,
      "lsp declaration",
    },

    ["gd"] = {
      function()
        vim.lsp.buf.definition()
      end,
      "lsp definition",
    },

    ["K"] = {
      function()
        vim.lsp.buf.hover()
      end,
      "lsp hover",
    },

    ["gi"] = {
      function()
        vim.lsp.buf.implementation()
      end,
      "lsp implementation",
    },

    ["<leader>ls"] = {
      function()
        vim.lsp.buf.signature_help()
      end,
      "lsp signature_help",
    },

    ["<leader>D"] = {
      function()
        vim.lsp.buf.type_definition()
      end,
      "lsp definition type",
    },

    ["<leader>ra"] = {
      function()
        vim.lsp.buf.rename()
      end,
      "lsp rename",
    },

    ["<leader>ca"] = {
      function()
        vim.lsp.buf.code_action()
      end,
      "lsp code_action",
    },

    ["gr"] = {
      function()
        vim.lsp.buf.references()
      end,
      "lsp references",
    },

    ["<leader>f"] = {
      function()
        vim.diagnostic.open_float()
      end,
      "floating diagnostic",
    },

    ["[d"] = {
      function()
        vim.diagnostic.goto_prev()
      end,
      "goto prev",
    },

    ["d]"] = {
      function()
        vim.diagnostic.goto_next()
      end,
      "goto_next",
    },

    ["<leader>q"] = {
      function()
        vim.diagnostic.setloclist()
      end,
      "diagnostic setloclist",
    },

    ["<leader>fm"] = {
      function()
        vim.lsp.buf.format { async = true }
      end,
      "lsp formatting",
    },

    ["<leader>wa"] = {
      function()
        vim.lsp.buf.add_workspace_folder()
      end,
      "add workspace folder",
    },

    ["<leader>wr"] = {
      function()
        vim.lsp.buf.remove_workspace_folder()
      end,
      "remove workspace folder",
    },

    ["<leader>wl"] = {
      function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end,
      "list workspace folders",
    },
}
load_mappings("n", normal_maps)


local terminal_maps = {

  ["<C-x>"] = { termcodes "<C-\\><C-N>", "escape terminal mode" },
}
load_mappings("t", terminal_maps)

local x_maps = {
  ["p"] = { 'p:let @+=@0<CR>:let @"=@0<CR>', opts = { silent = true } },
}

load_mappings("x", x_maps)
