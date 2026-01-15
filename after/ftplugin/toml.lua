vim.treesitter.start()
vim.lsp.config['taplo'] = require('cer.lsp.taplo')
vim.lsp.enable('taplo')
