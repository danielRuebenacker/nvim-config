return {
	-- 'rareitems/anki.nvim',
	dir = "~/projects/anki/anki.nvim",
	name = "anki.nvim",
	dev = true,
	opts = {
		tex_support = false,
		move_cursor_after_creation = true,
		models = {
			-- Here you specify which notetype should be associated with which deck
			["BasicADS"] = "ADS",
			["MDCloze"] = "ADS",
			["BasicOOSE"] = "OOSE",
			["Basic2D"] = "2D"
			-- ["Super Basic"] = "Deck::ChildDeck",
		},
	},
}
