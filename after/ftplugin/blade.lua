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

-- No longer works :(
-- -- Blade LSP
-- local lspconfig = require("lspconfig")
-- local configs = require("lspconfig.configs")

-- -- -- Configure it
-- configs.blade = {
--   default_config = {
--     cmd = { "/home/bdinh/.local/bin/laravel-dev-tools/builds/laravel-dev-tools", "lsp" },
--     filetypes = { 'blade' },
--     root_dir = function(fname)
--       return lspconfig.util.find_git_ancestor(fname)
--     end,
--     settings = {},
--   },
-- }

-- -- Set it up
-- lspconfig.blade.setup({
--   on_attach = require("lvim.lsp").common_on_attach,
--   on_init = require("lvim.lsp").common_on_init,
--   on_exit = require("lvim.lsp").common_on_exit,
--   capabilities = require("lvim.lsp").common_capabilities(),
-- })

-- Extend blade filetype for html and js snippets
require("luasnip").filetype_extend("blade", { "html", "javascript" })

-- Comment toggle for Blade
local ft = require("Comment.ft")
ft.blade = '{{--%s--}}'
