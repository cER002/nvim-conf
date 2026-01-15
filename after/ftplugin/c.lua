vim.treesitter.start()
vim.lsp.config['clangd'] = require('cer.lsp.clangd')
vim.lsp.enable('clangd')
