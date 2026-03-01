return {
	{ 
		'rareitems/anki.nvim',
		opts = {
			tex_support = true,
			move_cursor_after_creation = true,
			models = {
				-- Here you specify which notetype should be associated with which deck
				-- NoteType = "NOSE",
				-- ["Basic"] = { "NOSE", "2P" },
				["Basic2P"] = "2P",
				["BasicNOSE"] = "NOSE",
				-- ["NoteType"] = "NoteType",
				-- ["Super Basic"] = "Deck::ChildDeck",
			},
		},
	},
}
