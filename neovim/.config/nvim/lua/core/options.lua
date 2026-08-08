vim.g.mapleader = " "

local opt = vim.opt

opt.number = true
opt.relativenumber = true

opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true

opt.wrap = false
opt.termguicolors = true

opt.clipboard = "unnamedplus"
opt.scrolloff = 8
opt.sidescrolloff = 8

opt.undofile = true

opt.undodir = vim.fn.stdpath("data") .. "/undodir"

-- Python Indentation Fix
vim.g.python_indent = {
  open_paren = "shiftwidth()",
  nested_paran = "shiftwidth()",
  continue = "shiftwidth()",
  closed_paren_align_last_line = false,
}
