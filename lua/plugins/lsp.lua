-- Find all configuration options via :help lspconfig-all
return {
  "neovim/nvim-lspconfig",
  dependencies = {
    {
     "folke/lazydev.nvim",
     ft = "lua", -- only load on lua files
     opts = {
       library = {
         -- See the configuration section for more details
         -- Load luvit types when the `vim.uv` word is found
         { path = "${3rd}/luv/library", words = { "vim%.uv" } },
       },
     },
   },
  },
  config = function()
    local lspconfig = require('lspconfig')
    -- lua-language-server installed via brew
    lspconfig.lua_ls.setup{}
    -- typescript-language-server installed via nvm/npm 
    lspconfig.ts_ls.setup{}
    -- gopls installed via go install: https://github.com/golang/tools/tree/master/gopls
    lspconfig.gopls.setup{}
  end,
}
