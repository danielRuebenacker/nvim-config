---@diagnostic disable: undefined-global

-- function in_math_mode()
-- 	local tree = vim.treesitter.get_parser():parse()[1]
-- 	local query = vim.treesitter.query.parse("lua", [[(math)]])
-- 	local cursor = vim.treesitter.get_node()
-- 	for id, node, meta in query:iter_captures(tree:root(), 0) do
-- 		if node == cursor then
-- 			print("yes")
-- 		end
-- 	end
-- 	if node then
-- 		print(node:parent():type())
-- 	end
-- end
--
local function word_follows()
	local curs = vim.fn.expand("<cword>")
	return { curs }
end
local function word_follows_cond()
	local col = vim.fn.col('.')
	local line = vim.fn.getline('.')
	local after = line:sub(col)
	return after:match("^%w") ~= nil -- true if a word follows
end



return {
	-- math modes
	s({ trig = "mt", snippetType = "autosnippet" },
		fmta("$<>$ ", { i(1) })
	),
	s({ trig = "(%d+)", regTrig = true },
		fmta([[
#for i in range(<>) {
	<>
}]], {
			f(function(_, s) return s.captures[1] end),
			i(1)
		})
	),
	s({ trig = "mmt", snippetType = "autosnippet" },
		fmta("$ <> $ ", { i(1) })
	),
	s({ trig = "cent" },
		fmta("#align(center)[<>]", { i(1) })
	),
	s({ trig = "mla" },
		fmta([[
#set page(header: context align(right)[Ruebenacker #counter(page).get().first()])

Daniel Ruebenacker

#datetime.today().display("[day] [month repr:long] [year]")
<>

<>
		]], { i(1), i(2) })
	),
	s({ trig = 'c\'' }, fmta(
		[[
	```<>
	<>
	```
	]], { i(1), i(2) })),
	s({ trig = '->' }, fmta([[ → ]], {})),
	s({ trig = '=>' }, fmta([[ ⇒ ]], {})),
	s({ trig = "`" }, {
		t("`"),
		f(function()
			-- move cursor to end of word, append backtick
			local keys = vim.api.nvim_replace_termcodes("<Esc>ea`", true, false, true)
			vim.api.nvim_feedkeys(keys, "n", true)
			return ""
		end, {}),
	}),
	s('b', fmta([[ bold(<>)<> ]], { i(1), i(2) })),
}
