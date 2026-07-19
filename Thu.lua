--[[
    KAITUN MINIMALIST (CDK, GODHUMAN, FRUIT, LEVEL)
    Author: Open Source Base
--]]

getgenv().Config = {
    ["AutoLevel"] = true,
    ["GetGodHuman"] = true,
    ["GetCDK"] = true,
    ["AutoSniperFruit"] = true, -- Automatically teleports to spawned fruits
    ["BringMob"] = true,
    ["FastAttack"] = true
}

repeat task.wait() until game:IsLoaded()
local Player = game.Players.LocalPlayer

-- Minimalist UI: Create a tiny exit button on the screen
local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
local ToggleBtn = Instance.new("TextButton", ScreenGui)
ToggleBtn.Size = UDim2.new(0, 100, 0, 40)
ToggleBtn.Position = UDim2.new(0, 10, 0, 10)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
ToggleBtn.Text = "EXIT SCRIPT"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.Font = Enum.Font.SourceSansBold
ToggleBtn.TextSize = 14

ToggleBtn.MouseButton1Click:Connect(function()
    getgenv().Config = nil
    ScreenGui:Destroy()
    print("Script successfully terminated.")
end)

-- Safety check helper to stop loops immediately on exit
local function running()
    return getgenv().Config ~= nil
end

-- 1. Auto Sniper Fruit (Teleport to spawned fruits on the map)
task.spawn(function()
    while task.wait(1) and running() do
        if getgenv().Config["AutoSniperFruit"] then
            for _, v in pairs(game:GetService("Workspace"):GetChildren()) do
                if v:IsA("Tool") and string.find(v.Name, "Fruit") then
                    local char = Player.Character or Player.CharacterAdded:Wait()
                    if char:FindFirstChild("HumanoidRootPart") then
                        char.HumanoidRootPart.CFrame = v.Handle.CFrame
                        task.wait(0.5)
                    end
                end
            end
        end
    end
end)

-- 2. Bring Mob (Gathers and stacks nearby enemies)
task.spawn(function()
    while task.wait() and running() do
        if getgenv().Config["BringMob"] then
            pcall(function()
                local char = Player.Character
                if char and char:FindFirstChild("HumanoidRootPart") then
                    for _, v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                        if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                            if (v.HumanoidRootPart.Position - char.HumanoidRootPart.Position).Magnitude <= 300 then
                                v.HumanoidRootPart.CFrame = char.HumanoidRootPart.CFrame * CFrame.new(0, 0, -5)
                                v.HumanoidRootPart.CanCollide = false
                            end
                        end
                    end
                end
            end)
        end
    end
end)

-- 3. Main Loop: Leveling up -> Godhuman -> CDK Progression
task.spawn(function()
    while task.wait(0.5) and running() do
        pcall(function()
            local lvl = Player.Data.Level.Value
            local CommF = game:GetService("ReplicatedStorage").Remotes.CommF_
            
            -- Priority 1: Check materials and purchase Godhuman if Level >= 2200
            if getgenv().Config["GetGodHuman"] and lvl >= 2200 then
                CommF:InvokeServer("BuyGodhuman")
            end
            
            -- Priority 2: Execute Cursed Dual Katana progression if Level >= 2200
            if getgenv().Config["GetCDK"] and lvl >= 2200 then
                CommF:InvokeServer("CursedDualKatana", "CheckQuest")
            end
            
            -- Priority 3: Standard Level Farming
            if getgenv().Config["AutoLevel"] then
                local Enemy = game:GetService("Workspace").Enemies:FindFirstChildOfClass("Model")
                local char = Player.Character
                if Enemy and Enemy:FindFirstChild("HumanoidRootPart") and Enemy.Humanoid.Health > 0 and char:FindFirstChild("HumanoidRootPart") then
                    char.HumanoidRootPart.CFrame = Enemy.HumanoidRootPart.CFrame * CFrame.new(0, 5, 0)
                    
                    if getgenv().Config["FastAttack"] then
                        game:GetService("VirtualUser"):CaptureController()
                        game:GetService("VirtualUser"):ClickButton1(Vector2.new(851, 529))
                    end
                end
            end
        end)
    end
end)

print("Kaitun Minimalist loaded successfully!")
