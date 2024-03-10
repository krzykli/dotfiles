local M = {}

M.autopairs = function()
  local present1, autopairs = pcall(require, "nvim-autopairs")
  local present2, cmp = pcall(require, "cmp")

  if not (present1 and present2) then
    return
  end

  local options = {
    fast_wrap = {},
    disable_filetype = { "TelescopePrompt", "vim" },
  }

  autopairs.setup(options)

  local cmp_autopairs = require "nvim-autopairs.completion.cmp"
  cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
end

M.blankline = function()
  local present, blankline = pcall(require, "ibl")

  if not present then
    return
  end

  -- require("base46").load_highlight "blankline"

  local options = {
    -- indentLine_enabled = 1,
    -- filetype_exclude = {
    --   "help",
    --   "terminal",
    --   "alpha",
    --   "lspinfo",
    --   "TelescopePrompt",
    --   "TelescopeResults",
    --   "mason",
    --   "",
    -- },
    -- buftype_exclude = { "terminal" },
    -- show_trailing_blankline_indent = false,
    -- show_first_indent_level = false,
    -- show_current_context = false,
    -- show_current_context_start = true,
  }

  blankline.setup(options)
end

M.colorizer = function()
  local present, colorizer = pcall(require, "colorizer")

  if not present then
    return
  end

  local options = {
    filetypes = {
      "*",
    },
    user_default_options = {
      RGB = true, -- #RGB hex codes
      RRGGBB = true, -- #RRGGBB hex codes
      names = false, -- "Name" codes like Blue
      RRGGBBAA = false, -- #RRGGBBAA hex codes
      rgb_fn = false, -- CSS rgb() and rgba() functions
      hsl_fn = false, -- CSS hsl() and hsla() functions
      css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
      css_fn = false, -- Enable all CSS *functions*: rgb_fn, hsl_fn
      mode = "background", -- Set the display mode.
    },
  }

  colorizer.setup(options)
  -- execute colorizer as soon as possible
  vim.defer_fn(function()
    require("colorizer").attach_to_buffer(0)
  end, 0)
end

M.comment = function()
  local present, nvim_comment = pcall(require, "Comment")

  if not present then
    return
  end

  local options = {}
  nvim_comment.setup(options)
end

M.luasnip = function()
  local present, luasnip = pcall(require, "luasnip")

  if not present then
    return
  end

  local options = {
    history = true,
    updateevents = "TextChanged,TextChangedI",
  }

  luasnip.config.set_config(options)
  require("luasnip.loaders.from_vscode").lazy_load { paths = vim.g.luasnippets_path or "" }
  require("luasnip.loaders.from_vscode").lazy_load()

  vim.api.nvim_create_autocmd("InsertLeave", {
    callback = function()
      if
        require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
        and not require("luasnip").session.jump_active
      then
        require("luasnip").unlink_current()
      end
    end,
  })
end

M.gitsigns = function()
  local present, gitsigns = pcall(require, "gitsigns")

  if not present then
    return
  end

  local options = {
    signs = {
      add = { text = "▐"},
      change = {  text = "▐"},
      delete = {  text = ""},
      topdelete = {  text = "‾"},
      changedelete = {  text = "~"},
    },
  }

  gitsigns.setup(options)
end

M.devicons = function()
  local present, devicons = pcall(require, "nvim-web-devicons")

  if present then
    devicons.setup()
  end
end

M.yanky = function()
  return {
    highlight = {
      on_put = true,
      on_yank = true,
      timer = 50,
    }
  }
end

return M