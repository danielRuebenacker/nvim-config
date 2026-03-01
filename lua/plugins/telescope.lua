return {
	{ 
		'nvim-telescope/telescope.nvim', 
		version = '*',

		dependencies = {
			'nvim-lua/plenary.nvim',
			'nvim-tree/nvim-web-devicons',
		},
		
		opts = {
			defaults = {
				color_devicons = true,
				sorting_strategy = "ascending",
				borderchars = { "", "", "", "", "", "", "", "" },
				path_displays = "smart",
				layout_strategy = "horizontal",
				layout_config = {
					height = 100,
					width = 400,
					prompt_position = "top",
					preview_cutoff = 40,
				},
			},
		},
	},
}
