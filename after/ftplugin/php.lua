local dap = require('dap')

dap.adapters.php = {
    type = 'executable',
    command = 'node',
    args = {'/home/bdinh/.local/share/nvim/mason/packages/php-debug-adapter/extension/out/phpDebug.js'}
}

dap.configurations.php = {
    {
        type = 'php',
        request = 'launch',
        name = 'Listen for Xdebug',
        port = 9003
    }
}
