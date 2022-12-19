require("plugins")
require("impatient")
require("settings")
require("keys")
require("lsp")
require("bufferline").setup({})
require'hop'.setup { keys = 'asdfghjkl' }

require("kk.rust")
require("kk.luasnip")
require("kk.cmp")
require("kk.toggleterm")
require("kk.telescope")
require("kk.feline")
require("kk.gitsigns")
require("kk.notify")
require("kk.dap")
require("kk.dapui")
require("mason").setup()


require("trouble").setup {
}

require("yanky").setup({
  highlight = {
    on_put = true,
    on_yank = true,
    timer = 100,
  },
})
vim.api.nvim_set_hl(0, "YankyYanked", {link = "ErrorFloat"})

vim.keymap.set({"n","x"}, "p", "<Plug>(YankyPutAfter)")
vim.keymap.set({"n","x"}, "P", "<Plug>(YankyPutBefore)")
vim.keymap.set({"n","x"}, "gp", "<Plug>(YankyGPutAfter)")
vim.keymap.set({"n","x"}, "gP", "<Plug>(YankyGPutBefore)")
vim.keymap.set("n", "<c-n>", "<Plug>(YankyCycleForward)")
vim.keymap.set("n", "<c-p>", "<Plug>(YankyCycleBackward)")

require("zen-mode").setup({
  window = {
    backdrop = 0.95, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
    -- height and width can be:
    -- * an absolute number of cells when > 1
    -- * a percentage of the width / height of the editor when <= 1
    -- * a function that returns the width or the height
    width = 160, -- width of the Zen window
  },
})


require("nvim-treesitter.configs").setup({
  highlight = {
    enable = true,
  },
  playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- Whether the query persists across vim sessions
    keybindings = {
      toggle_query_editor = 'o',
      toggle_hl_groups = 'i',
      toggle_injected_languages = 't',
      toggle_anonymous_nodes = 'a',
      toggle_language_display = 'I',
      focus_language = 'f',
      unfocus_language = 'F',
      update = 'R',
      goto_node = '<cr>',
      show_help = '?',
    },
  },
  query_linter = {
    enable = true,
    use_virtual_text = true,
    lint_events = {"BufWrite", "CursorHold"},
  },
})

vim.api.nvim_set_hl(0, "VirtualTextError", {link = "ErrorFloat"})

function _G.ReloadConfig()
  print("reload")
  for name, _ in pairs(package.loaded) do
    if name:match("^cnull") then
      package.loaded[name] = nil
    end
  end

  package.loaded["kk.java"] = nil
  package.loaded["kk.treesitter"] = nil
  package.loaded["kk.telescope"] = nil
  package.loaded["kk.misc"] = nil

  dofile(vim.env.MYVIMRC)
end

vim.api.nvim_set_keymap("n", "<Leader>re", "<Cmd>lua ReloadConfig()<CR>", { silent = true, noremap = true })
vim.cmd("command! ReloadConfig lua ReloadConfig()")

vim.cmd[[au BufRead,BufNewFile *.wgsl	set filetype=wgsl]]

------------
local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.papoy = {
  install_info = {
    url = "/Users/kklimczyk/workspace/tree-sitter-papoy", -- local path or git repo
    files = {"src/parser.c"},
    generate_requires_npm = false, -- if stand-alone parser without npm dependencies
    requires_generate_from_grammar = true, -- if folder contains pre-generated src/parser.c
  },
  filetype='pap'
}
local ft_to_parser = require "nvim-treesitter.parsers".filetype_to_parsername
ft_to_parser.pap = "papoy"
------------

