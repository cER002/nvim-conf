require('cer.config.options')
require('cer.core.lazy')
require('cer.config.autocmds')
require('cer.config.keymaps')
--require('config.highlights')
vim.cmd.colorscheme('tokyonight')
vim.cmd([[ 
  highlight StatusLine none
  highlight StatusLineNC none  
]])
