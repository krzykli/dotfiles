vim.keymap.set("n", "<leader>fm", function()
  vim.lsp.buf.format({ async = true })
end, { buffer = true, desc = "format Python buffer" })
