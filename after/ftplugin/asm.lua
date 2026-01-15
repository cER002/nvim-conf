vim.treesitter.start()
vim.lsp.config['asm_lsp'] = require('cer.lsp.asm_lsp')
vim.lsp.enable('asm_lsp')
