_ArmurerieLSPD = _ArmurerieLSPD or {}
_ArmurerieLSPD.Menu = _ArmurerieLSPD.Menu or {}
_ArmurerieLSPD = {
    ESX = "esx:getSharedObject",
    Event = {
        Prefix = "_/Stax_/",
    },
    JobAcces = "police",
    PositionsArmurerieLSPD = {
        {pos = vector3(452.0,  -980.0,  29.69), heading = 270.0}, --Position Menu	
    }, 
    PositionsPed = {
        {pos = vector4(454.18, -980.11, 29.68, 90.0), name = "s_m_y_cop_01", animation = "mp_cop_armoury"},	-- Position Ped
    },
    TypeArmes = "item", -- item(armes en items) ou weapon(armes en objets)
    Armes = {
        -- ##
            -- Si vous avez les armes en items mettez name = le nom de votre item--
            -- Si vous avez les armes en objets mettez name = weapon_...-- 
            -- Exemple pour les armes en items -- 
                ---# {name = "combatpistol", label = "Pistolet de combat", price = 500, Maxstock = 20, grade = 0}, #---
            -- Exemple pour les armes en objets --
                ---# {name = "weapon_combatpistol", label = "Pistolet de combat", price = 500, Maxstock = 20, grade = 0}, #---
            -----
                -- price = au prix de l'arme 
                -- Maxstock = au nombre d'arme maximum dans le stock
                -- grade = au grade minimum pour prendre l'arme
            -----
        -- ##
        {name = "weapon_stungun", label = "Tazer", price = 500, Maxstock = 20, grade = 0},
        {name = "weapon_nightstick", label = "Matraque", price = 500, Maxstock = 20, grade = 0},
        {name = "weapon_combatpistol", label = "Pistolet de combat", price = 500, Maxstock = 20, grade = 1},
        {name = "weapon_smg", label = "SMG", Maxstock = 20, price = 500, grade = 2},
        {name = "weapon_pumpshotgun", label = "Fusil à pompe", price = 500, Maxstock = 20, grade = 3},
        {name = "weapon_carbinerifle", label = "M4A1", price = 500, Maxstock = 20, grade = 4},
    },
    Markers = {
        Type = 1,
        TailleX = 0.7,
        TailleY = 0.7,
        TailleZ = 0.7,
        CouleurR = 255,
        CouleurG = 255,
        CouleurB = 255, 
        Opacite = 155,
    },
    Blips = {
        Sprite = 108,
        Scale = 0.65,
        Color = 2,
        Display = 4,
        AsShortRange = true,
        Name = "Armurerie LSPD",  
    },
    ["Translations"] = {
        ["Menu"] = {
            ["Title"] = "Armurerie LSPD",
            ["SubTitle"] = "Armurerie LSPD",
            ["Button"] = "Armurerie LSPD",
            ["colorprice"] = "~g~",
            ["add_money"] = "Vous avez deposé ~g~",
            ["remove_money"] = "Vous avez retiré ~r~",
            ["Dollars"] = "$",
            ["TypeAdvancedNotif"] = "esx:showAdvancedNotification",
            ["TypeNotif"] = "esx:showNotification",
            ["HelpNotif"] = "Appuyez sur ~INPUT_CONTEXT~ pour accéder à ~HC_11~l'armurerie ~BLIP_police_station~ ~s~",
            ["No_Money"] = "~r~Vous n'avez pas assez d\'argent~s~ !~s~",
            ["no_players"] = "Le joueur n'est pas connecté",
            ["no_transfert"] = "Vous ne pouvez pas vous transférer de l'argent",
        },
    },
}

-- https://discord.gg/g9dXrcAcwn -- 
