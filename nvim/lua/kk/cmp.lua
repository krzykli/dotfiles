local cmp = require'cmp';

local lspkind = require "lspkind"
lspkind.init()

cmp.setup {
     snippet = {
      expand = function(args)
        require('luasnip').lsp_expand(args.body)
      end,
    },

    mapping = {
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.close(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
    },

    sources = {
        { name = "nvim_lsp" },
        { name = "nvim_lua" },
        { name = "nvim_luasnip" },
        { name = "path" },
        { name = "buffer", keyword_length = 5 },
    };

    documentation = {
        border = { '┌', '─', '┐', '│', '┘', '─', '└', '│' },
    };

    formatting = {
      format = lspkind.cmp_format {
        with_text = true,
        menu = {
          buffer = "[buf]",
          nvim_lsp = "[LSP]",
          nvim_lua = "[api]",
          path = "[path]",
          luasnip = "[snip]",
        },
      },
    },

    experimental = {
      native_menu = false,
    },
}
