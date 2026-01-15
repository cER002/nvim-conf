vim.treesitter.start()
vim.lsp.config['qmlls'] = require('cer.lsp.qmlls')
vim.lsp.enable('qmlls')
