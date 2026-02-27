local M = {}

-- Replace current buffer with contents of a file
function M.apply_template(filepath, noteType)
    local fullpath = vim.fn.expand(filepath)
    local lines = vim.fn.readfile(fullpath)

    if #lines == 0 then
        print("Template file is empty: " .. fullpath)
        return
    end

	-- Find the line with %s and replace it
    for i, line in ipairs(lines) do
		if line:find("%%MODELNAME Basic") then
			lines[i] = line:gsub("Basic", "Basic" .. noteType)
        end
        if line:find("%%DECKNAME %%s") then
            lines[i] = line:gsub("%%s", noteType)
            break
		end
    end

    -- Replace buffer content
    vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
end

return M
