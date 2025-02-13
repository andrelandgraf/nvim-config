-- LSP: Language Server Protocol
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
    lspconfig.lua_ls.setup {}
    -- typescript-language-server installed via nvm/npm
    lspconfig.ts_ls.setup {}
    -- gopls installed via go install: https://github.com/golang/tools/tree/master/gopls
    lspconfig.gopls.setup {}

    -- Enable format on save (:w)
    vim.api.nvim_create_autocmd('LspAttach', {
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if not client then return end

        vim.keymap.set("n", "<space>dl", vim.diagnostic.open_float);

        if client.supports_method('textDocument/formatting') then
          -- Format current buffer on save
          vim.api.nvim_create_autocmd('BufWritePre', {
            buffer = args.buf,
            callback = function()
              vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
            end,
          })
        end
      end,
    })
  end,
}
