local present, lspconfig = pcall(require, "lspconfig")

if not present then
  return
end

require("base46").load_highlight "lsp"
require "nvchad_ui.lsp"

local M = {}
local utils = require "core.utils"

-- export on_attach & capabilities for custom lspconfigs

M.on_attach = function(client, bufnr)
  client.server_capabilities.documentFormattingProvider = false
  client.server_capabilities.documentRangeFormattingProvider = false

  utils.load_mappings("lspconfig", { buffer = bufnr })

  if client.server_capabilities.signatureHelpProvider then
    require("nvchad_ui.signature").setup(client)
  end
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
  capabilities = M.capabilities,
}

lspconfig.jsonls.setup {
  on_attach = M.on_attach,
  capabilities = M.capabilities,
  settings = {
    json = {
      validate = {
        enable = true
      }
    }
  }
}

local rt = require("rust-tools")

rt.setup({
  server = {
    on_attach = M.on_attach,
    capabilities = M.capabilities
  },
})


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
