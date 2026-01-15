vim.treesitter.start()
vim.lsp.config['bashls'] = require('cer.lsp.bashls')
vim.lsp.enable('bashls')
