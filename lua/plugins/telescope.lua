return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.8',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  },
  config = function()
    require('telescope').setup {}
    require('telescope').load_extension('fzf')

    local telescope = require('telescope.builtin')
    -- find directory (fd) keymap
    vim.keymap.set("n", "<space>fd", telescope.find_files)
    -- find lsp references (fr) keymap
    vim.keymap.set("n", "<space>fr", telescope.lsp_references)
    -- edit neovin (en) keymap - searches for files in neovim config folderk
    vim.keymap.set("n", "<space>en", function()
      telescope.find_files {
        cwd = vim.fn.stdpath("config")
      }
    end)
  end,
}
