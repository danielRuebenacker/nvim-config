--- @diagnostic disable: undefined-global

return {
	s('key', fmta(
		[[ 
	vim.keymap.set({ "<>" }, "<>")
	]], {i(1, "mode"), i(2, "lhs")})),
}
