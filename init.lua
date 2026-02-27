vim.o.number = true
vim.o.relativenumber = true
vim.o.wrap = false
vim.o.tabstop = 4
vim.o.swapfile = false
vim.g.mapleader = " "
vim.o.shiftwidth = 4
vim.o.signcolumn = "yes"
vim.o.winborder = "rounded"
vim.o.termguicolors = true
vim.o.ignorecase = true


---------------------------- Keymaps -------------------------------
local map = vim.keymap.set

map('n', '<leader>o', ':update<CR> :source<CR>')
map('n', '<leader>w', ':w<CR>')
map('n', '<leader>q', ':q<CR>')
map('n', '<leader>lf', vim.lsp.buf.format)
map('n', '<leader>c', ':e ~/.config/nvim/init.lua<CR>')
map('n', '<leader>m', ':make<CR>')
map('n', '<leader>x', ':bd<CR>')
map('n', '<leader>X', ':bd!<CR>')
map('n', '<leader>s', ':e #<CR>')
map('n', '<leader>n', 'a<CR><ESC>')
map('n', '<leader>E', ':NERDTreeToggle<CR>')
-- map('n', '<leader>P', ':TypstPreviewToggle<CR>')
 map('n', '<leader>P', ':MarkdownPreviewToggle<CR>')
-- map({ "n" }, "<leader>nx", ":e +106 ~/mysystem/nixos/configuration.nix<CR>")
map({ "n" }, "<leader>p", '"+p')
map({ "t" }, "", "<C-\\><C-n>")
-- map({ "n" }, "<leader>t", ":term<CR>")
map({ "n" }, "<leader>y", "\"+y")

vim.keymap.set("n", "<leader>t", function()
  -- Look for an existing terminal buffer
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(buf) then
      local bt = vim.bo[buf].buftype
      if bt == "terminal" then
        -- Open the terminal buffer in the current window
        vim.api.nvim_set_current_buf(buf)
        return
      end
    end
  end

  -- If no terminal buffer exists, open a new one
  vim.cmd("term")
end, { desc = "Open terminal or focus existing one" })



-- Function to get current buffer's filename without extension
local function get_filename_no_ext()
    local full_path = vim.api.nvim_buf_get_name(0) -- Get full path of current buffer
    local filename = vim.fn.fnamemodify(full_path, ":t") -- Extract just the file name
    local name_no_ext = filename:match("(.+)%..+$") or filename -- Remove extension
    return name_no_ext
end

-- for anki notes
map({ "n" }, "<leader>ab",
	function()
	local name_no_ext = get_filename_no_ext()
	require("templates.templates").apply_template("~/.config/nvim/lua/templates/ankiTemplate.txt", name_no_ext) end)

-- map({ "n" }, "<leader>ab", ":Anki Basic<CR>")
map({ "n" }, "<leader>as", ":AnkiSend<CR>")



vim.pack.add({
	{ src = "https://github.com/vague2k/vague.nvim" },
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/echasnovski/mini.pick" },
	{ src = "https://github.com/chomosuke/typst-preview.nvim" },
	{ src = "https://github.com/L3MON4D3/LuaSnip" },
	{ src = "https://github.com/lervag/vimtex" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{ src = "https://github.com/nvim-telescope/telescope.nvim" },
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/aznhe21/actions-preview.nvim" },
	-- { src = "https://github.com/mfussenegger/nvim-jdtls" },
	{ src = "https://github.com/iamcco/markdown-preview.nvim" },
	{ src = "https://github.com/rareitems/anki.nvim" },
	{ src = "https://github.com/MeanderingProgrammer/render-markdown.nvim" },
	{ src = "https://github.com/nvim-tree/nvim-web-devicons" },
	{ src = "https://github.com/tree-sitter-grammars/tree-sitter-markdown" },
	{ src = "https://github.com/latex-lsp/tree-sitter-latex" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/nvim-java/nvim-java" },
	{ src = "https://github.com/JavaHello/spring-boot.nvim" },
	{ src = "https://github.com/MunifTanjim/nui.nvim" },
	{ src = "https://github.com/mfussenegger/nvim-dap" },
	{ src = "https://github.com/m4xshen/autoclose.nvim" },
	{ src = "https://github.com/preservim/nerdtree" },
	{ src = "https://github.com/kawre/leetcode.nvim" },

	
})
-- Not on NixOS
-- { src = "https://github.com/mason-org/mason.nvim" },
--
require('leetcode').setup()
--
require('java').setup()

require("autoclose").setup()

require "telescope".setup({
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
		}
	}
})

require("anki").setup({
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
	-- linters = require("anki.linters").default_linters();
})

require("actions-preview").setup {
	backend = { "telescope" },
	extensions = { "env" },
	telescope = vim.tbl_extend(
		"force",
		require("telescope.themes").get_dropdown(), {}
	)
}

require('render-markdown').setup({
  latex = { enabled = false },
})



-- local function dump(o)
-- 	if type(o) == 'table' then
-- 		local s = '{ '
-- 		for k, v in pairs(o) do
-- 			if type(k) ~= 'number' then k = '"' .. k .. '"' end
-- 			s = s .. '[' .. k .. '] = ' .. dump(v) .. ','
-- 		end
-- 		return s .. '} '
-- 	else
-- 		return tostring(o)
-- 	end
-- end
--



local builtin = require("telescope.builtin")
local function rgSearch(rootDir, hidden, excludeDirs)
	local returnTable = {}
	local find_command_array = { 'rg' } -- new empty array
	table.insert(find_command_array, '--files')
	if hidden then
		table.insert(find_command_array, '--hidden')
	end
	-- find_command_array[2] =  hidden and '--hidden'
	for _, elt in pairs(excludeDirs) do
		table.insert(find_command_array, '-g')
		table.insert(find_command_array, '!' .. elt .. '/**')
	end
	returnTable['cwd'] = vim.fn.expand(rootDir)
	returnTable['find_command'] = find_command_array
	-- print(dump(returnTable))
	return returnTable
end

local function telescopeFinder(finder_fn, dir, hidden, exclude)
	if not finder_fn then
		finder_fn = builtin.find_files
	end
	local modified_table = rgSearch(dir, hidden, exclude)
	return function() finder_fn(modified_table) end
end

-- local modified_table = rgSearch('~', false, { 'projects' })
-- print(modified_table)
-- print(dump(modified_table))

--- Exclude this directories from search
local home_excludes = { '.config/BraveSoftware', '.config/Code', '.cache', '.local', '.arduino15', 'projects', }
local config_excludes = { 'BraveSoftware/Brave-Browser', 'Code' }

------------------- Home Dir Search ---------------------------------------------------------------------------------------------
map('n', '<leader>ff', telescopeFinder(nil, '~', false, { 'projects/c++/arduino-libs' }), { desc = "Find home files" })
----------------- Config File Search -------------------------------------------------------------------------------------------------
map({ "n" }, "<leader>fc", telescopeFinder(nil, '~/.config', true, config_excludes), { desc = "Telescope help tags" })
------------------------------ Home Dir Grep ---------------------------------------------------------------------------------------------
vim.keymap.set('n', '<leader>fwg', telescopeFinder(builtin.live_grep, '~', false, home_excludes),
	{ desc = "find 'wide' grep: home dir" })
------------------------------------------------------------------------------------------------------------------------------------------
---
map({ "n" }, "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
map({ "n" }, "<leader>fo", builtin.oldfiles, { desc = "Telescope old files" })
map({ "n" }, "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
map({ "n" }, "<leader>fl", builtin.lsp_references, { desc = "Lsp References" })
map({ "n" }, "<leader>fa", require("actions-preview").code_actions)
map({ "n" }, "<leader>fr", builtin.registers, { desc = "Registers" })
map({ "n" }, "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
map({ "n" }, "<leader>fm", builtin.man_pages, { desc = "Telescope man pages" })
-- map({ "n" }, "<leader>si", builtin.grep_string, { desc = "Telescope live string" })
-- map({ "n" }, "<leader>st", builtin.builtin, { desc = "Telescope tags" })
-- map({ "n" }, "<leader>fc", builtin.colorscheme, { desc = "Colorschemes" })
-- map({ "n" }, "<leader>se", "<cmd>Telescope env<cr>", { desc = "Telescope tags" })



require("oil").setup()

-- snippets
require("luasnip").setup({ enable_autosnippets = true, updateevents = "TextChanged,TextChangedI", })
require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/snippets/" })
local ls = require("luasnip")
vim.keymap.set("i", "<C-e>", function() ls.expand_or_jump(1) end, { silent = true })
vim.keymap.set({ "i", "s" }, "<C-J>", function() ls.jump(1) end, { silent = true })
vim.keymap.set({ "i", "s" }, "<C-K>", function() ls.jump(-1) end, { silent = true })

vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if client ~= nil then
			if client:supports_method('textDocument/completion') then
				vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
			end
		end
	end,
})
vim.cmd("set completeopt+=noselect")

-- vim.keymap.set('n', '<leader>ff', ":Pick files tool='rg'<CR>")
-- vim.keymap.set('n', '<leader>fh', ":Pick help<CR>")
-- vim.keymap.set('n', '<leader>fb', ":Pick buffers<CR>")
vim.keymap.set('n', '<leader>e', ":Oil<CR>")


-- For Java
vim.api.nvim_create_autocmd("FileType", {
	pattern = "java",
	callback = function()
		local cwd = vim.fn.fnamemodify(vim.fn.getcwd(), ":t") -- get last part of cwd
		local bin = "../bin"

		if cwd == "src" and vim.fn.isdirectory(bin) == 1 then
			-- we're inside "src" and ../bin exists
			vim.opt_local.makeprg = "javac -d " .. bin .. " % && java -cp " .. bin .. " %:t:r"
		else
			-- fallback
			vim.opt_local.makeprg = "javac % && java %:t:r"

		end
	end,
})

vim.api.nvim_create_autocmd({ 'WinResized', 'VimEnter' }, {
	callback = function()
		local width = vim.fn.winwidth(0)
		vim.o.textwidth = width - 15
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "typst",
	callback = function()
		vim.o.spell = true
	end,
})

vim.api.nvim_create_autocmd("TermOpen", {
	callback = function()
		vim.o.spell = false
	end,
})



-- vim.lsp.config({ "lua_ls", "basedpyright", "jdtls", "tinymist", "bashls", "shfmt", "arduino-language-server", "clangd",
-- 	"nil_ls"} )

vim.lsp.enable({ "lua_ls", "basedpyright", "jdtls", "tinymist", "bashls", "shfmt", "arduino-language-server", "clangd",
	"nil_ls"
})


require("typst-preview").setup({
	port = 4000,
	debug = true,
	open_cmd = 'brave %s',
	dependencies_bin = {
		['tinymist'] = "/home/danjel/.local/share/nvim/typst-preview/tinymist",
		['websocat'] = "/home/danjel/.local/share/nvim/typst-preview/websocat",
	},
})


-- Try to create command to indent things uniformly on the right (OCD)
-- OCD: align text by a symbol with a fixed width
-- Usage: :OCD <width> <symbol> in visual mode
vim.api.nvim_create_user_command("OCD", function(opts)
	local width = tonumber(opts.fargs[1])
	local symbol = opts.fargs[2]

	if not width or not symbol then
		print("Usage: :OCD <width> <symbol>")
		return
	end

	-- Get visual selection or range
	local start_line = vim.fn.line("'<")
	local end_line = vim.fn.line("'>")

	for line_num = start_line, end_line do
		local line = vim.fn.getline(line_num)

		-- Escape magic characters in the symbol for Lua pattern
		local sym_escaped = symbol:gsub("([^%w])", "%%%1")

		-- Split line at first occurrence of symbol
		local before, after = line:match("^(.-)%s*" .. sym_escaped .. "(.*)$")
		if before and after then
			-- Pad the first part to the desired width
			local new_line = string.format("%-" .. width .. "s%s%s", before, symbol, after)
			vim.fn.setline(line_num, new_line)
		end
	end
end, { range = true, nargs = "+" })


vim.cmd("colorscheme vague")
vim.cmd(":hi statusline guibg=NONE")
