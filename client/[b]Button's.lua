

RegisterNetEvent(("%s:SQLArmurerie"):format(_ArmurerieLSPD.Event.Prefix))
AddEventHandler(("%s:SQLArmurerie"):format(_ArmurerieLSPD.Event.Prefix), function(Stock)
    _ArmurerieLSPD.Stock = Stock
end)

RegisterNetEvent(("%s:SQLHistorique"):format(_ArmurerieLSPD.Event.Prefix))
AddEventHandler(("%s:SQLHistorique"):format(_ArmurerieLSPD.Event.Prefix), function(Historique)
    _ArmurerieLSPD.HistoriqueSQL = Historique
end)

RegisterNetEvent(("%s:Inventory"):format(_ArmurerieLSPD.Event.Prefix))
AddEventHandler(("%s:Inventory"):format(_ArmurerieLSPD.Event.Prefix), function(InventoryTable)
    _ArmurerieLSPD.Inventory = InventoryTable
end)

function _ArmurerieLSPD.ArmurerieLSPDButton()
    RageUI.Separator("Votre grade : ~o~"..ESX.PlayerData.job.grade_label)
    RageUI.Button("Déposer dans le stock", nil, {LeftBadge = RageUI.BadgeStyle.Star, RightLabel = "→"}, true, {
        onSelected = function()
            ESX.PlayerData = ESX.GetPlayerData()
        end,
    }, _ArmurerieLSPD.Menu.submain2)
    if (ESX.PlayerData.job.grade_name == "boss") then
        RageUI.Button("Acheter armes", nil, {LeftBadge = RageUI.BadgeStyle.Star, RightLabel = "→"}, true, {
        }, _ArmurerieLSPD.Menu.submain)
        RageUI.Button("Voir l'historique de l'armurerie", nil, {LeftBadge = RageUI.BadgeStyle.Star, RightLabel = "→"}, true, {
            onSelected = function()
                TriggerServerEvent(("%s:SQLHistorique"):format(_ArmurerieLSPD.Event.Prefix))
                RageUI.Visible(_ArmurerieLSPD.Menu.subhistoriquemain, true)
            end
        })
    end
    RageUI.Line()
    if #_ArmurerieLSPD.Stock < 1 then
        RageUI.Separator("~r~Aucune arme en stock~s~")
        RageUI.Line()
    else
        for k,v in pairs(_ArmurerieLSPD.Stock) do
            if ESX.PlayerData.job.grade >= tonumber(v.grade) then
                RageUI.Button(v.label.." [~b~Prendre~s~]", nil, {LeftBadge = RageUI.BadgeStyle.Star, RightLabel = "Stock [x~HC_210~"..tonumber(v.stock).."~s~]"}, not cooldown , {
                    onSelected = function()
                        cooldown = true
                        ESX.SetTimeout(3000,function()
                            cooldown = false
                        end)
                        if tonumber(v.stock) == 0 then 
                            TriggerServerEvent(("%s:addWeapon"):format(_ArmurerieLSPD.Event.Prefix),v.name , v.label)
                        else
                            Animations(v.name, v.label)
                        end
                    end
                })
            end
        end
    end
end

-- https://discord.gg/g9dXrcAcwn
function _ArmurerieLSPD.SubButton()
    for k,v in pairs(_ArmurerieLSPD.Armes) do
        RageUI.Button(v.label.." [~g~Acheter~s~]", nil, {LeftBadge = RageUI.BadgeStyle.Star,RightLabel = "Prix : (~g~"..v.price.."~s~$)"}, true, {
            onSelected = function()
                TriggerServerEvent(("%s:InsertSQLArmurerie_"):format(_ArmurerieLSPD.Event.Prefix),k)
                Wait(100)
                TriggerServerEvent(("%s:SQLArmurerie"):format(_ArmurerieLSPD.Event.Prefix))
                Wait(100)
                TriggerServerEvent(("%s:InsertSQLHistorique_"):format(_ArmurerieLSPD.Event.Prefix),"[~HC_210~+1~s~]", v.label)
            end,
        })
    end
end

function _ArmurerieLSPD.SubButton2()
    for k,v in pairs(_ArmurerieLSPD.Armes) do 
        for i = 1, #ESX.PlayerData.inventory do
            if ESX.PlayerData.inventory[i].count > 0 then
                if ESX.PlayerData.inventory[i].name == v.name then
                    RageUI.Button(ESX.PlayerData.inventory[i].label.." ("..ESX.PlayerData.inventory[i].count..")", nil, {LeftBadge = RageUI.BadgeStyle.Star, RightLabel = "Déposer →"}, true, {
                        onSelected = function()
                            local number = _ArmurerieLSPD.KeyboardInput("Combien ?", "", 4)
                            if number ~= nil or number ~= 0 then 
                                TriggerServerEvent(("%s:RemoveItems_"):format(_ArmurerieLSPD.Event.Prefix), _ArmurerieLSPD.TypeArmes, v.name, tonumber(number))
                                Wait(100)
                                TriggerServerEvent(("%s:InsertSQLArmurerie_2"):format(_ArmurerieLSPD.Event.Prefix),k, tonumber(number))
                                Wait(100)
                                TriggerServerEvent(("%s:SQLArmurerie"):format(_ArmurerieLSPD.Event.Prefix))
                                Wait(100)
                                TriggerServerEvent(("%s:InsertSQLHistorique_"):format(_ArmurerieLSPD.Event.Prefix),"[~HC_210~+"..tonumber(number).."~s~]", v.label)
                                Wait(100)
                                ESX.PlayerData = ESX.GetPlayerData()
                            else
                                ESX.ShowNotification("~r~Vous devez entrer un nombre valide")
                            end
                        end
                    })
                end
            end
        end
    end
end

function _ArmurerieLSPD.Historique()
    if #_ArmurerieLSPD.HistoriqueSQL < 1 then 
        RageUI.Line()
        RageUI.Separator("~r~Aucune arme en historique~s~")
        RageUI.Line()
    else
        RageUI.Line()
        RageUI.Button("Vider l'historique", nil, {LeftBadge = RageUI.BadgeStyle.Star, RightLabel = "→"}, true, {
            onSelected = function()
                TriggerServerEvent(("%s:SupprimerHistoriqueLSPD_"):format(_ArmurerieLSPD.Event.Prefix), 2)
                Wait(100)
                TriggerServerEvent(("%s:SQLHistorique"):format(_ArmurerieLSPD.Event.Prefix))
            end
        })
        RageUI.Line()
        for k,v in pairs(_ArmurerieLSPD.HistoriqueSQL) do 
            RageUI.Button("("..v.id..")".." - "..v.type.." "..v.weapon, "["..v.date.."] - "..v.nom, {LeftBadge = RageUI.BadgeStyle.Star, RightLabel = "→ 🗑"}, true, {
                onSelected = function()
                    local variable = _ArmurerieLSPD.KeyboardInput("SUPPRIMER ? (~b~OUI~s~/~r~NON~s~)", "", 10)
                    if variable == nil or variable == "" then
                        ESX.ShowNotification("Vous devez entrer ~b~OUI~s~ ou ~r~NON~s~")
                    elseif variable:lower() == "oui" or variable:upper() == "OUI" then
                        TriggerServerEvent(("%s:SupprimerHistoriqueLSPD_"):format(_ArmurerieLSPD.Event.Prefix),1, v.id)
                        Wait(100)
                        TriggerServerEvent(("%s:SQLHistorique"):format(_ArmurerieLSPD.Event.Prefix))
                        ESX.ShowNotification("~r~Vous avez supprimé le bon~s~ N° ~b~"..v.id)
                    elseif variable:lower() == "non" or variable:upper() == "NON" then
                        ESX.ShowNotification("~r~Le bon n'a pas été supprimée~s~")
                    end
                end
            })
        end
    end
end

function Animations(name, label)
    for k,v in pairs(_ArmurerieLSPD.PositionsArmurerieLSPD) do 
        SetEntityCoords(PlayerPedId(), v.pos.x, v.pos.y, v.pos.z)
        SetEntityHeading(PlayerPedId(), v.heading)
    end
    animped()
    GiveWeaponToPed(peds, GetHashKey(name), false, true, true)
    Wait(1380)
    animplayer()
    Wait(1000)
    GiveWeaponToPed(PlayerPedId(),GetHashKey(name), 0, true, true)
    Wait(100)
    RemoveWeaponFromPed(peds, GetHashKey(name))
    PlaySoundFrontend(-1, "WEAPON_SELECT_HANDGUN", "HUD_AMMO_SHOP_SOUNDSET", 1)
    Wait(1000)
    TriggerServerEvent(("%s:addWeapon"):format(_ArmurerieLSPD.Event.Prefix), name, label)
    Wait(100)
    TriggerServerEvent(("%s:SQLArmurerie"):format(_ArmurerieLSPD.Event.Prefix))
    Wait(100)
    TriggerServerEvent(("%s:InsertSQLHistorique_"):format(_ArmurerieLSPD.Event.Prefix),"[~r~-1~s~]", label)
end