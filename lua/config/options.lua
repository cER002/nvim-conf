-- Neovim Options
local opt = vim.opt
local g = vim.g

-- Leader ----------------------------------------------------------------------
vim.g.mapleader = " "

-- UI --------------------------------------------------------------------------
opt.number = true -- show absolute line numbers
opt.relativenumber = true -- show relative line numbers
opt.cursorline = true -- highlight the current line
opt.ruler = false -- disable the old-school ruler
opt.termguicolors = true -- enable 24-bit colors
opt.guifont = "NotoSansM Nerd Font Mono" -- GUI font
opt.fillchars:append({ eob = " " }) -- hide ~ on empty lines
opt.clipboard = "unnamedplus" -- use system clipboard
opt.splitbelow = true -- horiz splits go below

-- Indentation -----------------------------------------------------------------
opt.smartindent = true -- smart autoindenting on new lines
opt.shiftwidth = 2 -- number of spaces for each indentation
opt.tabstop = 2 -- number of spaces tabs count for
opt.softtabstop = 2 -- spaces per Tab while editing
opt.expandtab = true -- convert tabs to spaces

-- Behavior --------------------------------------------------------------------
opt.wrap = false -- disable line wrapping
opt.scrolloff = 8 -- keep 8 lines visible above/below cursor
opt.sidescrolloff = 8
opt.hlsearch = false -- don’t highlight search results
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.whichwrap:append("<>[]hl") -- line wrap on hjkl and arrow keys
opt.completeopt = "menu,menuone,noselect"
opt.undofile = true -- actually activate persistent undo file
opt.undodir = os.getenv("HOME") .. "/.nvim/undodir"
-- Providers -------------------------------------------------------------------
g.loaded_node_provider = 0
g.loaded_python3_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0
