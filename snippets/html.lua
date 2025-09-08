--- @diagnostic disable: undefined-global


return {
	-- This one is so cool!
	s({ trig = "t" }, fmt(
		[[
	<{}>{}</{}>
	]],
		{ i(1), i(2), rep(1) }
	)),

}
