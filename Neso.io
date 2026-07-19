getgenv().Config = {
    ["AutoFarm"] = true,
    ["BringMob"] = true,
    ["FastAttack"] = true,
    ["AutoFruit"] = true
}

repeat task.wait() until game:IsLoaded()
local P = game.Players.LocalPlayer

local SG = Instance.new("ScreenGui", game:GetService("CoreGui"))
local Btn = Instance.new("TextButton", SG)
Btn.Size, Btn.Position, Btn.BackgroundColor3, Btn.Text, Btn.TextColor3 = UDim2.new(0, 70, 0, 30), UDim2.new(0, 10, 0, 10), Color3.fromRGB(200, 50, 50), "EXIT", Color3.fromRGB(255, 255, 255)
Btn.Font, Btn.TextSize = Enum.Font.SourceSansBold, 14
Btn.MouseButton1Click:Connect(function() getgenv().Config = nil SG:Destroy() end)

local function run() return getgenv().Config ~= nil end

task.spawn(function()
    while task.wait(0.1) and run() do
        if getgenv().Config["AutoFarm"] then
            pcall(function()
                local E = game:GetService("Workspace").Enemies:FindFirstChildOfClass("Model")
                local char = P.Character
                if E and E:FindFirstChild("HumanoidRootPart") and E.Humanoid.Health > 0 and char and char:FindFirstChild("HumanoidRootPart") then
                    char.HumanoidRootPart.CFrame = E.HumanoidRootPart.CFrame * CFrame.new(0, 5, 0)
                    if getgenv().Config["FastAttack"] then
                        game:GetService("VirtualUser"):CaptureController()
                        game:GetService("VirtualUser"):ClickButton1(Vector2.new(851, 529))
                    end
                end
                if not P.PlayerGui.Main.Quest.Visible then
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", "BanditQuest1", 1)
                end
            end)
        end
    end
end)

task.spawn(function()
    while task.wait() and run() do
        if getgenv().Config["BringMob"] and P.Character and P.Character:FindFirstChild("HumanoidRootPart") then
            pcall(function()
                for _, v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                    if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                        if (v.HumanoidRootPart.Position - P.Character.HumanoidRootPart.Position).Magnitude <= 250 then
                            v.HumanoidRootPart.CFrame = P.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -5)
                            v.HumanoidRootPart.CanCollide = false
                        end
                    end
                end
            end)
        end
    end
end)

task.spawn(function()
    while task.wait(1) and run() do
        if getgenv().Config["AutoFruit"] then
            for _, v in pairs(game:GetService("Workspace"):GetChildren()) do
                if v:IsA("Tool") and string.find(v.Name, "Fruit") and P.Character and P.Character:FindFirstChild("HumanoidRootPart") then
                    P.Character.HumanoidRootPart.CFrame = v.Handle.CFrame
                end
            end
        end
    end
end)

print("Minimalist Script Loaded!")
