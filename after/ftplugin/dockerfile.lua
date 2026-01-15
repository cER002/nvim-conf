vim.treesitter.start()
vim.lsp.config['docker_language_server'] = require('cer.lsp.docker_language_server')
vim.lsp.enable('docker_language_server')
