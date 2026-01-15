vim.treesitter.start()
vim.lsp.config['cssls'] = require('cer.lsp.cssls')
vim.lsp.enable('cssls')
