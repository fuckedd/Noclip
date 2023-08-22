local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local Plr = Players.LocalPlayer
local Clipon = false
local SteppedConnection

local function ToggleNoclip()
    if not Clipon then
        Clipon = true
        SteppedConnection = game:GetService("RunService").Stepped:Connect(function()
            for _, b in pairs(game.Workspace:GetChildren()) do
                if b.Name == Plr.Name then
                    for _, v in pairs(b:GetChildren()) do
                        if v:IsA("BasePart") then
                            v.CanCollide = false
                        end
                    end
                end
            end
        end)
    else
        Clipon = false
        if SteppedConnection then
            SteppedConnection:Disconnect()
            for _, b in pairs(game.Workspace:GetChildren()) do
                if b.Name == Plr.Name then
                    for _, v in pairs(b:GetChildren()) do
                        if v:IsA("BasePart") then
                            v.CanCollide = true
                        end
                    end
                end
            end
        end
    end
end

UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
    if not gameProcessedEvent then
        if input.KeyCode == Enum.KeyCode.T then
            local textBoxFocused = UserInputService:GetFocusedTextBox()
            if not textBoxFocused then
                ToggleNoclip()
            end
        end
    end
end)

-- Set initial state to off
Clipon = false

print("Noclip is off")
