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

vim.opt.undofile = true

vim.opt.undodir = vim.fn.stdpath("data") .. "/undodir"
