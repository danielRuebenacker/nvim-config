---@diagnostic disable: undefined-global
----------------------- Options ---------------------------------------
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
vim.o.cursorline = true
---------------------------------------------------------------------


------------------------------------------ Keymaps -------------------------------------------------
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
vim.keymap.set('n', '<leader>e', ":Oil<CR>")
-- map('n', '<leader>P', ':TypstPreviewToggle<CR>')
 map('n', '<leader>P', ':MarkdownPreviewToggle<CR>')
map({ "n" }, "<leader>p", '"+p')
map({ "t" }, "", "<C-\\><C-n>")
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

----------------------------------------------------------------------------------------------------

-- lazy
require("config.lazy")

-- some utility functions
local util = require "util"



--------------------------------------- Anki Studying ----------------------------------------------

-- for anki notes
map({ "n" }, "<leader>ab",
	function()
	local name_no_ext = util.get_filename_no_ext()
	require("templates.templates").apply_template("~/.config/nvim/lua/templates/ankiTemplate.txt", name_no_ext) end)

-- map({ "n" }, "<leader>ab", ":Anki Basic<CR>")
map({ "n" }, "<leader>as", ":AnkiSend<CR>")
-----------------------------------------------------------------------------------------------------


-------------------------------------------------- Telescope --------------------------------------------------------------------
local builtin = require("telescope.builtin")
--- Exclude this directories from search
local home_excludes = { '.config/BraveSoftware', '.config/Code', '.cache', '.local', '.arduino15', 'projects', }
local config_excludes = { 'BraveSoftware/Brave-Browser', 'Code' }

------------------- Home Dir Search ----------------------------
map('n', '<leader>ff', util.telescopeFinder(nil, '~', false, { 'projects/c++/arduino-libs' }), { desc = "Find home files" })
----------------- Config File Search --------------------------
map({ "n" }, "<leader>fc", util.telescopeFinder(nil, '~/.config', true, config_excludes), { desc = "Telescope help tags" })
------------------------------ Home Dir Grep -----------------
vim.keymap.set('n', '<leader>fwg', util.telescopeFinder(builtin.live_grep, '~', false, home_excludes),
	{ desc = "find 'wide' grep: home dir" })

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

------------------------------------------------------------------------------------------------------------------------------------------


-------------------------------------------------- Snippets and Omnicomplete -------------------------------------------------------------
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
-----------------------------------------------------------------------------------------------------------------------------------

vim.api.nvim_create_autocmd({ 'WinEnter', 'VimEnter', 'WinResized', 'BufWinEnter' }, {
  callback = function()
    local bufname = vim.api.nvim_buf_get_name(0)
    -- skip NerdTree (messes stuff up)
    if bufname:match("NERD_tree") then return end

    local width = vim.fn.winwidth(0)
    vim.bo.textwidth = width - 15  -- use window-local setting
  end,
})

-- spell check for notes
vim.api.nvim_create_autocmd("FileType", {
	pattern = {"typst", "markdown"},
	callback = function()
		vim.o.spell = true
	end,
})

vim.api.nvim_create_autocmd("TermOpen", {
	callback = function()
		vim.o.spell = false
	end,
})

-------------------------------------------------- LSPs ------------------------------------------------------------------
require("plugins.lsp")

vim.lsp.config("clangd", {
  cmd = { "clangd", "--compile-commands-dir=." },
})

vim.lsp.config("basedpyright", {
  settings = {
    basedpyright = {
	  analysis = {
	  	  typeCheckingMode = "standard",
	  	  reportMissingTypeStubs = false,       -- stop complaining about missing .pyi stubs
	  	  reportUnknownVariableType = false,    -- ignore untyped variables
	  	  reportUnknownMemberType = false,      -- ignore untyped class members
	  },
    },
  },
})

vim.lsp.enable({ "lua_ls", "basedpyright", "jdtls", "tinymist", "shfmt", "arduino-language-server", "clangd", "nil_ls",
	"bashls", "cssls", "djls", "biome", })

vim.cmd.colorscheme("neopywal")
vim.cmd(":hi statusline guibg=NONE")
