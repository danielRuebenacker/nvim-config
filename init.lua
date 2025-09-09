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

-- Yank to system clipboard
vim.keymap.set({ 'n', 'v' }, 'y', '"+y')
vim.keymap.set('n', 'yy', '"+yy')
vim.keymap.set('v', 'Y', '"+y$')


vim.keymap.set('n', '<leader>o', ':update<CR> :source<CR>')
vim.keymap.set('n', '<leader>w', ':w<CR>')
vim.keymap.set('n', '<leader>q', ':q<CR>')
vim.keymap.set({ 'i', 'v' }, 'kj', '<ESC>')
vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format)
vim.keymap.set('n', '<leader>c', ':e ~/.config/nvim/init.lua<CR>')
vim.keymap.set('n', '<leader>m', ':make<CR>')
vim.keymap.set('n', '<leader>x', ':bd<CR>')
vim.keymap.set('n', '<leader>X', ':bd!<CR>')
vim.keymap.set('n', '<leader>s', ':e #<CR>')
vim.keymap.set('n', '<leader>p', ':TypstPreviewToggle<CR>')

vim.pack.add({
	{ src = "https://github.com/vague2k/vague.nvim" },
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/echasnovski/mini.pick" },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/chomosuke/typst-preview.nvim" },
	{ src = "https://github.com/L3MON4D3/LuaSnip" },
})
require("oil").setup()
require("mini.pick").setup()
require("mason").setup()

-- snippets

-- Correct LuaRocks paths for jsregexp
package.path = package.path .. ";/home/danjel/.luarocks/share/lua/5.1/?.lua;/home/danjel/.luarocks/share/lua/5.1/?/init.lua"
package.cpath = package.cpath .. ";/home/danjel/.luarocks/lib64/lua/5.1/?.so;/home/danjel/.luarocks/lib64/lua/5.1/?/core.so"

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

vim.keymap.set('n', '<leader>ff', ":Pick files<CR>")
vim.keymap.set('n', '<leader>fh', ":Pick help<CR>")
vim.keymap.set('n', '<leader>fb', ":Pick buffers<CR>")
vim.keymap.set('n', '<leader>e', ":Oil<CR>")

-- Choose from home directory config files
vim.keymap.set('n', '<leader>fc', function()
	local config_dir = vim.fn.expand("~/.config")
	local files = vim.split(vim.fn.glob(config_dir .. "/*"), "\n")
	MiniPick.start({
		source = { items = files, name = 'Configs' },
		on_select = function(item)
			vim.cmd("edit " .. item)
		end,
	})
end)

vim.lsp.enable({ "lua_ls", "basedpyright", "jdtls", "tinymist", "bashls", "shfmt" })

require("typst-preview").setup({
	port = 4000,
	debug = true,
	dependencies_bin = {
		['tinymist'] = nil,
		['websocat'] = "/home/danjel/websocat/target/release/websocat"
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
