-- Extend blade filetype for html and js snippets
require("luasnip").filetype_extend("blade", { "html", "javascript" })

-- Blade syntax highlighting
local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.blade = {
  install_info = {
    url = "https://github.com/EmranMR/tree-sitter-blade",
    files = { "src/parser.c" },
    branch = "main",
  },
  filetype = "blade",
}

-- Blade Formatter
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup({
  {
    command = "blade-formatter",
    args = { "--write", "$FILENAME" },
    filetypes = { "blade" }
  }
})

-- Comment toggle for Blade TODO: not working
-- local ft = require("Comment.ft")
-- ft.blade = '{{--%s--}}'
