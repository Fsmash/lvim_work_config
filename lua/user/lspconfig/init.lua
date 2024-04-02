-- Laravel Blade LSP
local configs = require("lspconfig.configs")

configs.blade = {
  default_config = {
    name = "blade",
    cmd = { "/home/bdinh/.local/bin/laravel-dev-tools/builds/laravel-dev-tools", "lsp" },
    -- cmd = { "/home/bdinh/.local/bin/laravel-dev-tools/laravel-dev-tools", "lsp" },
    filetypes = { 'blade' },
    root_dir = function(pattern)
      local util = require("lspconfig.util")
      local cwd = vim.loop.cwd()
      local root = util.root_pattern("composer.json", ".git", ".phpactor.json", ".phpactor.yml")(pattern)
      return util.path.is_descendant(cwd, root) and cwd or root -- prefer cwd if root is a descendant
    end,
    settings = {},
  },
}

local lsp_zero = require("lsp-zero")
require("lspconfig").blade.setup({
  on_attach = require("lvim.lsp").common_on_attach,
  on_init = require("lvim.lsp").common_on_init,
  on_exit = require("lvim.lsp").common_on_exit,
  capabilities = lsp_zero.get_capabilities(),
  -- capabilities = require("lvim.lsp").common_capabilities(),
})

lsp_zero.default_setup("blade")
