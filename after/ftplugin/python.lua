vim.lsp.config['basedpyright'] = require('lsp.basedpyright')
vim.lsp.config['ruff'] = require('lsp.ruff')
vim.lsp.enable { 'ruff', 'basedpyright' }
