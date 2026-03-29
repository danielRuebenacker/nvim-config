local util = {}


-- Function to get current buffer's filename without extension
function util.get_filename_no_ext()
    local full_path = vim.api.nvim_buf_get_name(0) -- Get full path of current buffer
    local filename = vim.fn.fnamemodify(full_path, ":t") -- Extract just the file name
    local name_no_ext = filename:match("(.+)%..+$") or filename -- Remove extension
    return name_no_ext
end

function util.dump(o)
    if type(o) == 'table' then
        local s = '{ '
        for k, v in pairs(o) do
            if type(k) ~= 'number' then k = '"' .. k .. '"' end
            -- CHANGE 'dump(v)' TO 'util.dump(v)' BELOW
            s = s .. '[' .. k .. '] = ' .. util.dump(v) .. ',' 
        end
        return s .. '} '
    else
        return tostring(o)
    end
end


---------------------------- for custom telescope pickers ---------------------
--- this code is pretty much black magic to me now, cannot remember what it does
--- if it aint broke don't fix it 󰕹
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

function util.telescopeFinder(finder_fn, dir, hidden, exclude)
	if not finder_fn then
		finder_fn = builtin.find_files
	end
	local modified_table = rgSearch(dir, hidden, exclude)
	return function() finder_fn(modified_table) end
end

function util.get_or_create_terminal_buf()
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
end

return util
