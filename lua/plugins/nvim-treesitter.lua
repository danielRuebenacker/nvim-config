return {
	{
		'nvim-treesitter/nvim-treesitter',
		lazy = false,
		build = ':TSUpdate',
		opts = {
  			install_dir = vim.fn.stdpath('data') .. '/site',
		},
	},
}
