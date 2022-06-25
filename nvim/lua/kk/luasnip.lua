local ls = require("luasnip")
local types = require "luasnip.util.types"


ls.config.set_config {
  -- This tells LuaSnip to remember to keep around the last snippet.
  -- You can jump back into it even if you move outside of the selection
  history = true,

  -- This one is cool cause if you have dynamic snippets, it updates as you type!
  updateevents = "TextChanged,TextChangedI",

  -- Autosnippets:
  enable_autosnippets = true,

  -- Crazy highlights!!
  -- #vid3
  -- ext_opts = nil,
  ext_opts = {
    [types.choiceNode] = {
      active = {
        virt_text = { { " <- Current Choice", "NonTest" } },
      },
    },
  },
}

local s = ls.snippet
local n = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node

local fmt = require("luasnip.extras.fmt").fmt


vim.api.nvim_set_keymap("i", "<C-e>", "<Plug>luasnip-next-choice", {})
vim.api.nvim_set_keymap("s", "<C-e>", "<Plug>luasnip-next-choice", {})

local same = function (index)
    return f(function (arg)
        return arg
    end, {index})
end

local quote_each = function (index)
    return f(function (arg)
        local args = vim.split(arg[1][1], ",", true)
        local result = {}
        for _, value in pairs(args) do
            value = string.gsub(value, "%s+", "")
            table.insert(result, "\"" .. value .. "\"")
        end
        return table.concat(result, ",")
    end, {index})
end


ls.snippets = {
    python = {
        s(
            "ktest",
            fmt([[

            @pytest.mark.usefixtures({})
            def test_{}({}):
                {}

            ]], {quote_each(2), i(1), i(2), i(3)})
        )
    },
    all = {
        s(
            "tost",
            fmt(
                "my first var {}, my second var {}",
                {f(function (words)
                    local parts = vim.split(words[1][1], ".", true)
                    return parts[#parts] or ""
                end, {1}), i(1)}
            )
        ),
        s("fmt1",
        fmt("To {title} {} {}.", {
            i(2, "Name"),
            i(3, "Surname"),
            title = c(1, { t("Mr."), t("Ms.") }),
        })
        ),
        s("curtime", f(function ()
            return os.date "%D - %H:%M"
        end))
    }

}
