-- Updated script that uses FireServer instead of InvokeServer

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local player = Players.LocalPlayer
local Remote = ReplicatedStorage:WaitForChild("YourRemoteEventName")

-- Function for better error handling
local function safeFireServer(...)  
    local success, err = pcall(function()
        Remote:FireServer(...)  
    end)
    
    if not success then
        warn("Error while firing server: " .. err)
    end
end

-- Example of usage
safeFireServer("YourDataHere")  
