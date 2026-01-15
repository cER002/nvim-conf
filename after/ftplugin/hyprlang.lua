vim.treesitter.start()
vim.lsp.config['hyprls'] = require('cer.lsp.hyprls')
vim.lsp.enable('hyprls')
