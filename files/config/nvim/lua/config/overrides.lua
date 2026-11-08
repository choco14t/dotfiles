local function optional_require(name)
  local path = vim.fn.stdpath("config") .. "/lua/" .. name:gsub("%.", "/") .. ".lua"
  local stat, err, code = vim.uv.fs_stat(path)
  if stat then
    return require(name)
  end
  if code ~= "ENOENT" then
    error(err)
  end
end

optional_require("choco14t.private")
return optional_require("plugins.local") or {}
