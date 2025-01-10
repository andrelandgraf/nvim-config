-- Custom key maps
-- Source/execute current lua file:
vim.keymap.set("n", "<space><space>x", "<cmd>source %<CR>")
vim.keymap.set("n", "<space>x", ":.lua<CR>")
vim.keymap.set("v", "<space>x", ":lua<CR>")

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Nvim configuration options
-- Show current command:
vim.opt.showcmd = true

-- Inform nvim that a nerd font is installed
vim.g.have_nerd_font = true

-- Show relative line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Identation
vim.opt.shiftwidth = 2

-- Set the 'scrolloff' option to a large value to effectively keep crusor in center of screen when scrolling around
vim.o.scrolloff = 999

-- Enable mouse support
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Load lazy.vim (https://lazy.folke.io/installation)
require("config.lazy")

-- Load local plugins
require("local_plugins/inflight").setup()
