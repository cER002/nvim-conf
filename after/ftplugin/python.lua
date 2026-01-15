vim.treesitter.start()
vim.lsp.config['basedpyright'] = require('cer.lsp.basedpyright')
vim.lsp.config['ruff'] = require('cer.lsp.ruff')
vim.lsp.enable { 'ruff', 'basedpyright' }
