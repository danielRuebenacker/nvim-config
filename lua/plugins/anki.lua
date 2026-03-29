return {
	'rareitems/anki.nvim',
	opts = {
		tex_support = true,
		move_cursor_after_creation = true,
		models = {
			-- Here you specify which notetype should be associated with which deck
			-- NoteType = "NOSE",
			-- ["Basic"] = { "NOSE", "2P" },
			["2P"] = "2P",
			-- ["NoteType"] = "NoteType",
			-- ["Super Basic"] = "Deck::ChildDeck",
		},
	},
}
