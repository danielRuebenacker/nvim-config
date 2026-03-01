return {
  'williamboman/mason.nvim',
  'williamboman/mason-lspconfig.nvim',
  'neovim/nvim-lspconfig',
  config = function()
    -- 1. Mason setup
    require('mason').setup()
    require('mason-lspconfig').setup({
      ensure_installed = { "rust_analyzer" },
    })
  end,
}
