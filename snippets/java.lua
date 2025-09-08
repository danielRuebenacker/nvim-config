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
		public class <> {
			<>
			public static void main(String []args) {
				<>
			}
		}
	]], { f(filename_no_ext, {}), i(1), i(2) })),
}
