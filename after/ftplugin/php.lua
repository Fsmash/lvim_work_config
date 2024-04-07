-- Debugging
local dap = require('dap')

dap.adapters.php = {
  type = 'executable',
  command = 'node',
  args = { '/home/bdinh/.local/share/nvim/mason/packages/php-debug-adapter/extension/out/phpDebug.js' }
}

dap.configurations.php = {
  {
    type = 'php',
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
