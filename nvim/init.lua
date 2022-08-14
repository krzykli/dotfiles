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

require("nvim-treesitter.configs").setup({
  highlight = {
    enable = true,
  },
})

vim.highlight.link("VirtualTextError", "Red", true)

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
