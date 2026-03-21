return {
  {
    'williamboman/mason.nvim',
    config = function()
      require('mason').setup()
    end,
  },
  {
    'williamboman/mason-lspconfig.nvim',
    config = function()
      require('mason-lspconfig').setup({
        ensure_installed = { "rust_analyzer" },
      })
    end,
  },
	 {
	   'neovim/nvim-lspconfig',
	   -- optional LSP config here
	vim.lsp.config("clangd", {
		  cmd = { "clangd", "--compile-commands-dir=." }
	}),
	},
}
