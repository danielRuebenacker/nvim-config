return {
	{
		'MeanderingProgrammer/render-markdown.nvim',
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		opts = {
			enabled = true,
			latex = {
				enabled = true,
			},
			code = {
				enabled = true,
				language_icon = true,
				border = "thin",
				sign = true,
			},
			bullet = {
				enabled = true,
			},
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			}
		},
	},
}
