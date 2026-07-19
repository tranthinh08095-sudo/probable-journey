getgenv().Config = {
    ["AutoFarm"] = true,
    ["BringMob"] = true,
    ["FastAttack"] = true,
    ["AutoFruit"] = true
}

repeat task.wait() until game:IsLoaded()
local P = game.Players.LocalPlayer
local function run() return getgenv().Config ~= nil end

-- --- MINIMALIST TOGGLE MENU SETUP ---
local SG = Instance.new("ScreenGui", game:GetService("CoreGui"))

-- Main Panel (Bảng chứa chức năng)
local Frame = Instance.new("Frame", SG)
Frame.Size = UDim2.new(0, 140, 0, 150)
Frame.Position = UDim2.new(0, 10, 0, 50)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.BorderSizePixel = 2
Frame.Visible = false -- Ban đầu ẩn đi

-- Toggle Button (Nút bấm để hiện/ẩn menu)
local ToggleBtn = Instance.new("TextButton", SG)
ToggleBtn.Size = UDim2.new(0, 70, 0, 30)
ToggleBtn.Position = UDim2.new(0, 10, 0, 10)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
ToggleBtn.Text = "MENU"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.Font = Enum.Font.SourceSansBold
ToggleBtn.TextSize = 14

ToggleBtn.MouseButton1Click:Connect(function()
    if getgenv().Config then
        Frame.Visible = not Frame.Visible
        ToggleBtn.BackgroundColor3 = Frame.Visible and Color3.fromRGB(70, 70, 70) or Color3.fromRGB(50, 50, 50)
    end
end)

-- Title inside Panel
local Title = Instance.new("TextLabel", Frame)
Title.Size = UDim2.new(1, 0, 0, 25)
Title.Text = "NAI MINI"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
Title.Font = Enum.Font.SourceSansBold

local function createToggle(name, text, pos)
    local Btn = Instance.new("TextButton", Frame)
    Btn.Size = UDim2.new(1, -10, 0, 22)
    Btn.Position = UDim2.new(0, 5, 0, pos)
    Btn.Font = Enum.Font.SourceSans
    Btn.TextSize = 13
    
    local function updateVisual()
        if getgenv().Config and getgenv().Config[name] then
            Btn.Text = text .. ": ON"
            Btn.BackgroundColor3 = Color3.fromRGB(46, 139, 87)
            Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        else
            Btn.Text = text .. ": OFF"
            Btn.BackgroundColor3 = Color3.fromRGB(178, 34, 34)
            Btn.TextColor3 = Color3.fromRGB(200, 200, 200)
        end
    end
    
    updateVisual()
    Btn.MouseButton1Click:Connect(function()
        if getgenv().Config then
            getgenv().Config[name] = not getgenv().Config[name]
            updateVisual()
        end
    end)
end

createToggle("AutoFarm", "Auto Farm", 30)
createToggle("BringMob", "Bring Mob", 57)
createToggle("AutoFruit", "Auto Fruit", 84)

-- Close Everything Button
local ExitBtn = Instance.new("TextButton", Frame)
ExitBtn.Size = UDim2.new(1, -10, 0, 22)
ExitBtn.Position = UDim2.new(0, 5, 0, 115)
ExitBtn.Text = "EXIT SCRIPT"
ExitBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
ExitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ExitBtn.Font = Enum.Font.SourceSansBold
ExitBtn.MouseButton1Click:Connect(function() getgenv().Config = nil SG:Destroy() end)

-- --- AUTO FARM LOGIC (SEA 2 OPTIMIZED) ---
task.spawn(function()
    while task.wait(0.1) and run() do
        if getgenv().Config["AutoFarm"] then
            pcall(function()
                local char = P.Character
                if char and char:FindFirstChild("HumanoidRootPart") then
                    for _, E in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                        if E:FindFirstChild("HumanoidRootPart") and E:FindFirstChild("Humanoid") and E.Humanoid.Health > 0 then
                            while E.Humanoid.Health > 0 and run() and getgenv().Config["AutoFarm"] do
                                task.wait()
                                char.HumanoidRootPart.CFrame = E.HumanoidRootPart.CFrame * CFrame.new(0, 5, 0)
                                if getgenv().Config["FastAttack"] then
                                    game:GetService("VirtualUser"):CaptureController()
                                    game:GetService("VirtualUser"):ClickButton1(Vector2.new(851, 529))
                                end
                            end
                        end
                    end
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
                        if (v.HumanoidRootPart.Position - P.Character.HumanoidRootPart.Position).Magnitude <= 300 then
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
