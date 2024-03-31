-- KEYBINDS
lvim.leader = "space"
lvim.keys.insert_mode["jk"] = "<Esc>"

-- cd into current buffer's directory
lvim.keys.normal_mode["<leader>'"] = "<cmd>cd %:h<cr>"

-- Move lines up and down
lvim.keys.normal_mode["<c-d>"] = "<c-d>zz"
lvim.keys.normal_mode["<c-u>"] = "<c-u>zz"
lvim.keys.normal_mode["n"] = "nzzzv"
lvim.keys.normal_mode["N"] = "Nzzzv"

-- Buffer navigation
lvim.keys.normal_mode["<leader>nn"] = "<cmd>bnext<cr>"

-- Delete without yanking
lvim.keys.normal_mode["<leader>d"] = "\"_d"
lvim.keys.visual_mode["<leader>d"] = "\"_d"
lvim.keys.visual_mode["<leader>p"] = "\"_dP"

-- Write and quit
lvim.keys.normal_mode["<leader>w"] = "<cmd>w!<cr>"
lvim.keys.normal_mode["<leader>W"] = "<cmd>wq!<cr>"
lvim.keys.normal_mode["<leader>q"] = "<cmd>confirm q<cr>"
lvim.keys.normal_mode["<leader>Q"] = "<cmd>confirm qa<cr>"

-- Frequent commands
lvim.keys.normal_mode["<leader>z"] = "<cmd>lua print(vim.fn.expand('%'))<cr>"
lvim.keys.normal_mode["<leader>N"] = "<cmd>silent! lua require('bufferline').move_to(-1)<cr>"
lvim.keys.normal_mode["<leader>;"] = "<cmd>Alpha<cr>"
lvim.keys.normal_mode["<leader>h"] = "<cmd>nohlsearch<cr>"
lvim.keys.normal_mode["<leader>c"] = "<cmd>BufferKill<cr>"
lvim.keys.normal_mode["<leader>o"] = "<cmd>only<cr>"
lvim.keys.normal_mode["<leader>/"] = "<plug>(comment_toggle_linewise_current)"
lvim.keys.visual_mode["<leader>/"] = "<plug>(comment_toggle_linewise_visual)"

-- Debugging commands
lvim.keys.normal_mode["<leader>t"] = "<cmd>lua require'dap'.toggle_breakpoint()<cr>"
lvim.keys.normal_mode["<F2>"] = "<cmd>lua require'dap'.run_to_cursor()<cr>"
lvim.keys.normal_mode["<F3>"] = "<cmd>lua require'dap'.pause()<cr>"
lvim.keys.normal_mode["<F4>"] = "<cmd>lua require'dap'.continue()<cr>"
lvim.keys.normal_mode["<F5>"] = "<cmd>lua require'dap'.step_over()<cr>"
lvim.keys.normal_mode["<F6>"] = "<cmd>lua require'dap'.step_back()<cr>"
lvim.keys.normal_mode["<F7>"] = "<cmd>lua require'dap'.step_into()<cr>"
lvim.keys.normal_mode["<F8>"] = "<cmd>lua require'dap'.step_out()<cr>"
lvim.keys.normal_mode["<F9>"] = "<cmd>lua require'dapui'.toggle({reset = true})<cr>"
lvim.keys.normal_mode["<F10>"] = "<cmd>lua require'dap'.repl.toggle()<cr>"
lvim.keys.normal_mode["<F12>"] = function()
  require("dap").close()
  require("dapui").close()
  require("dap").disconnect()
end

-- NvimTree
lvim.keys.normal_mode["<leader>e"] = function()
  vim.cmd("NvimTreeToggle")
end

lvim.keys.normal_mode["<leader>E"] = function()
  vim.cmd("NvimTreeOpen")
  local width = require("nvim-tree.view").View.width
  if width == 30 then
    vim.cmd("NvimTreeResize 1000")
  else
    vim.cmd("NvimTreeResize 30")
  end
end

-- Harpoon
local harpoon = require("harpoon")
harpoon:setup({
  settings = { save_on_toggle = true, sync_on_ui_close = true, },
})
lvim.keys.normal_mode["<leader>-"] = function() harpoon.ui:toggle_quick_menu(harpoon:list()) end
lvim.keys.normal_mode["<leader>a"] = function() harpoon:list():append() end

-- Bufferline navigation
lvim.keys.normal_mode["<leader>0"] = "<cmd>silent! lua require('bufferline').go_to(-1, true)<cr>"

for i = 1, 9 do
  lvim.keys.normal_mode["<leader>" .. i] = "<cmd>silent! lua require('bufferline').go_to(" .. i .. ", true)<cr>"
end

-- Here for reference
-- vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end)
-- vim.keymap.set("n", "<C-t>", function() harpoon:list():select(2) end)
-- vim.keymap.set("n", "<C-n>", function() harpoon:list():select(3) end)
-- vim.keymap.set("n", "<C-s>", function() harpoon:list():select(4) end)
-- vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
-- vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end)

-- Telescope
lvim.keys.normal_mode["<leader>H"] = "<cmd>Telescope search_history<cr>"
-- Restrict find_files to just the current buffer directory if no git repo
lvim.keys.normal_mode["<leader>f"] = function()
  local utils = require("telescope.utils")
  require("lvim.core.telescope.custom-finders").find_project_files {
    previewer = false,
    cwd = utils.buffer_dir(),
    path_display = { "absolute" },
    wrap_results = true,
  }
end

-- TERMINAL KEYBINDS
function _G.set_terminal_keymaps()
  local opts = { buffer = 0 }
  vim.keymap.set('t', 'JK', [[<c-\><c-n>]], opts)
  vim.keymap.set('t', '<c-l>', [[<cmd>TermExec cmd=';clear'<cr>]], opts)
  vim.keymap.set('i', '<c-l>', [[<cmd>TermExec cmd=';clear'<cr>]], opts)
  vim.keymap.set('n', '<c-l>', [[<cmd>TermExec cmd=';clear'<cr>]], opts)
  vim.keymap.set('v', '<c-l>', [[<cmd>TermExec cmd=';clear'<cr>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

-- Lua testing
-- enew|put=execute('lua <args>')
