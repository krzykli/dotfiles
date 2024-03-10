local present, lspconfig = pcall(require, "lspconfig")

if not present then
  return
end

local M = {}

-- export on_attach & capabilities for custom lspconfigs

M.on_attach = function(client, bufnr)
  client.server_capabilities.documentFormattingProvider = false
  client.server_capabilities.documentRangeFormattingProvider = false
end

M.on_java_attach = function (client, bufnr)
  M.on_attach(client, bufnr)

  vim.keymap.set("n", "<leader>df", function ()
    return require("jdtls").test_class()
  end, {buffer=true})

  vim.keymap.set("n", "<leader>dn", function ()
    return require("jdtls").test_nearest_method()
  end, {buffer=true})

  require('jdtls').setup_dap({ hotcodereplace = 'auto' })
  require('jdtls.setup').add_commands()
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()

M.capabilities.textDocument.completion.completionItem = {
  documentationFormat = { "markdown", "plaintext" },
  snippetSupport = true,
  preselectSupport = true,
  insertReplaceSupport = true,
  labelDetailsSupport = true,
  deprecatedSupport = true,
  commitCharactersSupport = true,
  tagSupport = { valueSet = { 1 } },
  resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  },
}

lspconfig.lua_ls.setup {
  on_attach = M.on_attach,
  capabilities = M.capabilities,

  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      completion = {
        callSnippet = "Replace"
      },
      workspace = {
        library = {
          [vim.fn.expand "$VIMRUNTIME/lua"] = true,
          [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
        },
        maxPreload = 100000,
        preloadFileSize = 10000,
      },
    },
  },
}

lspconfig.tsserver.setup {
  on_attach = M.on_attach,
  capabilities = M.capabilities,
}

lspconfig.pyright.setup {
  on_attach = M.on_attach,
  capabilities = M.capabilities
}

lspconfig.ruff_lsp.setup {
  on_attach = M.on_attach,
}

lspconfig.gopls.setup {
  on_attach = M.on_attach,
  capabilities = M.capabilities,
  cmd = {"gopls"},
  filetypes = {"go", "gomod", "gowork", "gotmpl"},
  settings = {
    gopls = {
      completeUnimported = true,
      usePlaceholders = true,
      analyses = {
        unusedparams = true,
      }
    },
  }
}

require'dap'.adapters.go = function(callback, config)
  -- Wait for delve to start
    vim.defer_fn(function()
        callback({type = "server", host = "127.0.0.1", port = "port"})
      end,
    100)
end

require'dap'.configurations.go = {
    {
      type = "go",
      name = "Debug",
      request = "launch",
      program = "${file}",
    },
    {
      type = 'dlv',
      name = 'Launch file via dlv instance running on 38697',
      request = 'launch',
      program = "${file}";
    }
}

require('dap-go').setup {
  -- Additional dap configurations can be added.
  -- dap_configurations accepts a list of tables where each entry
  -- represents a dap configuration. For more details do:
  -- :help dap-configuration
  dap_configurations = {
    {
      -- Must be "go" or it will be ignored by the plugin
      type = "go",
      name = "Attach remote",
      mode = "remote",
      request = "attach",
    },
  },
  -- delve configurations
  delve = {
    -- the path to the executable dlv which will be used for debugging.
    -- by default, this is the "dlv" executable on your PATH.
    path = "dlv",
    -- time to wait for delve to initialize the debug session.
    -- default to 20 seconds
    initialize_timeout_sec = 20,
    -- a string that defines the port to start delve debugger.
    -- default to string "${port}" which instructs nvim-dap
    -- to start the process in a random available port
    port = "${port}",
    -- additional args to pass to dlv
    args = {},
    -- the build flags that are passed to delve.
    -- defaults to empty string, but can be used to provide flags
    -- such as "-tags=unit" to make sure the test suite is
    -- compiled during debugging, for example.
    -- passing build flags using args is ineffective, as those are
    -- ignored by delve in dap mode.
    build_flags = "",
  },
}

lspconfig.jsonls.setup {
  on_attach = M.on_attach,
  capabilities = M.capabilities,
  settings = {
    json = {
      validate = {
        enable = true
      },
      schemas = {
        fileMatch = { "schema.json" },
        url = "file:///Users/kklimczyk/workspace/yaml-rego-generator/schema.json"
      }
    }
  }
}

vim.g.rustaceanvim = {
  tools = {
  },
  server = {
    on_attach = M.on_attach,
    default_settings = {
      ['rust-analyzer'] = {
      },
    },
  },
  dap = {
  },
}

HOME = vim.fn.expand("$HOME")
JAVA_ROOT = HOME .. "/java_lsp"
local bundles = {
  vim.fn.glob(JAVA_ROOT .. "/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar")
};
vim.list_extend(bundles, vim.split(vim.fn.glob(JAVA_ROOT .. "/vscode-java-test/server/*.jar"), "\n"))

M.java_config = {
-- lspconfig.jdtls.setup({
  --
  settings = {
    java = {
      eclipse = {
        downloadSources = true,
      },
      configuration = {
        updateBuildConfiguration = "interactive",
      },
      maven = {
        downloadSources = true,
      },
      implementationsCodeLens = {
        enabled = true,
      },
      referencesCodeLens = {
        enabled = true,
      },
      references = {
        includeDecompiledSources = true,
      },
      format = {
        enabled = true,
        settings = {
          url = vim.fn.stdpath "config" .. "/lang-servers/intellij-java-google-style.xml",
          profile = "GoogleStyle",
        },
      },
    },
  },

  cmd = {
    HOME .. "/.sdkman/candidates/java/17.0.6-tem/bin/java",
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-javaagent:" .. JAVA_ROOT .. "/lombok.jar",
    "-Xms1g",
    "-Xmx2G",
    "-jar", JAVA_ROOT .. "/jdt-language-server/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar",
    "-configuration", JAVA_ROOT .. "/jdt-language-server/config_mac",
    "-data", JAVA_ROOT .. "/data/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t"),
    "--add-modules=ALL-SYSTEM",
    "--add-opens java.base/java.util=ALL-UNNAMED",
    "--add-opens java.base/java.lang=ALL-UNNAMED",
  },
  on_attach = M.on_java_attach,

  init_options = {
    bundles = bundles
  },
  capabilities = M.capabilities,
  flags = {
    debounce_text_changes = 150,
  },
}

return M
