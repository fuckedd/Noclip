local isNoclipEnabled = false
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local torso = character:WaitForChild("HumanoidRootPart")

local function EnableNoclip()
    for _, part in ipairs(character:GetDescendants()) do
        if part:IsA("BasePart") and part.CanCollide then
            part.CanCollide = false
        end
    end

    local noclipConnection
    noclipConnection = game:GetService("RunService").Stepped:Connect(function()
        for _, part in ipairs(character:GetDescendants()) do
            if part:IsA("BasePart") and part.CanCollide then
                part.CanCollide = false
            end
        end
    end)

    local touchedConnection
    touchedConnection = torso.Touched:Connect(function(part)
        if part.CanCollide and not part:FindFirstAncestorWhichIsA("Humanoid") then
            local originalTransparency = part.Transparency
            part.CanCollide = false
            part.Transparency = (part.Transparency <= 0.5) and 0.6 or part.Transparency
            part.CanCollide = true
            part.Transparency = originalTransparency
        end
    end)

    return {noclipConnection, touchedConnection}
end

local function DisableNoclip(connections)
    for _, connection in ipairs(connections) do
        connection:Disconnect()
    end
end

local toggleKey = Enum.KeyCode.N -- Change this to your desired key

local connections = {}

game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessedEvent)
    if not gameProcessedEvent and input.KeyCode == toggleKey then
        if isNoclipEnabled then
            DisableNoclip(connections)
            connections = {}
            for _, part in ipairs(character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = true
                end
            end
        else
            connections = EnableNoclip()
        end
        isNoclipEnabled = not isNoclipEnabled
    end
end)
