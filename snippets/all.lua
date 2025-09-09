--- @diagnostic disable: undefined-global

return {
	s("(", { t("("), i(1), t(")") }),
	s("[", { t("["), i(1), t("]") }),
	s("{", { t("{"), i(1), t("}") }),
	s("$", { t("$"), i(1), t("$") }),
	s('"', { t('"'), i(1), t('"') }),
	-- Meta snippeting!
	s('luasnip', fmta(
		[[
	--- @diagnostic disable: undefined-global
	
	return {
	<>
	}
	]],
		{ i(1) }
	)),
	-- And another really cool Metasnippet!
	-- You can change the delimiter for [[]] too (!) with equals signs
	s('snip', fmta(
		[=[
	s('<>', fmta( [[ <> ]], {<>})),
	]=],
		{ i(1), i(2), i(3) }
	)),
}
