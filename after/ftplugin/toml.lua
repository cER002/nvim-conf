vim.treesitter.start()
vim.lsp.config['taplo'] = require('lsp.taplo')
vim.lsp.enable('taplo')
