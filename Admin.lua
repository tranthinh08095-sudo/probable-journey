-- ================================================
-- NAI-KAITUN FULL SCRIPT FOR BLOX FRUITS
-- Auto Kaitun from Lv1 to Max Level
-- ================================================

getgenv().NaiKaitun = {
    Team = "Pirates",           -- Pirates or Marine
    AutoFarm = true,
    AutoQuest = true,
    AutoSea = true,
    MasteryFarm = true,
    FastAttack = true,
    NoClip = true,
    AutoCDK = true,
    AutoGodhuman = true,
    AutoRaceV3 = true,
    AutoFruit = true,
    Magnet = true,
    FPSBoost = true,
    BringMobDistance = 200,
}

print("🔥 Nai-Kaitun Full Script Loading...")

-- Load main Kaitun Hub
loadstring(game:HttpGet('https://raw.githubusercontent.com/ZaqueHub/BloxFruitPC/05507b61c0092197a3b6233ca305f2dfacd20050/KaitunZaque.lua'))()

-- Additional features
task.spawn(function()
    while wait(2) do
        pcall(function()
            if getgenv().NaiKaitun.Magnet then
                print("🧲 Magnet Mob: ON")
            end
            if getgenv().NaiKaitun.FPSBoost then
                setfpscap(30)
            end
        end)
    end
end)

print("✅ Nai-Kaitun Full Loaded!")
print("Team: " .. getgenv().NaiKaitun.Team)
print("Auto Farm, Quest, Sea, Mastery, CDK, Godhuman... is running!")
