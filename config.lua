-- EDITOR
lvim.colorscheme = "gruvbox-material"
lvim.log.level = "warn"
lvim.format_on_save.enabled = true
lvim.builtin.alpha.mode = "startify"
lvim.builtin.alpha.startify.section.header.val = ""
lvim.builtin.telescope.theme = "ivy"
lvim.builtin.nvimtree.setup.filters.dotfiles = true
lvim.builtin.bufferline.options.numbers = "ordinal"
lvim.builtin.nvimtree.setup.filters.dotfiles = false

vim.opt.numberwidth = 1
vim.opt.timeoutlen = 400
vim.opt.colorcolumn = "80"
vim.opt.scrolloff = 0
vim.opt.showmode = true
vim.opt.wrap = true
vim.opt.linebreak = true

-- USER CONFIGS
require("user.plugins")
require("user.laravel")
require("user.keybinds")
require("user.whichkey")
require("user.autocommands")

-- Fix for deprecated nvim-tree config
require('ts_context_commentstring').setup {}
vim.g.skip_ts_context_commentstring_module = true

-- WSL CLIPBOARD
vim.cmd([[
    let g:clipboard = {
    \   'name': 'WslClipboard',
    \   'copy': {
    \      '+': 'clip.exe',
    \      '*': 'clip.exe',
    \    },
    \   'paste': {
    \      '+': 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
    \      '*': 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
    \   },
    \   'cache_enabled': 0,
    \ }
]])
