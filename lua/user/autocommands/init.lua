-- AUTOCOMMANDS

-- Add file type to blade.php
local blade_group = vim.api.nvim_create_augroup("BladeFiltypeRelated", { clear = true })
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "*.blade.php",
  group = blade_group,
  callback = function()
    vim.opt.filetype = "blade"
    vim.opt.syntax = "blade"
  end

})

-- Native exrc support not doable. See my reply:
-- https://github.com/LunarVim/LunarVim/issues/4242#issuecomment-1751919618

lvim.autocommands = {
  {
    "VimEnter",
    {
      nested = true,
      callback = function()
        local filepath = vim.fn.fnamemodify(".lvim.lua", ":p")
        if vim.fn.filereadable(filepath) == 1 then
          vim.cmd("luafile .lvim.lua")
        end
      end
    }
  },
}
