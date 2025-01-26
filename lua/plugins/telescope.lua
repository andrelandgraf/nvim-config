-- Note: To hide node_modules (without preventing lsp results),
-- install fd and ripgrep because both will not show gitignored files by default
return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.8',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  },
  config = function()
    require('telescope').setup {
      layout_strategy = 'flex',
      extensions = {
        fzf = {}
      }
    }
    require('telescope').load_extension('fzf')

    local telescope = require('telescope.builtin')
    -- find directory (fd) keymap
    vim.keymap.set("n", "<space>fd", telescope.find_files)
    -- find lsp references (fr) keymap
    vim.keymap.set("n", "<space>fr", telescope.lsp_references)
    -- fuzzy-find help content (fh)
    vim.keymap.set("n", "<space>fh", telescope.help_tags)
    -- edit neovin (en) keymap - searches for files in neovim config folderk
    vim.keymap.set("n", "<space>en", function()
      telescope.find_files {
        cwd = vim.fn.stdpath("config")
      }
    end)
  end,
}
