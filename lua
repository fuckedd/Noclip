local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local Plr = Players.LocalPlayer
local Clipon = false
local SteppedConnection

UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.N then  -- Change the keybind here
        if Clipon then
            Clipon = false
            if SteppedConnection then
                SteppedConnection:Disconnect()
                for _, v in pairs(Plr.Character:GetChildren()) do
                    if v:IsA("BasePart") then
                        v.CanCollide = true
                    end
                end
                print("noclip disabled")
            end
        else
            Clipon = true
            SteppedConnection = game:GetService('RunService').Stepped:Connect(function()
                for _, v in pairs(Plr.Character:GetChildren()) do
                    if v:IsA("BasePart") then
                        v.CanCollide = false
                    end
                end
            end)
            print("noclip enabled")
        end
    end
end)
