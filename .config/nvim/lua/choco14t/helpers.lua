function MergeTables(...)
  local tables = { ... }
  local result = {}

  for _, table in ipairs(tables) do
    for k, v in pairs(table) do
      result[k] = v
    end
  end

  return result
end
