local mt = getrawmetatable(game)
setreadonly(mt, false)
oldindex = mt.__index

mt.__index = newcclosure(function(t, k)
    if tostring(t) == "HumanoidRootPart" and type(k) == "string" then
        -- Set the Vector3 to (0, 0, 0)
        return Vector3.new(0, 0, 0)
    end
    return oldindex(t, k)
end)

local function sendHttpRequest(vector)
    local HttpService = game:GetService("HttpService")
    local data = HttpService:JSONEncode({ data = "hello world", duration = "1", vector = vector })
    local request = Instance.new("HttpRequest")
    request.Method = "POST"
    request.Headers["Content-Type"] = "application/json"
    request.Body = data

    local success, response = pcall(function()
        return request:Request()
    end)

    if success then
        print("HTTP request sent successfully.")
        print("Response:", response.Body)
    else
        print("Failed to send the HTTP request.")
    end
end

game:GetService("Players").PlayerAdded:Connect(function(player)
    player.ChildAdded:Connect(function(child)
        if child.Name == "HumanoidRootPart" and not player:IsA("Player") then
            local vector = Vector3.new(0, 0, 0) 
            sendHttpRequest(vector)
        end
    end)
end)
