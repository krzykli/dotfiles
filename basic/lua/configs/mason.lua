local present, mason = pcall(require, "mason")

if not present then
  return
end

vim.api.nvim_create_augroup("_mason", { clear = true })

local options = {
  PATH = "prepend",

  ui = {
    icons = {
      package_pending = " ",
      package_installed = " ",
      package_uninstalled = " ﮊ",
    },

    keymaps = {
      toggle_server_expand = "<CR>",
      install_server = "i",
      update_server = "u",
      check_server_version = "c",
      update_all_servers = "U",
      check_outdated_servers = "C",
      uninstall_server = "X",
      cancel_installation = "<C-c>",
    },
  },

  max_concurrent_installers = 4,
}

local ensure_installed = {
  "delve",
  "gopls",
  "jdtls",
  "json-lsp",
  "lua-language-server",
  "pyright",
  "ruff",
  "typescript-language-server",
  "yaml-language-server",
}

vim.api.nvim_create_user_command("MasonInstallAll", function()
  vim.cmd("MasonInstall " .. table.concat(ensure_installed, " "))
end, {})

mason.setup(options)
