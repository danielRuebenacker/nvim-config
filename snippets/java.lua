--- @diagnostic disable: undefined-global

-- Function for getting filename without extension
local function filename_no_ext()
	local fname = vim.fn.expand("%:t") -- just the filename, e.g. "Main.java"
	local name = fname:match("(.+)%..+$") -- strip extension
	return name or fname               -- fallback if no extension
end

return {
	s('cl', fmta(
		[[
		package <>;

		public class <> {
			<>

			public <>() {
				<>
			}
			public static void main(String[] args) {
				<>
			}
		}
	]], { i(1), f(filename_no_ext, {}), i(2), f(filename_no_ext, {}), i(3), i(4) })),
	s('pr', fmta([[ System.out.println(<>); ]], { i(1) })),
}
