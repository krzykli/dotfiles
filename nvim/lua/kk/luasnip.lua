local ls = require("luasnip")
-- some shorthands...
local snip = ls.snippet
local node = ls.snippet_node
local text = ls.text_node
local insert = ls.insert_node
local func = ls.function_node
local choice = ls.choice_node
local dynamicn = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt


local date = function() return {os.date('%Y-%m-%d')} end
vim.api.nvim_set_keymap("i", "<C-e>", "<Plug>luasnip-next-choice", {})
vim.api.nvim_set_keymap("s", "<C-e>", "<Plug>luasnip-next-choice", {})

ls.snippets = {
    all = {
        snip("fmt1",
        fmt("To {title} {} {}.", {
            insert(2, "Name"),
            insert(3, "Surname"),
            title = choice(1, { text("Mr."), text("Ms.") }),
        })
        )
    }
}
