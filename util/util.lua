local util = {}
local bit = require('bit')
local chat = require('chat')

function util.addon_log(str)
    print(chat.header(addon.name):append( '[Checklist] ' .. str))
end

function util.has_bit(data, position)
    return data[position]
end

function util.table_concat(t1, t2)
    for i=1,#t2 do
        t1[#t1+1] = t2[i]
    end
    return t1
end

function util.twobits_to_table(data)
-- Extract 2-bit values into a table
	local result = {}
	for i = 1, #data, 2 do
		local value = 0
		for j = 1, 2 do
			value = value + 2^(j - 1) * (data[i + j] and 1 or 0)
		end
		result[#result + 1] = value
	end
	return result
end

function util.fourbits_to_table(data)
    local result = {}
    for i = 1, #data, 8 do
        -- lower 4 bits (bits 0–3)
		local low = 0
		for j = 1, 4 do
			low = low + 2^(j - 1) * (data[i + j] and 1 or 0)
		end
        -- upper 4 bits (bits 4–7)
        local high = 0
		for j = 1, 4 do
			high = high + 2^(j - 1) * (data[i + j + 4] and 1 or 0)
		end
        -- (LSB first)
        result[#result + 1] = low
        result[#result + 1] = high
    end
    return result
end

function util.cleanspaces(str)
    return str:gsub(" ", "_")
end

function util.list_item(category, text, completed, obtainmethod)
	if (completed ~= true) then local completed = false end
	if (text == nil) then return end
	local item = {
		category = category,
		text = text,
		completed = completed,
		obtainmethod = obtainmethod,
	}
	return item
end

function util.totalpoints()
	local completed, total = 0,0
	for key, value in pairs(playertracker) do
		if (key:sub(-10) == "_completed" and type(value) == "number") then
			completed = completed + value
		elseif (key:sub(-6) == "_total" and type(value) == "number") then
			total = total + value
		end
	end
	return (completed - playertracker['Jobpoints_completed']), (total - playertracker['Jobpoints_total'])
end

function util.table_to_clipboard(tbl)
	local result = ""
    for i = 1, #tbl do
		local text = tostring(tbl[i])
		text = text:gsub("\\cs%(%d+,%d+,%d+%)", "")
		text = text:gsub("\\cr", "")
        result = result .. text .. "\n"
    end
    return result
end

function util.log_tablog(tbl, striplastbracket)
	if (tbl == nil) then
		return
	end
	for key, item in pairs(tbl) do
		local text = item.text
		text = text:gsub("\\cs%(%d+,%d+,%d+%)", "")
		text = text:gsub("\\cr", "")
		if (item.completed == false) then
			print(chat.header(addon.name):append(chat.message(text)))
		end
	end
end

return util