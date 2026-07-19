getgenv().NaiKaitun = {
    Team = "Pirates", AutoFarm = true, AutoQuest = true, AutoSea = true,
    MasteryFarm = true, FastAttack = true, NoClip = true, AutoCDK = true,
    AutoGodhuman = true, AutoRaceV3 = true, AutoFruit = true, Magnet = true,
    FPSBoost = true, BringMobDistance = 200
}

local SG = Instance.new("ScreenGui", game:GetService("CoreGui"))
local Btn = Instance.new("TextButton", SG)
Btn.Size, Btn.Position, Btn.BackgroundColor3, Btn.Text, Btn.TextColor3 = UDim2.new(0, 80, 0, 35), UDim2.new(0, 10, 0, 10), Color3.fromRGB(200, 50, 50), "EXIT", Color3.fromRGB(255, 255, 255)
Btn.Font, Btn.TextSize = Enum.Font.SourceSansBold, 14
Btn.MouseButton1Click:Connect(function() getgenv().NaiKaitun = nil SG:Destroy() end)

if getgenv().NaiKaitun.FPSBoost then setfpscap(30) end
loadstring(game:HttpGet('https://raw.githubusercontent.com/ZaqueHub/BloxFruitPC/05507b61c0092197a3b6233ca305f2dfacd20050/KaitunZaque.lua'))()
