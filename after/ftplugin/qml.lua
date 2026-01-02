vim.treesitter.start()
vim.lsp.config['qmlls'] = require('lsp.qmlls')
vim.lsp.enable('qmlls')
