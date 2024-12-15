-- Custom key maps
-- Source/execute current lua file:
vim.keymap.set("n", "<space><space>x", "<cmd>source %<CR>")

-- Nvim configuration options
-- Show current command:
vim.opt.showcmd = true

-- Inform nvim that a nerd font is installed
vim.g.have_nerd_font = true

-- Show relative line numbers
vim.opt.number = true

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
