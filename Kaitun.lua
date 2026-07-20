-- Wait for the game and player to fully load
repeat 
    task.wait() 
until game:IsLoaded() and game.Players.LocalPlayer

-- Global Configuration Settings
getgenv().Configs = {
    ["Quest"] = {
        ["Evo Race V1"] = true,
        ["Evo Race V2"] = true,
        ["RGB Haki"]   = true,
        ["Pull Lerver"] = true,
    },
    
    ["Sword"] = {
        "Dual-Headed Blade",
        "Smoke Admiral",
        "Wardens Sword",
        "Cutlass",
        "Katana",
        "Dual Katana",
        "Triple Katana",
        "Iron Mace",
        "Saber",
        "Pole (1st Form)",
        "Gravity Blade",
        "Longsword",
        "Rengoku",
        "Midnight Blade",
        "Soul Cane",
        "Bisento",
        "Yama",
        "Tushita",
        "Cursed Dual Katana"
    },
    
    ["Gun"] = {
        "Soul Guitar",
        "Kabucha",
        "Venom Bow",
        "Musket",
        "Flintlock",
        "Refined Slingshot",
        "Magma Blaster",
        "Dual Flintlock",
        "Cannon",
        "Bizarre Revolver",
        "Bazooka"
    },
    
    ["FPS Booster"] = false
}

-- Execute the main script source
loadstring(game:HttpGet("https://pandadevelopment.net/virtual/file/8cffffd967953fe7"))()
