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
formatters.setup { { name = "blade_formatter" }, }

local dap = require('dap')
dap.adapters.blade = {
  type = 'executable',
  command = 'node',
  args = { '/home/bdinh/.local/share/nvim/mason/packages/php-debug-adapter/extension/out/phpDebug.js' }
}

dap.configurations.blade = {
  {
    type = 'blade',
    request = 'launch',
    name = 'Listen for Xdebug',
    port = function()
      local port = 9003
      while vim.fn.system('lsof -i :' .. port) ~= '' do
        port = port + 1
      end
      return port
    end
  }
}

-- Comment toggle for Blade TODO: not working
-- local ft = require("Comment.ft")
-- ft.blade = '{{--%s--}}'
