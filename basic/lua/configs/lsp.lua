local capabilities = vim.lsp.protocol.make_client_capabilities()
local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if has_cmp then
  capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
end

local servers = {
  lua_ls = {
    settings = {
      Lua = {
        completion = { callSnippet = "Replace" },
        diagnostics = { globals = { "vim" } },
        workspace = {
          library = vim.api.nvim_get_runtime_file("lua", true),
          checkThirdParty = false,
        },
      },
    },
  },
  yamlls = {},
  pyright = {},
  ruff = {
    on_attach = function(client)
      -- Let Pyright provide hover information while Ruff handles linting.
      client.server_capabilities.hoverProvider = false
    end,
  },
  ts_ls = {},
  gopls = {
    settings = {
      gopls = {
        analyses = { unusedparams = true },
        completeUnimported = true,
        usePlaceholders = true,
      },
    },
  },
  jsonls = {
    settings = {
      json = { validate = { enable = true } },
    },
  },
}

for name, config in pairs(servers) do
  config.capabilities = capabilities
  vim.lsp.config(name, config)
end

vim.lsp.enable(vim.tbl_keys(servers))

return {
  capabilities = capabilities,
}
