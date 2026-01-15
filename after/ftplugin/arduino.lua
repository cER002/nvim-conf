vim.treesitter.start()
vim.lsp.config['arduino_language_server'] = require('cer.lsp.arduino_language_server')
vim.lsp.enable('arduino_language_server')
