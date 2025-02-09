local M = {}

M.load_env_file = function(env_file)
    local env_vars = {}
    local file = io.open(env_file, "r")

    if file then
        for line in file:lines() do
            local key, value = line:match("^export%s([A-Z0-9_]+)=(.+)$")
            if key and value then
                local env_entry = key .. "=" .. value
                table.insert(env_vars, env_entry)
            end
        end
        file:close()
    end
    return env_vars
end

return M
