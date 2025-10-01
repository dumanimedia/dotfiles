-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt

opt.number = true
opt.termguicolors = true
opt.encoding = "utf-8"
-- opt.cc = "80" -- set an 80 column border for good coding style
opt.clipboard = "unnamedplus" -- using system clipboard
opt.ttyfast = true -- Speed up scrolling in Vim
