local utils = {}

function utils.splitString(baseString, delimiter)
  local result = { }
  local from  = 1
  local delim_from, delim_to = string.find( baseString, delimiter, from  )
  while delim_from do
    table.insert( result, string.sub( baseString, from , delim_from-1 ) )
    from  = delim_to + 1
    delim_from, delim_to = string.find( baseString, delimiter, from  )
  end
  table.insert( result, string.sub( baseString, from  ) )
  return result
end

function utils.mergeTables(newTable, baseTable)
  newTable = newTable or {}
  baseTable = baseTable or {}

  local response = {}
  for k, v in pairs(baseTable) do response[k] = v end
  for k, v in pairs(newTable) do response[k] = v end
  return response
end

return utils
