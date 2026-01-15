vim.treesitter.start()
vim.lsp.config['jsonls'] = require('cer.lsp.jsonls')
vim.lsp.enable('jsonls')
