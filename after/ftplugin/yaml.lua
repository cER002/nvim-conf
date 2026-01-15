vim.treesitter.start()
vim.lsp.config['yamlls'] = require('cer.lsp.yamlls')
vim.lsp.enable('yamlls')
